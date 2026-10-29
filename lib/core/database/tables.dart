import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:flossi/core/domain/enums.dart';

/// Exchange rates are persisted as exact decimal strings, never REAL.
class DecimalConverter extends TypeConverter<Decimal, String> {
  const DecimalConverter();

  @override
  Decimal fromSql(String fromDb) => Decimal.parse(fromDb);

  @override
  String toSql(Decimal value) => value.toString();
}

@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();

  /// ARB key for built-in categories (localized at display time).
  TextColumn get nameKey => text().nullable()();

  /// User-entered name; overrides [nameKey] when set.
  TextColumn get name => text().nullable()();

  /// Emoji glyph shown in the category badge.
  TextColumn get glyph => text()();

  /// ARGB colour.
  IntColumn get colorValue => integer()();
  IntColumn get kind => intEnum<CategoryKind>()();

  /// Optional monthly cap in the home currency's minor units.
  IntColumn get monthlyCapMinor => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  /// Soft delete: archived categories keep history intact.
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('TransactionRow')
@TableIndex(name: 'transactions_date_idx', columns: {#date})
@TableIndex(name: 'transactions_category_date_idx', columns: {#categoryId, #date})
@TableIndex(name: 'transactions_currency_idx', columns: {#currencyCode})
class Transactions extends Table {
  TextColumn get id => text()();
  IntColumn get type => intEnum<TransactionType>()();

  /// Merchant / payee, e.g. "Espresso Lab".
  TextColumn get title => text().nullable()();

  /// Original amount in minor units of [currencyCode]; always positive,
  /// the sign comes from [type].
  // Drift check-constraint idiom: the getter references its own column.
  // ignore: recursive_getters
  IntColumn get amountMinor => integer().check(amountMinor.isBiggerThanValue(0))();
  TextColumn get currencyCode => text().withLength(min: 3, max: 3)();

  /// Home currency at the time the transaction was recorded.
  TextColumn get homeCurrencyCode => text().withLength(min: 3, max: 3)();

  /// Rate `currencyCode → homeCurrencyCode` frozen at transaction time.
  TextColumn get fxRate => text().map(const DecimalConverter())();

  /// Converted amount in [homeCurrencyCode] minor units, frozen.
  IntColumn get homeAmountMinor => integer()();
  IntColumn get rateSource => intEnum<RateSource>()();
  TextColumn get categoryId => text().references(Categories, #id)();
  IntColumn get paymentMethod => intEnum<PaymentMethod>()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// One fetch (or manual entry) of rates against [baseCode].
@DataClassName('RateSnapshotRow')
@TableIndex(name: 'rate_snapshots_fetched_idx', columns: {#fetchedAt})
class RateSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get baseCode => text().withLength(min: 3, max: 3)();
  DateTimeColumn get fetchedAt => dateTime()();

  /// Provider's own "last updated" timestamp, when available.
  DateTimeColumn get providerUpdatedAt => dateTime().nullable()();
  TextColumn get provider => text()();
  BoolColumn get isManual => boolean().withDefault(const Constant(false))();
}

/// `1 base = rate quote` for one snapshot.
@DataClassName('RateEntryRow')
class RateEntries extends Table {
  IntColumn get snapshotId =>
      integer().references(RateSnapshots, #id, onDelete: KeyAction.cascade)();
  TextColumn get quoteCode => text().withLength(min: 3, max: 3)();
  TextColumn get rate => text().map(const DecimalConverter())();

  @override
  Set<Column<Object>> get primaryKey => {snapshotId, quoteCode};
}

/// Currencies the user works with (Add Expense chip strip, Currencies screen).
@DataClassName('TrackedCurrencyRow')
class TrackedCurrencies extends Table {
  TextColumn get code => text().withLength(min: 3, max: 3)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {code};
}
