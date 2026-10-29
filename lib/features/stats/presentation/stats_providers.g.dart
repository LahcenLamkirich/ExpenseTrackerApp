// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StatsQueryController)
final statsQueryControllerProvider = StatsQueryControllerProvider._();

final class StatsQueryControllerProvider
    extends $NotifierProvider<StatsQueryController, StatsQuery> {
  StatsQueryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'statsQueryControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$statsQueryControllerHash();

  @$internal
  @override
  StatsQueryController create() => StatsQueryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StatsQuery value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StatsQuery>(value),
    );
  }
}

String _$statsQueryControllerHash() =>
    r'cc1c597b74b48630f7c7fe1a58d835e1d8e4842c';

abstract class _$StatsQueryController extends $Notifier<StatsQuery> {
  StatsQuery build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StatsQuery, StatsQuery>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StatsQuery, StatsQuery>,
              StatsQuery,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Stats for the selected period, in the selected view currency.

@ProviderFor(periodStats)
final periodStatsProvider = PeriodStatsProvider._();

/// Stats for the selected period, in the selected view currency.

final class PeriodStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PeriodStats>,
          PeriodStats,
          FutureOr<PeriodStats>
        >
    with $FutureModifier<PeriodStats>, $FutureProvider<PeriodStats> {
  /// Stats for the selected period, in the selected view currency.
  PeriodStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'periodStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$periodStatsHash();

  @$internal
  @override
  $FutureProviderElement<PeriodStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PeriodStats> create(Ref ref) {
    return periodStats(ref);
  }
}

String _$periodStatsHash() => r'2d0a65f64e28d9e5ebc48b7c12e9ff1d83a44542';
