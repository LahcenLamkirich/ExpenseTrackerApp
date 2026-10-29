import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/l10n/l10n.dart';

extension CategoryL10n on AppLocalizations {
  /// Display name: the user's literal name, else the localized built-in name.
  String categoryName(CategoryRecord c) {
    if (c.name case final name? when name.isNotEmpty) return name;
    return switch (c.nameKey) {
      'categoryDining' => categoryDining,
      'categoryGroceries' => categoryGroceries,
      'categoryTransport' => categoryTransport,
      'categoryTravel' => categoryTravel,
      'categoryShopping' => categoryShopping,
      'categoryBills' => categoryBills,
      'categorySubscriptions' => categorySubscriptions,
      'categoryHealth' => categoryHealth,
      'categoryEntertainment' => categoryEntertainment,
      'categoryHousing' => categoryHousing,
      'categoryEducation' => categoryEducation,
      'categoryOtherIncome' => categoryOtherIncome,
      'categorySalary' => categorySalary,
      'categoryFreelance' => categoryFreelance,
      'categoryGift' => categoryGift,
      _ => categoryOther,
    };
  }
}
