import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/domain/remote_rate_source.dart';
import 'package:flutter/foundation.dart';

/// A rate resolved from the local cache, with its provenance.
@immutable
class RateQuote {
  const RateQuote({
    required this.rate,
    required this.fetchedAt,
    required this.isManual,
  });

  final ExchangeRate rate;
  final DateTime fetchedAt;
  final bool isManual;
}

/// Source of exchange rates for conversions.
///
/// Implementations resolve rates from cached snapshots (any base currency,
/// using cross rates) so the app works fully offline. Remote refresh is
/// layered on top in the rate-sync service.
abstract interface class ExchangeRateRepository {
  /// Best rate for `from → to`.
  ///
  /// With [at], prefers the newest snapshot taken on or before that moment
  /// (historical conversion) and falls back to the newest overall. Returns
  /// null when no cached snapshot can price both currencies.
  Future<RateQuote?> findRate(String from, String to, {DateTime? at});

  /// Stores a user-entered rate `1 from = rate to` as a manual snapshot.
  Future<RateQuote> saveManualRate(String from, String to, Decimal rate);

  /// Emits whenever snapshots change, so dependents can re-resolve.
  Stream<void> watchChanges();

  /// Live in-memory table of snapshots, limited to [codes] to keep it small.
  Stream<RateTable> watchTable(Set<String> codes);

  /// When the newest provider snapshot was fetched (null = never).
  Future<DateTime?> lastRemoteFetch();

  /// Stores a provider response as a new snapshot.
  Future<void> saveRemote(RemoteRates rates);

  /// Keeps every snapshot from the last [keepAllFor], one per day before
  /// that, and nothing older than [maxAge].
  Future<void> prune({
    Duration keepAllFor = const Duration(days: 30),
    Duration maxAge = const Duration(days: 730),
  });
}
