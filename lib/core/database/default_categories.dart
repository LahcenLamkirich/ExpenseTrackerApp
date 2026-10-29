import 'package:drift/drift.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/domain/enums.dart';

/// Built-in categories seeded on first launch. Names are ARB keys resolved
/// at display time, so they follow the app language.
class DefaultCategory {
  const DefaultCategory(this.id, this.nameKey, this.glyph, this.color, this.kind);

  final String id;
  final String nameKey;
  final String glyph;
  final int color;
  final CategoryKind kind;
}

const defaultCategories = <DefaultCategory>[
  DefaultCategory('cat_dining', 'categoryDining', '🍜', 0xFFFCC419, CategoryKind.expense),
  DefaultCategory('cat_groceries', 'categoryGroceries', '🛒', 0xFF20C997, CategoryKind.expense),
  DefaultCategory('cat_transport', 'categoryTransport', '🚕', 0xFFFD7E14, CategoryKind.expense),
  DefaultCategory('cat_travel', 'categoryTravel', '✈️', 0xFF339AF0, CategoryKind.expense),
  DefaultCategory('cat_shopping', 'categoryShopping', '🛍️', 0xFFFF6B81, CategoryKind.expense),
  DefaultCategory('cat_bills', 'categoryBills', '💡', 0xFFA9E34B, CategoryKind.expense),
  DefaultCategory('cat_subscriptions', 'categorySubscriptions', '💻', 0xFF5C7CFA, CategoryKind.expense),
  DefaultCategory('cat_health', 'categoryHealth', '🩺', 0xFF12B886, CategoryKind.expense),
  DefaultCategory('cat_entertainment', 'categoryEntertainment', '🎬', 0xFFE64980, CategoryKind.expense),
  DefaultCategory('cat_housing', 'categoryHousing', '🏠', 0xFFB57BFF, CategoryKind.expense),
  DefaultCategory('cat_education', 'categoryEducation', '📚', 0xFF4DABF7, CategoryKind.expense),
  DefaultCategory('cat_other', 'categoryOther', '📦', 0xFF868E96, CategoryKind.expense),
  DefaultCategory('cat_salary', 'categorySalary', '💼', 0xFF10B981, CategoryKind.income),
  DefaultCategory('cat_freelance', 'categoryFreelance', '🧑‍💻', 0xFF4DABF7, CategoryKind.income),
  DefaultCategory('cat_gift', 'categoryGift', '🎁', 0xFFF783AC, CategoryKind.income),
  DefaultCategory('cat_other_income', 'categoryOtherIncome', '💰', 0xFF94D82D, CategoryKind.income),
];

Future<void> seedDefaultCategories(AppDatabase db) => db.batch((b) {
  b.insertAll(
    db.categories,
    [
      for (final (i, c) in defaultCategories.indexed)
        CategoriesCompanion.insert(
          id: c.id,
          nameKey: Value(c.nameKey),
          glyph: c.glyph,
          colorValue: c.color,
          kind: c.kind,
          sortOrder: Value(i),
        ),
    ],
    mode: InsertMode.insertOrIgnore,
  );
});
