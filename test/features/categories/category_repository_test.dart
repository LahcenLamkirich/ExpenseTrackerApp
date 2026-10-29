import 'package:drift/native.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  late AppDatabase db;
  late CategoryRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = CategoryRepository(db);
  });
  tearDown(() => db.close());

  test('create appends after existing categories of the same kind', () async {
    final created = await repo.create(
      name: '  Coffee ',
      glyph: '☕',
      colorValue: 0xFFFCC419,
      kind: CategoryKind.expense,
      monthlyCapMinor: 250000,
    );
    expect(created.name, 'Coffee');
    final all = await repo.watchAll().first;
    final expenses = all.where((c) => c.kind == CategoryKind.expense).toList();
    expect(expenses.last.id, created.id);
    expect(created.sortOrder, greaterThan(expenses[expenses.length - 2].sortOrder));
    expect((await repo.get(created.id))!.monthlyCapMinor, 250000);
  });

  test('update persists edits and renaming a built-in drops its l10n key', () async {
    final dining = (await repo.get('cat_dining'))!;
    expect(dining.nameKey, 'categoryDining');
    await repo.update(dining.copyWith(name: 'Restos', monthlyCapMinor: 100000, glyph: '🍕'));
    final updated = (await repo.get('cat_dining'))!;
    expect(updated.name, 'Restos');
    expect(updated.nameKey, isNull);
    expect(updated.glyph, '🍕');
    expect(updated.monthlyCapMinor, 100000);
  });

  test('delete removes unused categories', () async {
    final c = await repo.create(name: 'Temp', glyph: '📦', colorValue: 0, kind: CategoryKind.expense);
    expect(await repo.delete(c.id), CategoryDeletion.deleted);
    expect(await repo.get(c.id), isNull);
  });

  test('delete archives categories that transactions use', () async {
    await TransactionRepository(db).save(makeTransaction(categoryId: 'cat_groceries'));
    expect(await repo.delete('cat_groceries'), CategoryDeletion.archived);
    final archived = (await repo.get('cat_groceries'))!;
    expect(archived.isArchived, isTrue);
  });
}
