import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/currencies/data/drift_exchange_rate_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  late AppDatabase db;
  late FixedClock clock;
  late DriftExchangeRateRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    clock = FixedClock();
    repo = DriftExchangeRateRepository(db, clock);
  });
  tearDown(() => db.close());

  test('returns null when nothing is cached', () async {
    expect(await repo.findRate('EUR', 'MAD'), isNull);
  });

  test('same currency is an identity rate', () async {
    final q = await repo.findRate('MAD', 'mad');
    expect(q!.rate.isIdentity, isTrue);
  });

  test('uses direct and inverse quotes against the snapshot base', () async {
    await insertSnapshot(db, base: 'MAD', rates: {'EUR': '0.0922', 'USD': '0.0995'}, fetchedAt: DateTime(2026, 10, 24));
    final eurToMad = await repo.findRate('EUR', 'MAD');
    final madToUsd = await repo.findRate('MAD', 'USD');
    expect(eurToMad!.rate.convert(Money.ofCode(10000, 'EUR')).minor, 108460); // 100 / 0.0922
    expect(madToUsd!.rate.rate, Decimal.parse('0.0995'));
  });

  test('derives cross rates between two quotes', () async {
    await insertSnapshot(db, base: 'USD', rates: {'EUR': '0.9268', 'MAD': '10.05'}, fetchedAt: DateTime(2026, 10, 24));
    final q = await repo.findRate('EUR', 'MAD');
    expect(q!.rate.rate.round(scale: 4), Decimal.parse('10.8438'));
  });

  test('prefers the newest snapshot, or the newest before a historical date', () async {
    await insertSnapshot(db, base: 'EUR', rates: {'MAD': '10.50'}, fetchedAt: DateTime(2026, 9));
    await insertSnapshot(db, base: 'EUR', rates: {'MAD': '10.84'}, fetchedAt: DateTime(2026, 10, 20));

    expect((await repo.findRate('EUR', 'MAD'))!.rate.rate, Decimal.parse('10.84'));
    final historical = await repo.findRate('EUR', 'MAD', at: DateTime(2026, 9, 15));
    expect(historical!.rate.rate, Decimal.parse('10.50'));
    // Before any snapshot: falls back to the newest one.
    final early = await repo.findRate('EUR', 'MAD', at: DateTime(2020));
    expect(early!.rate.rate, Decimal.parse('10.84'));
  });

  test('skips snapshots that cannot price the pair', () async {
    await insertSnapshot(db, base: 'EUR', rates: {'MAD': '10.84'}, fetchedAt: DateTime(2026, 10));
    await insertSnapshot(db, base: 'USD', rates: {'GBP': '0.77'}, fetchedAt: DateTime(2026, 10, 20));
    expect((await repo.findRate('EUR', 'MAD'))!.rate.rate, Decimal.parse('10.84'));
  });

  test('manual rates are stored, flagged and then found', () async {
    final saved = await repo.saveManualRate('EUR', 'MAD', Decimal.parse('10.9'));
    expect(saved.isManual, isTrue);
    expect(saved.fetchedAt, clock.now());
    final found = await repo.findRate('EUR', 'MAD');
    expect(found!.isManual, isTrue);
    expect(found.rate.rate, Decimal.parse('10.9'));
    final inverse = await repo.findRate('MAD', 'EUR');
    expect(inverse!.rate.convert(Money.ofCode(1090, 'MAD')).minor, 100);
  });
}
