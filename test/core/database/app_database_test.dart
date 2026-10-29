import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/database/default_categories.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  TransactionsCompanion tx({
    String id = 't1',
    int amountMinor = 24000,
    String categoryId = 'cat_dining',
    String fxRate = '10.84',
  }) {
    final now = DateTime(2026, 10, 24, 12);
    return TransactionsCompanion.insert(
      id: id,
      type: TransactionType.expense,
      amountMinor: amountMinor,
      currencyCode: 'EUR',
      homeCurrencyCode: 'MAD',
      fxRate: Decimal.parse(fxRate),
      homeAmountMinor: 260160,
      rateSource: RateSource.api,
      categoryId: categoryId,
      paymentMethod: PaymentMethod.card,
      date: now,
      createdAt: now,
      updatedAt: now,
    );
  }

  test('seeds the default categories on create', () async {
    final rows = await db.select(db.categories).get();
    expect(rows, hasLength(defaultCategories.length));
    expect(rows.map((r) => r.id), contains('cat_dining'));
    expect(rows.where((r) => r.kind == CategoryKind.income), isNotEmpty);
  });

  test('stores exchange rates as exact decimal text', () async {
    await db.into(db.transactions).insert(tx(fxRate: '10.845123456789'));
    final row = await db.select(db.transactions).getSingle();
    expect(row.fxRate, Decimal.parse('10.845123456789'));
    expect(row.amountMinor, 24000);
    expect(row.type, TransactionType.expense);

    final raw = await db.customSelect('SELECT fx_rate FROM transactions').getSingle();
    expect(raw.read<String>('fx_rate'), '10.845123456789');
  });

  test('rejects non-positive amounts', () async {
    await expectLater(
      db.into(db.transactions).insert(tx(amountMinor: 0)),
      throwsA(isA<SqliteException>()),
    );
  });

  test('enforces the category foreign key', () async {
    await expectLater(
      db.into(db.transactions).insert(tx(categoryId: 'missing')),
      throwsA(isA<SqliteException>()),
    );
  });

  test('rate entries cascade when a snapshot is deleted', () async {
    final snapshotId = await db
        .into(db.rateSnapshots)
        .insert(
          RateSnapshotsCompanion.insert(
            baseCode: 'MAD',
            fetchedAt: DateTime(2026, 10, 24),
            provider: 'test',
          ),
        );
    await db
        .into(db.rateEntries)
        .insert(
          RateEntriesCompanion.insert(
            snapshotId: snapshotId,
            quoteCode: 'EUR',
            rate: Decimal.parse('0.0922'),
          ),
        );
    await (db.delete(db.rateSnapshots)..where((s) => s.id.equals(snapshotId))).go();
    expect(await db.select(db.rateEntries).get(), isEmpty);
  });

  test('wipe removes user data and restores default categories', () async {
    await db.into(db.transactions).insert(tx());
    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            id: 'custom',
            name: const Value('Coffee'),
            glyph: '☕',
            colorValue: 0xFFFCC419,
            kind: CategoryKind.expense,
          ),
        );

    await db.wipe();

    expect(await db.select(db.transactions).get(), isEmpty);
    final categories = await db.select(db.categories).get();
    expect(categories, hasLength(defaultCategories.length));
    expect(categories.map((c) => c.id), isNot(contains('custom')));
  });
}
