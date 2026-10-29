import 'package:drift/drift.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'category_repository.g.dart';

class CategoryRepository {
  CategoryRepository(this._db, {this._uuid = const Uuid()});

  final AppDatabase _db;
  final Uuid _uuid;

  /// All categories (including archived ones, for history lookups).
  Stream<List<CategoryRecord>> watchAll() {
    final query = _db.select(_db.categories)
      ..orderBy([
        (c) => OrderingTerm.asc(c.kind),
        (c) => OrderingTerm.asc(c.sortOrder),
      ]);
    return query.watch().map((rows) => rows.map(_toRecord).toList());
  }

  /// Active categories of [kind] in display order (one-shot read).
  Future<List<CategoryRecord>> active(CategoryKind kind) async {
    final rows =
        await (_db.select(_db.categories)
              ..where((c) => c.kind.equalsValue(kind) & c.isArchived.equals(false))
              ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
            .get();
    return rows.map(_toRecord).toList();
  }

  Future<CategoryRecord?> get(String id) async {
    final row = await (_db.select(
      _db.categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toRecord(row);
  }

  /// Inserts a new category at the end of its kind and returns it.
  Future<CategoryRecord> create({
    required String name,
    required String glyph,
    required int colorValue,
    required CategoryKind kind,
    int? monthlyCapMinor,
  }) async {
    final maxOrder = _db.categories.sortOrder.max();
    final last =
        await (_db.selectOnly(_db.categories)
              ..addColumns([maxOrder])
              ..where(_db.categories.kind.equalsValue(kind)))
            .map((r) => r.read(maxOrder))
            .getSingle();
    final record = CategoryRecord(
      id: _uuid.v4(),
      name: name.trim(),
      glyph: glyph,
      colorValue: colorValue,
      kind: kind,
      monthlyCapMinor: monthlyCapMinor,
      sortOrder: (last ?? -1) + 1,
    );
    await _db.into(_db.categories).insert(_toCompanion(record));
    return record;
  }

  /// Saves edits. Renaming a built-in category replaces its localized name
  /// with the user's literal name.
  Future<void> update(CategoryRecord record) =>
      (_db.update(_db.categories)..where((c) => c.id.equals(record.id)))
          .write(_toCompanion(record));

  /// Hard-deletes unused categories; archives ones referenced by
  /// transactions so historical totals keep their category.
  Future<CategoryDeletion> delete(String id) => _db.transaction(() async {
    final count = _db.transactions.id.count();
    final used =
        await (_db.selectOnly(_db.transactions)
              ..addColumns([count])
              ..where(_db.transactions.categoryId.equals(id)))
            .map((r) => r.read(count) ?? 0)
            .getSingle();
    if (used > 0) {
      await (_db.update(_db.categories)..where((c) => c.id.equals(id))).write(
        const CategoriesCompanion(isArchived: Value(true)),
      );
      return CategoryDeletion.archived;
    }
    await (_db.delete(_db.categories)..where((c) => c.id.equals(id))).go();
    return CategoryDeletion.deleted;
  });

  static CategoryRecord _toRecord(CategoryRow r) => CategoryRecord(
    id: r.id,
    nameKey: r.nameKey,
    name: r.name,
    glyph: r.glyph,
    colorValue: r.colorValue,
    kind: r.kind,
    monthlyCapMinor: r.monthlyCapMinor,
    sortOrder: r.sortOrder,
    isArchived: r.isArchived,
  );

  static CategoriesCompanion _toCompanion(CategoryRecord c) =>
      CategoriesCompanion.insert(
        id: c.id,
        nameKey: Value(c.name == null ? c.nameKey : null),
        name: Value(c.name),
        glyph: c.glyph,
        colorValue: c.colorValue,
        kind: c.kind,
        monthlyCapMinor: Value(c.monthlyCapMinor),
        sortOrder: Value(c.sortOrder),
        isArchived: Value(c.isArchived),
      );
}

@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) =>
    CategoryRepository(ref.watch(appDatabaseProvider));

/// Every category, archived included, keyed by id (for history rows).
@Riverpod(keepAlive: true)
Stream<Map<String, CategoryRecord>> categoriesById(Ref ref) => ref
    .watch(categoryRepositoryProvider)
    .watchAll()
    .map((list) => {for (final c in list) c.id: c});

/// Active (non-archived) categories of one kind, in display order.
@riverpod
Future<List<CategoryRecord>> activeCategories(Ref ref, CategoryKind kind) async {
  final all = await ref.watch(categoriesByIdProvider.future);
  return all.values.where((c) => c.kind == kind && !c.isArchived).toList()
    ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
}
