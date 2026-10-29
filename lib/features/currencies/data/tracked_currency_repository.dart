import 'package:drift/drift.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tracked_currency_repository.g.dart';

/// Currencies the user works with, in display order.
class TrackedCurrencyRepository {
  TrackedCurrencyRepository(this._db);

  final AppDatabase _db;

  /// All tracked currencies (enabled or not), in display order.
  Stream<List<(Currency, bool)>> watchAll() {
    final query = _db.select(_db.trackedCurrencies)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return query.watch().map((rows) => [for (final r in rows) (CurrencyCatalog.of(r.code), r.isEnabled)]);
  }

  Stream<List<Currency>> watchEnabled() {
    final query = _db.select(_db.trackedCurrencies)
      ..where((t) => t.isEnabled.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]);
    return query.watch().map(
      (rows) => [for (final r in rows) CurrencyCatalog.of(r.code)],
    );
  }

  /// Adds any of [codes] not tracked yet (appended in the given order) and
  /// re-enables ones that were disabled.
  Future<void> ensure(Iterable<String> codes) => _db.transaction(() async {
    final existing = {
      for (final r in await _db.select(_db.trackedCurrencies).get()) r.code: r,
    };
    var next = existing.values.fold<int>(
      -1,
      (max, r) => r.sortOrder > max ? r.sortOrder : max,
    );
    for (final raw in codes) {
      final code = raw.toUpperCase();
      final row = existing[code];
      if (row == null) {
        next++;
        await _db
            .into(_db.trackedCurrencies)
            .insert(
              TrackedCurrenciesCompanion.insert(
                code: code,
                sortOrder: Value(next),
              ),
            );
        existing[code] = TrackedCurrencyRow(
          code: code,
          sortOrder: next,
          isEnabled: true,
        );
      } else if (!row.isEnabled) {
        await setEnabled(code, enabled: true);
      }
    }
  });

  Future<void> setEnabled(String code, {required bool enabled}) =>
      (_db.update(_db.trackedCurrencies)
            ..where((t) => t.code.equals(code.toUpperCase())))
          .write(TrackedCurrenciesCompanion(isEnabled: Value(enabled)));
}

@Riverpod(keepAlive: true)
TrackedCurrencyRepository trackedCurrencyRepository(Ref ref) =>
    TrackedCurrencyRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Currency>> trackedCurrencies(Ref ref) =>
    ref.watch(trackedCurrencyRepositoryProvider).watchEnabled();

@riverpod
Stream<List<(Currency, bool)>> allTrackedCurrencies(Ref ref) =>
    ref.watch(trackedCurrencyRepositoryProvider).watchAll();
