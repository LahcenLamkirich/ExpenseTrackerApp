import 'package:flossi/core/domain/enums.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_record.freezed.dart';

/// A spending or income category.
///
/// Built-in categories carry a [nameKey] (ARB key) so their name follows
/// the app language; user categories carry a literal [name].
@freezed
abstract class CategoryRecord with _$CategoryRecord {
  const factory CategoryRecord({
    required String id,
    required String glyph,
    required int colorValue,
    required CategoryKind kind,
    String? nameKey,
    String? name,
    int? monthlyCapMinor,
    @Default(0) int sortOrder,
    @Default(false) bool isArchived,
  }) = _CategoryRecord;

  const CategoryRecord._();

  Color get color => Color(colorValue);
}

/// Result of deleting a category.
enum CategoryDeletion {
  /// No transaction used it; the row is gone.
  deleted,

  /// Transactions reference it; it is hidden but history stays intact.
  archived,
}
