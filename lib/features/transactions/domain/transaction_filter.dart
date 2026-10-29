import 'package:collection/collection.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_filter.freezed.dart';

/// Inclusive-start, exclusive-end range of local dates.
@immutable
class DateSpan {
  const DateSpan(this.start, this.end);

  factory DateSpan.month(DateTime anyDay) => DateSpan(
    DateTime(anyDay.year, anyDay.month),
    DateTime(anyDay.year, anyDay.month + 1),
  );

  /// From [first] to [last] inclusive (whole days).
  factory DateSpan.days(DateTime first, DateTime last) => DateSpan(
    DateTime(first.year, first.month, first.day),
    DateTime(last.year, last.month, last.day + 1),
  );

  final DateTime start;
  final DateTime end;

  bool contains(DateTime t) => !t.isBefore(start) && t.isBefore(end);

  /// Last included day.
  DateTime get lastDay => DateTime(end.year, end.month, end.day - 1);

  @override
  bool operator ==(Object other) =>
      other is DateSpan && other.start == start && other.end == end;

  @override
  int get hashCode => Object.hash(start, end);
}

@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    @Default('') String query,
    @Default(<String>{}) Set<String> categoryIds,
    @Default(<String>{}) Set<String> currencyCodes,
    TransactionType? type,
    DateSpan? span,
  }) = _TransactionFilter;

  const TransactionFilter._();

  bool get hasRefinements =>
      categoryIds.isNotEmpty || currencyCodes.isNotEmpty || type != null;

  /// Applies every criterion except [span] (which the query layer handles).
  /// [categoryName] lets search match localized category names.
  bool matches(TransactionRecord t, String Function(String categoryId) categoryName) {
    if (type != null && t.type != type) return false;
    if (categoryIds.isNotEmpty && !categoryIds.contains(t.categoryId)) return false;
    if (currencyCodes.isNotEmpty && !currencyCodes.contains(t.currency.code)) return false;
    if (span != null && !span!.contains(t.date)) return false;
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return (t.title?.toLowerCase().contains(q) ?? false) ||
        (t.note?.toLowerCase().contains(q) ?? false) ||
        categoryName(t.categoryId).toLowerCase().contains(q) ||
        t.currency.code.toLowerCase() == q;
  }
}

/// Transactions of one calendar day with their net total.
@immutable
class DayGroup {
  const DayGroup({required this.day, required this.items, required this.net, required this.approximate});

  final DateTime day;
  final List<TransactionRecord> items;

  /// Income minus expenses in the home currency (unresolved items skipped).
  final Money net;

  /// Whether any item needed a re-conversion or conversion.
  final bool approximate;
}

/// Groups [items] by local day (newest first) and totals each day.
List<DayGroup> groupByDay(List<TransactionRecord> items, HomeAmountResolver resolver) {
  final sorted = [...items]..sort((a, b) => b.date.compareTo(a.date));
  final groups = groupBy(sorted, (t) => DateTime(t.date.year, t.date.month, t.date.day));
  return [
    for (final MapEntry(key: day, value: list) in groups.entries)
      () {
        var net = Money.zero(resolver.home);
        var approximate = false;
        for (final t in list) {
          final r = resolver.resolve(t);
          if (r == null) {
            approximate = true;
            continue;
          }
          net += r.amount.times(t.sign);
          approximate = approximate || t.isConverted || r.isApproximate;
        }
        return DayGroup(day: day, items: list, net: net, approximate: approximate);
      }(),
  ];
}
