import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/stats/domain/spending_analytics.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flossi/features/transactions/presentation/transaction_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_providers.g.dart';

class DashboardData {
  const DashboardData({
    required this.month,
    required this.week,
    required this.budget,
    required this.daysLeft,
    required this.todayIndex,
    required this.daysElapsedInWeek,
  });

  /// This month (vs the same days of last month).
  final PeriodStats month;

  /// This week, one bucket per day (Monday first).
  final PeriodStats week;
  final Money? budget;
  final int daysLeft;
  final int todayIndex;
  final int daysElapsedInWeek;

  Money? get remaining => budget == null ? null : budget! - month.total;
  double get budgetRatio => budget == null || budget!.isZero ? 0 : month.total.ratioTo(budget!);

  /// Average spend per elapsed day this week.
  Money get weekDailyAverage => week.total.allocate(daysElapsedInWeek).last;
}

@riverpod
Future<DashboardData> dashboard(Ref ref) async {
  final now = ref.watch(clockProvider).now();
  final resolver = ref.watch(homeAmountResolverProvider);
  final budgetMinor = ref.watch(settingsControllerProvider.select((s) => s.monthlyBudgetMinor));

  final month = DateSpan.month(now);
  final lastMonthStart = DateTime(now.year, now.month - 1);
  // Same window last month: 1st → today's day-of-month (clamped by Dart).
  final lastMonthToDate = DateSpan(lastMonthStart, DateTime(now.year, now.month - 1, now.day + 1));
  final week = spanFor(StatsPeriod.week, now);
  final from = lastMonthStart.isBefore(week.start) ? lastMonthStart : week.start;
  final to = month.end.isAfter(week.end) ? month.end : week.end;
  final txs = await ref.watch(transactionsInSpanProvider(DateSpan(from, to)).future);

  List<TransactionRecord> within(DateSpan s) => txs.where((t) => s.contains(t.date)).toList();

  final monthStats = computeStats(
    current: within(month),
    previous: within(lastMonthToDate),
    resolver: resolver,
    span: month,
    buckets: const [],
  );
  final weekStats = computeStats(
    current: within(week),
    previous: const [],
    resolver: resolver,
    span: week,
    buckets: bucketsFor(week, StatsPeriod.week),
  );

  return DashboardData(
    month: monthStats,
    week: weekStats,
    budget: budgetMinor == null ? null : Money(budgetMinor, resolver.home),
    daysLeft: month.end.difference(DateTime(now.year, now.month, now.day)).inDays,
    todayIndex: now.weekday - DateTime.monday,
    daysElapsedInWeek: now.weekday,
  );
}

@riverpod
Stream<List<TransactionRecord>> recentTransactions(Ref ref) =>
    ref.watch(transactionRepositoryProvider).watchRecent();
