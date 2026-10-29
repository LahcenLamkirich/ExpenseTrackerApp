import 'package:flossi/core/money/currency.dart';
import 'package:flossi/features/settings/data/settings_repository.dart';
import 'package:flossi/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

/// Synchronous app settings, loaded from shared_preferences at startup.
@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> _update(AppSettings Function(AppSettings) change) async {
    state = change(state);
    await ref.read(settingsRepositoryProvider).save(state);
  }

  Future<void> setHomeCurrency(String code) =>
      _update((s) => s.copyWith(homeCurrencyCode: code));

  Future<void> setMonthlyBudget(int? minor) =>
      _update((s) => s.copyWith(monthlyBudgetMinor: minor));

  Future<void> setBudgetAlert({required bool enabled}) =>
      _update((s) => s.copyWith(budgetAlertEnabled: enabled));

  Future<void> setThemeMode(ThemeMode mode) =>
      _update((s) => s.copyWith(themeMode: mode));

  Future<void> setLocale(String? code) =>
      _update((s) => s.copyWith(localeCode: code));

  Future<void> setAppLock({required bool enabled}) =>
      _update((s) => s.copyWith(appLockEnabled: enabled));

  Future<void> completeOnboarding({
    required String homeCurrencyCode,
    int? monthlyBudgetMinor,
    bool budgetAlertEnabled = true,
  }) => _update(
    (s) => s.copyWith(
      homeCurrencyCode: homeCurrencyCode,
      monthlyBudgetMinor: monthlyBudgetMinor,
      budgetAlertEnabled: budgetAlertEnabled,
      onboardingCompleted: true,
    ),
  );

  Future<void> reset() async {
    await ref.read(settingsRepositoryProvider).clear();
    state = const AppSettings();
  }
}

/// The current home currency (MAD until onboarding picks one).
@Riverpod(keepAlive: true)
Currency homeCurrency(Ref ref) {
  final code = ref.watch(settingsControllerProvider.select((s) => s.homeCurrencyCode));
  return CurrencyCatalog.of(code ?? CurrencyCatalog.pinnedCodes.first);
}
