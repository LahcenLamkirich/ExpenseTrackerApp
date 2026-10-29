// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(categoryRepository)
final categoryRepositoryProvider = CategoryRepositoryProvider._();

final class CategoryRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryRepository,
          CategoryRepository,
          CategoryRepository
        >
    with $Provider<CategoryRepository> {
  CategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryRepository create(Ref ref) {
    return categoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryRepository>(value),
    );
  }
}

String _$categoryRepositoryHash() =>
    r'3c55f83a36220df37819fe04644016dc0af7ee06';

/// Every category, archived included, keyed by id (for history rows).

@ProviderFor(categoriesById)
final categoriesByIdProvider = CategoriesByIdProvider._();

/// Every category, archived included, keyed by id (for history rows).

final class CategoriesByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, CategoryRecord>>,
          Map<String, CategoryRecord>,
          Stream<Map<String, CategoryRecord>>
        >
    with
        $FutureModifier<Map<String, CategoryRecord>>,
        $StreamProvider<Map<String, CategoryRecord>> {
  /// Every category, archived included, keyed by id (for history rows).
  CategoriesByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesByIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesByIdHash();

  @$internal
  @override
  $StreamProviderElement<Map<String, CategoryRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Map<String, CategoryRecord>> create(Ref ref) {
    return categoriesById(ref);
  }
}

String _$categoriesByIdHash() => r'fa7d30c7ed43b4daeab8a99090c8832dd2d394c2';

/// Active (non-archived) categories of one kind, in display order.

@ProviderFor(activeCategories)
final activeCategoriesProvider = ActiveCategoriesFamily._();

/// Active (non-archived) categories of one kind, in display order.

final class ActiveCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CategoryRecord>>,
          List<CategoryRecord>,
          FutureOr<List<CategoryRecord>>
        >
    with
        $FutureModifier<List<CategoryRecord>>,
        $FutureProvider<List<CategoryRecord>> {
  /// Active (non-archived) categories of one kind, in display order.
  ActiveCategoriesProvider._({
    required ActiveCategoriesFamily super.from,
    required CategoryKind super.argument,
  }) : super(
         retry: null,
         name: r'activeCategoriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$activeCategoriesHash();

  @override
  String toString() {
    return r'activeCategoriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CategoryRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CategoryRecord>> create(Ref ref) {
    final argument = this.argument as CategoryKind;
    return activeCategories(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ActiveCategoriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$activeCategoriesHash() => r'bad4dbf14276ce29c9cae608cddb314eefe527b1';

/// Active (non-archived) categories of one kind, in display order.

final class ActiveCategoriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CategoryRecord>>,
          CategoryKind
        > {
  ActiveCategoriesFamily._()
    : super(
        retry: null,
        name: r'activeCategoriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Active (non-archived) categories of one kind, in display order.

  ActiveCategoriesProvider call(CategoryKind kind) =>
      ActiveCategoriesProvider._(argument: kind, from: this);

  @override
  String toString() => r'activeCategoriesProvider';
}
