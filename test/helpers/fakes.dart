import 'package:decimal/decimal.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';

/// Clock frozen at a fixed instant (24 Oct 2026, 12:00 — like the designs).
class FixedClock implements Clock {
  FixedClock([DateTime? now]) : _now = now ?? DateTime(2026, 10, 24, 12);

  final DateTime _now;

  @override
  DateTime now() => _now;
}

/// Inserts a rate snapshot `1 base = rates[code] code`.
Future<void> insertSnapshot(
  AppDatabase db, {
  required String base,
  required Map<String, String> rates,
  required DateTime fetchedAt,
  bool manual = false,
}) async {
  final id = await db
      .into(db.rateSnapshots)
      .insert(
        RateSnapshotsCompanion.insert(
          baseCode: base,
          fetchedAt: fetchedAt,
          provider: manual ? 'manual' : 'test',
        ),
      );
  for (final MapEntry(:key, :value) in rates.entries) {
    await db
        .into(db.rateEntries)
        .insert(RateEntriesCompanion.insert(snapshotId: id, quoteCode: key, rate: Decimal.parse(value)));
  }
}

TransactionRecord makeTransaction({
  String id = 't1',
  TransactionType type = TransactionType.expense,
  Money? amount,
  Money? homeAmount,
  String fxRate = '1',
  String categoryId = 'cat_dining',
  DateTime? date,
  String? title,
  String? note,
}) {
  final when = date ?? DateTime(2026, 10, 24, 9, 42);
  final a = amount ?? Money.ofCode(4500, 'MAD');
  return TransactionRecord(
    id: id,
    type: type,
    amount: a,
    fxRate: Decimal.parse(fxRate),
    homeAmount: homeAmount ?? a,
    rateSource: a.currencyCode == (homeAmount ?? a).currencyCode ? RateSource.identity : RateSource.api,
    categoryId: categoryId,
    paymentMethod: PaymentMethod.card,
    date: when,
    createdAt: when,
    updatedAt: when,
    title: title,
    note: note,
  );
}
