import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/currencies/domain/exchange_rate_repository.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/domain/remote_rate_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'drift_exchange_rate_repository.g.dart';

class DriftExchangeRateRepository implements ExchangeRateRepository {
  DriftExchangeRateRepository(this._db, this._clock);

  final AppDatabase _db;
  final Clock _clock;

  static const manualProvider = 'manual';

  /// How many recent snapshots are scanned for a pair before giving up.
  static const _scanLimit = 60;

  @override
  Future<RateQuote?> findRate(String from, String to, {DateTime? at}) async {
    final fromCode = from.toUpperCase();
    final toCode = to.toUpperCase();
    if (fromCode == toCode) {
      final c = CurrencyCatalog.of(fromCode);
      return RateQuote(
        rate: ExchangeRate.identity(c),
        fetchedAt: at ?? _clock.now(),
        isManual: false,
      );
    }
    if (at != null) {
      final historical = await _scan(fromCode, toCode, before: at);
      if (historical != null) return historical;
    }
    return await _scan(fromCode, toCode);
  }

  Future<RateQuote?> _scan(String from, String to, {DateTime? before}) async {
    final query = _db.select(_db.rateSnapshots)
      ..orderBy([
        (s) => OrderingTerm.desc(s.fetchedAt),
        (s) => OrderingTerm.desc(s.id),
      ])
      ..limit(_scanLimit);
    if (before != null) {
      query.where((s) => s.fetchedAt.isSmallerOrEqualValue(before));
    }
    final snapshots = await query.get();
    if (snapshots.isEmpty) return null;

    final entries =
        await (_db.select(_db.rateEntries)..where(
              (e) =>
                  e.snapshotId.isIn(snapshots.map((s) => s.id)) &
                  e.quoteCode.isIn([from, to]),
            ))
            .get();
    final bySnapshot = <int, Map<String, Decimal>>{};
    for (final e in entries) {
      (bySnapshot[e.snapshotId] ??= {})[e.quoteCode] = e.rate;
    }

    for (final s in snapshots) {
      final quotes = bySnapshot[s.id] ?? const {};
      Decimal? baseTo(String code) =>
          code == s.baseCode ? Decimal.one : quotes[code];
      final baseToFrom = baseTo(from);
      final baseToTo = baseTo(to);
      if (baseToFrom == null || baseToTo == null) continue;
      if (baseToFrom <= Decimal.zero || baseToTo <= Decimal.zero) continue;
      return RateQuote(
        rate: ExchangeRate.cross(
          from: CurrencyCatalog.of(from),
          to: CurrencyCatalog.of(to),
          baseToFrom: baseToFrom,
          baseToTo: baseToTo,
        ),
        fetchedAt: s.fetchedAt,
        isManual: s.isManual,
      );
    }
    return null;
  }

  @override
  Future<RateQuote> saveManualRate(String from, String to, Decimal rate) async {
    final fromCode = from.toUpperCase();
    final toCode = to.toUpperCase();
    final exchangeRate = ExchangeRate(
      from: CurrencyCatalog.of(fromCode),
      to: CurrencyCatalog.of(toCode),
      rate: rate,
    );
    final now = _clock.now();
    await _db.transaction(() async {
      final id = await _db
          .into(_db.rateSnapshots)
          .insert(
            RateSnapshotsCompanion.insert(
              baseCode: fromCode,
              fetchedAt: now,
              provider: manualProvider,
              isManual: const Value(true),
            ),
          );
      await _db
          .into(_db.rateEntries)
          .insert(
            RateEntriesCompanion.insert(
              snapshotId: id,
              quoteCode: toCode,
              rate: rate,
            ),
          );
    });
    return RateQuote(rate: exchangeRate, fetchedAt: now, isManual: true);
  }

  @override
  Stream<void> watchChanges() => _db
      .tableUpdates(TableUpdateQuery.onTable(_db.rateSnapshots))
      .map((_) {});

  @override
  Stream<RateTable> watchTable(Set<String> codes) {
    final upper = {for (final c in codes) c.toUpperCase()};
    final snapshotsQuery = _db.select(_db.rateSnapshots)
      ..orderBy([(s) => OrderingTerm.desc(s.fetchedAt)]);
    // Re-load whenever snapshots change (entries change with them).
    return snapshotsQuery.watch().asyncMap((snapshots) async {
      if (snapshots.isEmpty) return RateTable.empty;
      final entries = await (_db.select(_db.rateEntries)..where((e) => e.quoteCode.isIn(upper))).get();
      final bySnapshot = <int, Map<String, Decimal>>{};
      for (final e in entries) {
        (bySnapshot[e.snapshotId] ??= {})[e.quoteCode] = e.rate;
      }
      return RateTable([
        for (final s in snapshots)
          RateSnapshot(
            id: s.id,
            base: s.baseCode,
            fetchedAt: s.fetchedAt,
            isManual: s.isManual,
            rates: bySnapshot[s.id] ?? const {},
          ),
      ]);
    });
  }

  @override
  Future<DateTime?> lastRemoteFetch() async {
    final row =
        await (_db.select(_db.rateSnapshots)
              ..where((s) => s.isManual.equals(false))
              ..orderBy([(s) => OrderingTerm.desc(s.fetchedAt)])
              ..limit(1))
            .getSingleOrNull();
    return row?.fetchedAt;
  }

  @override
  Future<void> saveRemote(RemoteRates rates) => _db.transaction(() async {
    final id = await _db
        .into(_db.rateSnapshots)
        .insert(
          RateSnapshotsCompanion.insert(
            baseCode: rates.base,
            fetchedAt: _clock.now(),
            providerUpdatedAt: Value(rates.providerUpdatedAt),
            provider: rates.provider,
          ),
        );
    await _db.batch(
      (b) => b.insertAll(_db.rateEntries, [
        for (final MapEntry(:key, :value) in rates.rates.entries)
          if (key != rates.base && key.length == 3)
            RateEntriesCompanion.insert(snapshotId: id, quoteCode: key, rate: value),
      ]),
    );
  });

  @override
  Future<void> prune({
    Duration keepAllFor = const Duration(days: 30),
    Duration maxAge = const Duration(days: 730),
  }) => _db.transaction(() async {
    final now = _clock.now();
    final keepAllAfter = now.subtract(keepAllFor);
    await (_db.delete(_db.rateSnapshots)..where((s) => s.fetchedAt.isSmallerThanValue(now.subtract(maxAge)))).go();

    final older =
        await (_db.select(_db.rateSnapshots)
              ..where((s) => s.fetchedAt.isSmallerThanValue(keepAllAfter))
              ..orderBy([(s) => OrderingTerm.desc(s.fetchedAt)]))
            .get();
    final seenDays = <(DateTime, bool)>{};
    final toDelete = <int>[];
    for (final s in older) {
      final key = (DateTime(s.fetchedAt.year, s.fetchedAt.month, s.fetchedAt.day), s.isManual);
      // Newest first, so the first snapshot of each day (per kind) survives.
      if (!seenDays.add(key)) toDelete.add(s.id);
    }
    if (toDelete.isNotEmpty) {
      await (_db.delete(_db.rateSnapshots)..where((s) => s.id.isIn(toDelete))).go();
    }
  });
}

@Riverpod(keepAlive: true)
ExchangeRateRepository exchangeRateRepository(Ref ref) =>
    DriftExchangeRateRepository(
      ref.watch(appDatabaseProvider),
      ref.watch(clockProvider),
    );
