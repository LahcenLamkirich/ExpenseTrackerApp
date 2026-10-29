import 'dart:async';

import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/currencies/data/drift_exchange_rate_repository.dart';
import 'package:flossi/features/currencies/data/er_api_rate_source.dart';
import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/domain/remote_rate_source.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rate_providers.g.dart';

@Riverpod(keepAlive: true)
http.Client httpClient(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
}

/// The active rate provider. Swap the implementation here.
@Riverpod(keepAlive: true)
RemoteRateSource remoteRateSource(Ref ref) => ErApiRateSource(ref.watch(httpClientProvider));

@immutable
class RateSyncState {
  const RateSyncState({this.lastFetch, this.refreshing = false, this.failed = false, this.loaded = false});

  /// When rates were last fetched from the provider (null = never).
  final DateTime? lastFetch;
  final bool refreshing;

  /// The last refresh attempt failed (offline or provider error).
  final bool failed;

  /// Whether [lastFetch] has been read from the cache yet.
  final bool loaded;

  RateSyncState copyWith({DateTime? lastFetch, bool? refreshing, bool? failed}) => RateSyncState(
    lastFetch: lastFetch ?? this.lastFetch,
    refreshing: refreshing ?? this.refreshing,
    failed: failed ?? this.failed,
    loaded: true,
  );
}

/// Keeps cached rates fresh: refreshes on start and on resume when the
/// newest provider snapshot is older than [maxAge]. Failures are silent —
/// the app keeps working from the cache.
@Riverpod(keepAlive: true)
class RateSync extends _$RateSync {
  static const maxAge = Duration(hours: 12);

  @override
  RateSyncState build() {
    unawaited(Future.microtask(refreshIfStale));
    return const RateSyncState();
  }

  Future<void> refreshIfStale() => _refresh(force: false);

  Future<void> refreshNow() => _refresh(force: true);

  Future<void> _refresh({required bool force}) async {
    if (state.refreshing) return;
    final repo = ref.read(exchangeRateRepositoryProvider);
    final last = await repo.lastRemoteFetch();
    state = state.copyWith(lastFetch: last);
    final now = ref.read(clockProvider).now();
    if (!force && last != null && now.difference(last) < maxAge) return;

    state = state.copyWith(refreshing: true);
    try {
      final home = ref.read(homeCurrencyProvider);
      final rates = await ref.read(remoteRateSourceProvider).fetchLatest(home.code);
      await repo.saveRemote(rates);
      await repo.prune();
      state = RateSyncState(lastFetch: ref.read(clockProvider).now(), loaded: true);
    } on Object catch (e) {
      debugPrint('Rate refresh failed: $e');
      state = state.copyWith(refreshing: false, failed: true);
    }
  }
}

/// Codes worth keeping in memory: home, tracked, and any used in history.
@Riverpod(keepAlive: true)
Stream<Set<String>> relevantCurrencyCodes(Ref ref) {
  final home = ref.watch(homeCurrencyProvider).code;
  final tracked = ref.watch(allTrackedCurrenciesProvider).value ?? const [];
  return ref
      .watch(transactionRepositoryProvider)
      .watchCurrencyCodes()
      .map((used) => {home, ...used, for (final (c, _) in tracked) c.code});
}

/// In-memory rate table for synchronous conversions (charts, totals).
@Riverpod(keepAlive: true)
Stream<RateTable> rateTable(Ref ref) async* {
  final codes = await ref.watch(relevantCurrencyCodesProvider.future);
  yield* ref.watch(exchangeRateRepositoryProvider).watchTable(codes);
}
