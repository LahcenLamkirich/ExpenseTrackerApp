import 'package:drift/drift.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

class TransactionRepository {
  TransactionRepository(this._db);

  final AppDatabase _db;

  /// Transactions whose date falls in `[from, to)`, newest first.
  Stream<List<TransactionRecord>> watch({DateTime? from, DateTime? to}) {
    final query = _db.select(_db.transactions)
      ..orderBy([
        (t) => OrderingTerm.desc(t.date),
        (t) => OrderingTerm.desc(t.createdAt),
      ]);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerThanValue(to));
    return query.watch().map((rows) => rows.map(_toRecord).toList());
  }

  Future<TransactionRecord?> get(String id) async {
    final row = await (_db.select(
      _db.transactions,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toRecord(row);
  }

  /// The [limit] most recent transactions.
  Stream<List<TransactionRecord>> watchRecent({int limit = 5}) {
    final query = _db.select(_db.transactions)
      ..orderBy([(t) => OrderingTerm.desc(t.date), (t) => OrderingTerm.desc(t.createdAt)])
      ..limit(limit);
    return query.watch().map((rows) => rows.map(_toRecord).toList());
  }

  /// Every currency code referenced by transactions (original or home).
  Stream<Set<String>> watchCurrencyCodes() => _db
      .customSelect(
        'SELECT currency_code AS c FROM transactions '
        'UNION SELECT home_currency_code AS c FROM transactions',
        readsFrom: {_db.transactions},
      )
      .watch()
      .map((rows) => {for (final r in rows) r.read<String>('c')});

  /// Inserts or replaces [record] (create, edit and undo-restore).
  Future<void> save(TransactionRecord record) =>
      _db.into(_db.transactions).insertOnConflictUpdate(_toCompanion(record));

  /// Deletes and returns the removed record so the UI can offer undo.
  Future<TransactionRecord?> delete(String id) async {
    final existing = await get(id);
    if (existing == null) return null;
    await (_db.delete(_db.transactions)..where((t) => t.id.equals(id))).go();
    return existing;
  }

  static TransactionRecord _toRecord(TransactionRow r) => TransactionRecord(
    id: r.id,
    type: r.type,
    title: r.title,
    amount: Money.ofCode(r.amountMinor, r.currencyCode),
    fxRate: r.fxRate,
    homeAmount: Money.ofCode(r.homeAmountMinor, r.homeCurrencyCode),
    rateSource: r.rateSource,
    categoryId: r.categoryId,
    paymentMethod: r.paymentMethod,
    date: r.date,
    note: r.note,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  static TransactionsCompanion _toCompanion(TransactionRecord t) =>
      TransactionsCompanion.insert(
        id: t.id,
        type: t.type,
        title: Value(t.title),
        amountMinor: t.amount.minor,
        currencyCode: t.amount.currencyCode,
        homeCurrencyCode: t.homeAmount.currencyCode,
        fxRate: t.fxRate,
        homeAmountMinor: t.homeAmount.minor,
        rateSource: t.rateSource,
        categoryId: t.categoryId,
        paymentMethod: t.paymentMethod,
        date: t.date,
        note: Value(t.note),
        createdAt: t.createdAt,
        updatedAt: t.updatedAt,
      );
}

@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) =>
    TransactionRepository(ref.watch(appDatabaseProvider));
