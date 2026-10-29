import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/stats/domain/spending_analytics.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/features/transactions/presentation/transaction_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stats_providers.g.dart';

@immutable
class StatsQuery {
  const StatsQuery({this.period = StatsPeriod.month, this.custom, this.viewCurrency});

  final StatsPeriod period;
  final DateSpan? custom;

  /// Null = the home currency.
  final Currency? viewCurrency;

  StatsQuery copyWith({StatsPeriod? period, DateSpan? custom, Currency? Function()? viewCurrency}) => StatsQuery(
    period: period ?? this.period,
    custom: custom ?? this.custom,
    viewCurrency: viewCurrency == null ? this.viewCurrency : viewCurrency(),
  );
}

@Riverpod(keepAlive: true)
class StatsQueryController extends _$StatsQueryController {
  @override
  StatsQuery build() => const StatsQuery();

  void setPeriod(StatsPeriod p) => state = state.copyWith(period: p);
  void setCustom(DateSpan span) => state = state.copyWith(period: StatsPeriod.custom, custom: span);
  void setViewCurrency(Currency? c) => state = state.copyWith(viewCurrency: () => c);
}

/// Stats for the selected period, in the selected view currency.
@riverpod
Future<PeriodStats> periodStats(Ref ref) async {
  final query = ref.watch(statsQueryControllerProvider);
  final now = ref.watch(clockProvider).now();
  final home = ref.watch(homeCurrencyProvider);
  final target = query.viewCurrency ?? home;
  final table = ref.watch(rateTableProvider).value ?? RateTable.empty;
  final span = spanFor(query.period, now, custom: query.custom);
  final previous = previousSpan(span, query.period);
  final txs = await ref.watch(transactionsInSpanProvider(DateSpan(previous.start, span.end)).future);

  return computeStats(
    current: txs.where((t) => span.contains(t.date)).toList(),
    previous: txs.where((t) => previous.contains(t.date)).toList(),
    resolver: HomeAmountResolver(target, convert: table.convert),
    span: span,
    buckets: bucketsFor(span, query.period),
  );
}
