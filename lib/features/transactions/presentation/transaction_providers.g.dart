// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Resolves stored transactions into the current home currency. Rows
/// recorded under a previous home currency are re-converted with cached
/// rates (historical first, then latest); without any rate they stay
/// unresolved and are flagged in the UI.

@ProviderFor(homeAmountResolver)
final homeAmountResolverProvider = HomeAmountResolverProvider._();

/// Resolves stored transactions into the current home currency. Rows
/// recorded under a previous home currency are re-converted with cached
/// rates (historical first, then latest); without any rate they stay
/// unresolved and are flagged in the UI.

final class HomeAmountResolverProvider
    extends
        $FunctionalProvider<
          HomeAmountResolver,
          HomeAmountResolver,
          HomeAmountResolver
        >
    with $Provider<HomeAmountResolver> {
  /// Resolves stored transactions into the current home currency. Rows
  /// recorded under a previous home currency are re-converted with cached
  /// rates (historical first, then latest); without any rate they stay
  /// unresolved and are flagged in the UI.
  HomeAmountResolverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeAmountResolverProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeAmountResolverHash();

  @$internal
  @override
  $ProviderElement<HomeAmountResolver> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeAmountResolver create(Ref ref) {
    return homeAmountResolver(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeAmountResolver value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeAmountResolver>(value),
    );
  }
}

String _$homeAmountResolverHash() =>
    r'c2558cd0202b8c011e2324cd4c65d66a3fa6ff60';

/// History screen filters. Defaults to the current month.

@ProviderFor(TransactionFilterController)
final transactionFilterControllerProvider =
    TransactionFilterControllerProvider._();

/// History screen filters. Defaults to the current month.
final class TransactionFilterControllerProvider
    extends $NotifierProvider<TransactionFilterController, TransactionFilter> {
  /// History screen filters. Defaults to the current month.
  TransactionFilterControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionFilterControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionFilterControllerHash();

  @$internal
  @override
  TransactionFilterController create() => TransactionFilterController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionFilter>(value),
    );
  }
}

String _$transactionFilterControllerHash() =>
    r'd4c82d4877011f8993fd6a48100ea5c60dfc198a';

/// History screen filters. Defaults to the current month.

abstract class _$TransactionFilterController
    extends $Notifier<TransactionFilter> {
  TransactionFilter build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<TransactionFilter, TransactionFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TransactionFilter, TransactionFilter>,
              TransactionFilter,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(transactionsInSpan)
final transactionsInSpanProvider = TransactionsInSpanFamily._();

final class TransactionsInSpanProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TransactionRecord>>,
          List<TransactionRecord>,
          Stream<List<TransactionRecord>>
        >
    with
        $FutureModifier<List<TransactionRecord>>,
        $StreamProvider<List<TransactionRecord>> {
  TransactionsInSpanProvider._({
    required TransactionsInSpanFamily super.from,
    required DateSpan? super.argument,
  }) : super(
         retry: null,
         name: r'transactionsInSpanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionsInSpanHash();

  @override
  String toString() {
    return r'transactionsInSpanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<TransactionRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<TransactionRecord>> create(Ref ref) {
    final argument = this.argument as DateSpan?;
    return transactionsInSpan(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsInSpanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionsInSpanHash() =>
    r'fa117fbd4a8fd56902a6487e6c2228843b3cc899';

final class TransactionsInSpanFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<TransactionRecord>>, DateSpan?> {
  TransactionsInSpanFamily._()
    : super(
        retry: null,
        name: r'transactionsInSpanProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TransactionsInSpanProvider call(DateSpan? span) =>
      TransactionsInSpanProvider._(argument: span, from: this);

  @override
  String toString() => r'transactionsInSpanProvider';
}

/// Filtered, day-grouped history for the History tab.

@ProviderFor(historyView)
final historyViewProvider = HistoryViewProvider._();

/// Filtered, day-grouped history for the History tab.

final class HistoryViewProvider
    extends
        $FunctionalProvider<
          AsyncValue<HistoryView>,
          HistoryView,
          FutureOr<HistoryView>
        >
    with $FutureModifier<HistoryView>, $FutureProvider<HistoryView> {
  /// Filtered, day-grouped history for the History tab.
  HistoryViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'historyViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$historyViewHash();

  @$internal
  @override
  $FutureProviderElement<HistoryView> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HistoryView> create(Ref ref) {
    return historyView(ref);
  }
}

String _$historyViewHash() => r'd277aefc420c2a165a81f00c480410ed78f5fce4';

/// This month's totals per category in the home currency (positive values).

@ProviderFor(monthCategoryTotals)
final monthCategoryTotalsProvider = MonthCategoryTotalsProvider._();

/// This month's totals per category in the home currency (positive values).

final class MonthCategoryTotalsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, Money>>,
          Map<String, Money>,
          FutureOr<Map<String, Money>>
        >
    with
        $FutureModifier<Map<String, Money>>,
        $FutureProvider<Map<String, Money>> {
  /// This month's totals per category in the home currency (positive values).
  MonthCategoryTotalsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthCategoryTotalsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthCategoryTotalsHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, Money>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, Money>> create(Ref ref) {
    return monthCategoryTotals(ref);
  }
}

String _$monthCategoryTotalsHash() =>
    r'dca4d98497f680dbe95e984cc32fd7d84aa2603e';
