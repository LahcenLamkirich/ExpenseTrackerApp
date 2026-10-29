// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracked_currency_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trackedCurrencyRepository)
final trackedCurrencyRepositoryProvider = TrackedCurrencyRepositoryProvider._();

final class TrackedCurrencyRepositoryProvider
    extends
        $FunctionalProvider<
          TrackedCurrencyRepository,
          TrackedCurrencyRepository,
          TrackedCurrencyRepository
        >
    with $Provider<TrackedCurrencyRepository> {
  TrackedCurrencyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackedCurrencyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackedCurrencyRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrackedCurrencyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackedCurrencyRepository create(Ref ref) {
    return trackedCurrencyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackedCurrencyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackedCurrencyRepository>(value),
    );
  }
}

String _$trackedCurrencyRepositoryHash() =>
    r'cc3144c413128119bf48839e786385c0f087a0b6';

@ProviderFor(trackedCurrencies)
final trackedCurrenciesProvider = TrackedCurrenciesProvider._();

final class TrackedCurrenciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Currency>>,
          List<Currency>,
          Stream<List<Currency>>
        >
    with $FutureModifier<List<Currency>>, $StreamProvider<List<Currency>> {
  TrackedCurrenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackedCurrenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackedCurrenciesHash();

  @$internal
  @override
  $StreamProviderElement<List<Currency>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Currency>> create(Ref ref) {
    return trackedCurrencies(ref);
  }
}

String _$trackedCurrenciesHash() => r'5d3b9c9e7a02742e135f723f132b6fa86872a4be';

@ProviderFor(allTrackedCurrencies)
final allTrackedCurrenciesProvider = AllTrackedCurrenciesProvider._();

final class AllTrackedCurrenciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<(Currency, bool)>>,
          List<(Currency, bool)>,
          Stream<List<(Currency, bool)>>
        >
    with
        $FutureModifier<List<(Currency, bool)>>,
        $StreamProvider<List<(Currency, bool)>> {
  AllTrackedCurrenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTrackedCurrenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTrackedCurrenciesHash();

  @$internal
  @override
  $StreamProviderElement<List<(Currency, bool)>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<(Currency, bool)>> create(Ref ref) {
    return allTrackedCurrencies(ref);
  }
}

String _$allTrackedCurrenciesHash() =>
    r'135802b3c8df35801b18b0ca185aa282f9d33ef1';
