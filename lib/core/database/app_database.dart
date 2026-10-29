import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flossi/core/database/default_categories.dart';
import 'package:flossi/core/database/tables.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Categories, Transactions, RateSnapshots, RateEntries, TrackedCurrencies],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  static const fileName = 'flossi';

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await seedDefaultCategories(this);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Deletes every row (Settings → Reset data) and re-seeds defaults.
  Future<void> wipe() => transaction(() async {
    await delete(transactions).go();
    await delete(rateEntries).go();
    await delete(rateSnapshots).go();
    await delete(trackedCurrencies).go();
    await delete(categories).go();
    await seedDefaultCategories(this);
  });

  /// Native SQLite on iOS/Android; on web (dev previews) a WASM build of
  /// SQLite persisted in the browser, using assets shipped in `web/`.
  static QueryExecutor _openConnection() => driftDatabase(
    name: fileName,
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.js'),
    ),
  );
}

/// App-wide database. Overridden with an in-memory database in tests.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
}
