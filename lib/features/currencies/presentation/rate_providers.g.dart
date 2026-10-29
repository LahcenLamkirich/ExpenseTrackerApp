// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(httpClient)
final httpClientProvider = HttpClientProvider._();

final class HttpClientProvider
    extends $FunctionalProvider<http.Client, http.Client, http.Client>
    with $Provider<http.Client> {
  HttpClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'httpClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$httpClientHash();

  @$internal
  @override
  $ProviderElement<http.Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  http.Client create(Ref ref) {
    return httpClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(http.Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<http.Client>(value),
    );
  }
}

String _$httpClientHash() => r'7ec49beae0f15115de79f9aa98dbd250130e26d8';

/// The active rate provider. Swap the implementation here.

@ProviderFor(remoteRateSource)
final remoteRateSourceProvider = RemoteRateSourceProvider._();

/// The active rate provider. Swap the implementation here.

final class RemoteRateSourceProvider
    extends
        $FunctionalProvider<
          RemoteRateSource,
          RemoteRateSource,
          RemoteRateSource
        >
    with $Provider<RemoteRateSource> {
  /// The active rate provider. Swap the implementation here.
  RemoteRateSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteRateSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteRateSourceHash();

  @$internal
  @override
  $ProviderElement<RemoteRateSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RemoteRateSource create(Ref ref) {
    return remoteRateSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteRateSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteRateSource>(value),
    );
  }
}

String _$remoteRateSourceHash() => r'c9186651605c9ac5e455c504d56fa989c843d5bf';

/// Keeps cached rates fresh: refreshes on start and on resume when the
/// newest provider snapshot is older than [maxAge]. Failures are silent —
/// the app keeps working from the cache.

@ProviderFor(RateSync)
final rateSyncProvider = RateSyncProvider._();

/// Keeps cached rates fresh: refreshes on start and on resume when the
/// newest provider snapshot is older than [maxAge]. Failures are silent —
/// the app keeps working from the cache.
final class RateSyncProvider
    extends $NotifierProvider<RateSync, RateSyncState> {
  /// Keeps cached rates fresh: refreshes on start and on resume when the
  /// newest provider snapshot is older than [maxAge]. Failures are silent —
  /// the app keeps working from the cache.
  RateSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rateSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rateSyncHash();

  @$internal
  @override
  RateSync create() => RateSync();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RateSyncState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RateSyncState>(value),
    );
  }
}

String _$rateSyncHash() => r'd39fadd6d32e9927a0f771e319886360116e7a29';

/// Keeps cached rates fresh: refreshes on start and on resume when the
/// newest provider snapshot is older than [maxAge]. Failures are silent —
/// the app keeps working from the cache.

abstract class _$RateSync extends $Notifier<RateSyncState> {
  RateSyncState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RateSyncState, RateSyncState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RateSyncState, RateSyncState>,
              RateSyncState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Codes worth keeping in memory: home, tracked, and any used in history.

@ProviderFor(relevantCurrencyCodes)
final relevantCurrencyCodesProvider = RelevantCurrencyCodesProvider._();

/// Codes worth keeping in memory: home, tracked, and any used in history.

final class RelevantCurrencyCodesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<String>>,
          Set<String>,
          Stream<Set<String>>
        >
    with $FutureModifier<Set<String>>, $StreamProvider<Set<String>> {
  /// Codes worth keeping in memory: home, tracked, and any used in history.
  RelevantCurrencyCodesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'relevantCurrencyCodesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$relevantCurrencyCodesHash();

  @$internal
  @override
  $StreamProviderElement<Set<String>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Set<String>> create(Ref ref) {
    return relevantCurrencyCodes(ref);
  }
}

String _$relevantCurrencyCodesHash() =>
    r'92831a088abf275663b5986d398289e251b5a6ee';

/// In-memory rate table for synchronous conversions (charts, totals).

@ProviderFor(rateTable)
final rateTableProvider = RateTableProvider._();

/// In-memory rate table for synchronous conversions (charts, totals).

final class RateTableProvider
    extends
        $FunctionalProvider<AsyncValue<RateTable>, RateTable, Stream<RateTable>>
    with $FutureModifier<RateTable>, $StreamProvider<RateTable> {
  /// In-memory rate table for synchronous conversions (charts, totals).
  RateTableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rateTableProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rateTableHash();

  @$internal
  @override
  $StreamProviderElement<RateTable> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<RateTable> create(Ref ref) {
    return rateTable(ref);
  }
}

String _$rateTableHash() => r'05152fe923779530732a47a15d567cd8b9d73c5c';
