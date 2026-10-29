import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter/foundation.dart';

/// One cached snapshot: `1 base = rates[code] code`.
@immutable
class RateSnapshot {
  const RateSnapshot({
    required this.id,
    required this.base,
    required this.fetchedAt,
    required this.isManual,
    required this.rates,
  });

  final int id;
  final String base;
  final DateTime fetchedAt;
  final bool isManual;
  final Map<String, Decimal> rates;

  Decimal? baseTo(String code) => code == base ? Decimal.one : rates[code];

  /// `from → to` through this snapshot's base, or null if it can't price both.
  ExchangeRate? rate(Currency from, Currency to) {
    if (from.code == to.code) return ExchangeRate.identity(from);
    final a = baseTo(from.code);
    final b = baseTo(to.code);
    if (a == null || b == null || a <= Decimal.zero || b <= Decimal.zero) return null;
    return ExchangeRate.cross(from: from, to: to, baseToFrom: a, baseToTo: b);
  }
}

/// In-memory view of cached snapshots (newest first) for synchronous
/// conversions in aggregations and charts.
@immutable
class RateTable {
  RateTable(List<RateSnapshot> snapshots)
    : snapshots = List<RateSnapshot>.unmodifiable(
        <RateSnapshot>[...snapshots]..sort((a, b) => b.fetchedAt.compareTo(a.fetchedAt)),
      );

  static final empty = RateTable(const []);

  final List<RateSnapshot> snapshots;

  bool get isEmpty => snapshots.isEmpty;

  /// Newest snapshot fetched from a provider (not entered by hand).
  RateSnapshot? get latestRemote => snapshots.where((s) => !s.isManual).firstOrNull;

  RateSnapshot? get latest => snapshots.firstOrNull;

  /// Newest rate, or with [at] the newest taken on or before [at] (falling
  /// back to the newest overall).
  ExchangeRate? rate(Currency from, Currency to, {DateTime? at}) {
    if (from.code == to.code) return ExchangeRate.identity(from);
    if (at != null) {
      for (final s in snapshots) {
        if (s.fetchedAt.isAfter(at)) continue;
        final r = s.rate(from, to);
        if (r != null) return r;
      }
    }
    for (final s in snapshots) {
      final r = s.rate(from, to);
      if (r != null) return r;
    }
    return null;
  }

  Money? convert(Money amount, Currency to, DateTime at) => rate(amount.currency, to, at: at)?.convert(amount);

  /// Rate `from → to` around [daysAgo] days before the newest snapshot, used
  /// for the "+0.14%" change chips.
  ExchangeRate? rateDaysBefore(Currency from, Currency to, int daysAgo) {
    final newest = latestRemote;
    if (newest == null) return null;
    final target = newest.fetchedAt.subtract(Duration(days: daysAgo));
    for (final s in snapshots) {
      if (s.isManual || s.fetchedAt.isAfter(target)) continue;
      final r = s.rate(from, to);
      if (r != null) return r;
    }
    return null;
  }

  /// One rate per day for the last [days] days with data (oldest first).
  List<Decimal> dailyHistory(Currency from, Currency to, {int days = 7}) {
    final byDay = <DateTime, Decimal>{};
    for (final s in snapshots) {
      if (s.isManual) continue;
      final day = DateTime(s.fetchedAt.year, s.fetchedAt.month, s.fetchedAt.day);
      if (byDay.containsKey(day)) continue; // snapshots are newest first
      final r = s.rate(from, to);
      if (r != null) byDay[day] = r.rate;
      if (byDay.length >= days) break;
    }
    final keys = byDay.keys.toList()..sort();
    return [for (final k in keys) byDay[k]!];
  }
}
