// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Synchronous app settings, loaded from shared_preferences at startup.

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

/// Synchronous app settings, loaded from shared_preferences at startup.
final class SettingsControllerProvider
    extends $NotifierProvider<SettingsController, AppSettings> {
  /// Synchronous app settings, loaded from shared_preferences at startup.
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppSettings>(value),
    );
  }
}

String _$settingsControllerHash() =>
    r'1e72ca248bdccc62f9a36ea54d66eca9cd25f8f9';

/// Synchronous app settings, loaded from shared_preferences at startup.

abstract class _$SettingsController extends $Notifier<AppSettings> {
  AppSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppSettings, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppSettings, AppSettings>,
              AppSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The current home currency (MAD until onboarding picks one).

@ProviderFor(homeCurrency)
final homeCurrencyProvider = HomeCurrencyProvider._();

/// The current home currency (MAD until onboarding picks one).

final class HomeCurrencyProvider
    extends $FunctionalProvider<Currency, Currency, Currency>
    with $Provider<Currency> {
  /// The current home currency (MAD until onboarding picks one).
  HomeCurrencyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeCurrencyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeCurrencyHash();

  @$internal
  @override
  $ProviderElement<Currency> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Currency create(Ref ref) {
    return homeCurrency(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Currency value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Currency>(value),
    );
  }
}

String _$homeCurrencyHash() => r'5b58604f046cd63739ece144c387c5ca8f6ed801';
