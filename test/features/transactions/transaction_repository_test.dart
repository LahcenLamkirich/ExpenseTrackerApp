import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  late AppDatabase db;
  late TransactionRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = TransactionRepository(db);
  });
  tearDown(() => db.close());

  test('round-trips money, frozen rate and metadata exactly', () async {
    final t = makeTransaction(
      amount: Money.ofCode(24000, 'EUR'),
      homeAmount: Money.ofCode(260160, 'MAD'),
      fxRate: '10.84',
      title: 'Dinner',
      note: 'With Sarah',
    );
    await repo.save(t);
    final loaded = (await repo.get(t.id))!;
    expect(loaded, t);
    expect(loaded.fxRate, Decimal.parse('10.84'));
    expect(loaded.isConverted, isTrue);
  });

  test('watch filters by date span and sorts newest first', () async {
    await repo.save(makeTransaction(id: 'sep', date: DateTime(2026, 9, 30, 23)));
    await repo.save(makeTransaction(id: 'oct1', date: DateTime(2026, 10)));
    await repo.save(makeTransaction(id: 'oct24', date: DateTime(2026, 10, 24)));
    await repo.save(makeTransaction(id: 'nov', date: DateTime(2026, 11)));

    final october = await repo.watch(from: DateTime(2026, 10), to: DateTime(2026, 11)).first;
    expect(october.map((t) => t.id), ['oct24', 'oct1']);
    expect(await repo.watch().first, hasLength(4));
  });

  test('save updates in place (edit)', () async {
    final t = makeTransaction();
    await repo.save(t);
    await repo.save(t.copyWith(title: 'Espresso Lab', amount: Money.ofCode(5000, 'MAD'), homeAmount: Money.ofCode(5000, 'MAD')));
    final all = await repo.watch().first;
    expect(all, hasLength(1));
    expect(all.single.title, 'Espresso Lab');
    expect(all.single.amount.minor, 5000);
  });

  test('delete returns the record so undo can restore it', () async {
    final t = makeTransaction(title: 'Undo me');
    await repo.save(t);
    final removed = await repo.delete(t.id);
    expect(removed, t);
    expect(await repo.get(t.id), isNull);
    await repo.save(removed!);
    expect(await repo.get(t.id), t);
    expect(await repo.delete('missing'), isNull);
  });
}
