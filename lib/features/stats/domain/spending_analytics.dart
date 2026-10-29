import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flutter/foundation.dart';

enum StatsPeriod { week, month, year, custom }

/// Monday of the week containing [t] (ISO weeks).
DateTime startOfWeek(DateTime t) => DateTime(t.year, t.month, t.day - (t.weekday - DateTime.monday));

/// The span covering [now] for [period] (custom uses [custom]).
DateSpan spanFor(StatsPeriod period, DateTime now, {DateSpan? custom}) => switch (period) {
  StatsPeriod.week => DateSpan(startOfWeek(now), startOfWeek(now).add(const Duration(days: 7))),
  StatsPeriod.month => DateSpan.month(now),
  StatsPeriod.year => DateSpan(DateTime(now.year), DateTime(now.year + 1)),
  StatsPeriod.custom => custom ?? DateSpan.month(now),
};

/// The comparable span right before [span].
DateSpan previousSpan(DateSpan span, StatsPeriod period) {
  final s = span.start;
  return switch (period) {
    StatsPeriod.week => DateSpan(DateTime(s.year, s.month, s.day - 7), s),
    StatsPeriod.month => DateSpan(DateTime(s.year, s.month - 1), s),
    StatsPeriod.year => DateSpan(DateTime(s.year - 1), s),
    StatsPeriod.custom => DateSpan(
      DateTime(s.year, s.month, s.day - span.end.difference(s).inDays),
      s,
    ),
  };
}

/// Chart buckets: days for a week, Oct 1–7 / 8–14 / … for a month, months
/// for a year; custom spans use days up to ~5 weeks, months beyond.
List<DateSpan> bucketsFor(DateSpan span, StatsPeriod period) {
  final days = span.end.difference(span.start).inDays;
  if (period == StatsPeriod.week || (period == StatsPeriod.custom && days <= 35)) {
    return [
      for (var d = span.start; d.isBefore(span.end); d = DateTime(d.year, d.month, d.day + 1))
        DateSpan(d, DateTime(d.year, d.month, d.day + 1)),
    ];
  }
  if (period == StatsPeriod.month) {
    final s = span.start;
    return [
      DateSpan(s, DateTime(s.year, s.month, 8)),
      DateSpan(DateTime(s.year, s.month, 8), DateTime(s.year, s.month, 15)),
      DateSpan(DateTime(s.year, s.month, 15), DateTime(s.year, s.month, 22)),
      DateSpan(DateTime(s.year, s.month, 22), span.end),
    ];
  }
  return [
    for (var m = DateTime(span.start.year, span.start.month); m.isBefore(span.end); m = DateTime(m.year, m.month + 1))
      DateSpan(m, DateTime(m.year, m.month + 1)),
  ];
}

@immutable
class CategoryShare {
  const CategoryShare(this.categoryId, this.amount, this.share);

  final String categoryId;
  final Money amount;

  /// 0..1 of the period total (display only).
  final double share;
}

@immutable
class CurrencySpend {
  const CurrencySpend({required this.currency, required this.original, required this.converted, required this.share});

  final Currency currency;

  /// Sum in the original currency.
  final Money original;

  /// The same spending in the target currency.
  final Money converted;
  final double share;
}

@immutable
class PeriodStats {
  const PeriodStats({
    required this.span,
    required this.total,
    required this.previousTotal,
    required this.byCategory,
    required this.byCurrency,
    required this.series,
    required this.foreignTotal,
    required this.unresolved,
    required this.count,
  });

  final DateSpan span;
  final Money total;
  final Money previousTotal;
  final List<CategoryShare> byCategory;
  final List<CurrencySpend> byCurrency;

  /// One amount per bucket, aligned with [bucketsFor].
  final List<(DateSpan, Money)> series;

  /// Spending originally made in a currency other than the target.
  final Money foreignTotal;
  final int unresolved;
  final int count;

  /// Change vs the previous span as a fraction (null when no baseline).
  double? get change => previousTotal.isZero ? null : (total.minor - previousTotal.minor) / previousTotal.minor;

  double get foreignShare => total.isZero ? 0 : foreignTotal.ratioTo(total);
}

/// Expense analytics for [current] (and [previous] for comparison), with
/// every amount resolved into `resolver.home`.
PeriodStats computeStats({
  required List<TransactionRecord> current,
  required List<TransactionRecord> previous,
  required HomeAmountResolver resolver,
  required DateSpan span,
  required List<DateSpan> buckets,
}) {
  final target = resolver.home;
  final zero = Money.zero(target);
  var total = zero;
  var foreign = zero;
  var unresolved = 0;
  var count = 0;
  final byCategory = <String, Money>{};
  final byCurrencyOriginal = <String, Money>{};
  final byCurrencyConverted = <String, Money>{};
  final series = [for (final b in buckets) (b, zero)];

  for (final t in current) {
    if (!t.isExpense || !span.contains(t.date)) continue;
    final r = resolver.resolve(t);
    if (r == null) {
      unresolved++;
      continue;
    }
    count++;
    final amount = r.amount;
    total += amount;
    if (t.currency.code != target.code) foreign += amount;
    byCategory[t.categoryId] = (byCategory[t.categoryId] ?? zero) + amount;
    final code = t.currency.code;
    byCurrencyOriginal[code] = (byCurrencyOriginal[code] ?? Money.zero(t.currency)) + t.amount;
    byCurrencyConverted[code] = (byCurrencyConverted[code] ?? zero) + amount;
    for (var i = 0; i < series.length; i++) {
      if (series[i].$1.contains(t.date)) {
        series[i] = (series[i].$1, series[i].$2 + amount);
        break;
      }
    }
  }

  var previousTotal = zero;
  for (final t in previous) {
    if (!t.isExpense) continue;
    final r = resolver.resolve(t);
    if (r != null) previousTotal += r.amount;
  }

  double shareOf(Money m) => total.isZero ? 0 : m.ratioTo(total);

  return PeriodStats(
    span: span,
    total: total,
    previousTotal: previousTotal,
    byCategory: [
      for (final MapEntry(:key, :value) in byCategory.entries) CategoryShare(key, value, shareOf(value)),
    ]..sort((a, b) => b.amount.compareTo(a.amount)),
    byCurrency: [
      for (final MapEntry(:key, :value) in byCurrencyConverted.entries)
        CurrencySpend(
          currency: byCurrencyOriginal[key]!.currency,
          original: byCurrencyOriginal[key]!,
          converted: value,
          share: shareOf(value),
        ),
    ]..sort((a, b) => b.converted.compareTo(a.converted)),
    series: series,
    foreignTotal: foreign,
    unresolved: unresolved,
    count: count,
  );
}
