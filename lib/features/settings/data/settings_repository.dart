import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/settings/domain/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

/// Persists [AppSettings] in shared_preferences, one key per field.
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _homeCurrency = 'settings.homeCurrency';
  static const _budget = 'settings.monthlyBudgetMinor';
  static const _budgetAlert = 'settings.budgetAlert';
  static const _themeMode = 'settings.themeMode';
  static const _locale = 'settings.locale';
  static const _appLock = 'settings.appLock';
  static const _onboarding = 'settings.onboardingCompleted';

  AppSettings load() => AppSettings(
    homeCurrencyCode: _prefs.getString(_homeCurrency),
    monthlyBudgetMinor: _prefs.getInt(_budget),
    budgetAlertEnabled: _prefs.getBool(_budgetAlert) ?? true,
    themeMode: ThemeMode.values.asNameMap()[_prefs.getString(_themeMode)] ?? ThemeMode.system,
    localeCode: _prefs.getString(_locale),
    appLockEnabled: _prefs.getBool(_appLock) ?? false,
    onboardingCompleted: _prefs.getBool(_onboarding) ?? false,
  );

  Future<void> save(AppSettings s) async {
    await Future.wait([
      _setString(_homeCurrency, s.homeCurrencyCode),
      _setInt(_budget, s.monthlyBudgetMinor),
      _prefs.setBool(_budgetAlert, s.budgetAlertEnabled),
      _prefs.setString(_themeMode, s.themeMode.name),
      _setString(_locale, s.localeCode),
      _prefs.setBool(_appLock, s.appLockEnabled),
      _prefs.setBool(_onboarding, s.onboardingCompleted),
    ]);
  }

  Future<void> clear() async {
    for (final key in [_homeCurrency, _budget, _budgetAlert, _themeMode, _locale, _appLock, _onboarding]) {
      await _prefs.remove(key);
    }
  }

  Future<bool> _setString(String key, String? value) =>
      value == null ? _prefs.remove(key) : _prefs.setString(key, value);

  Future<bool> _setInt(String key, int? value) =>
      value == null ? _prefs.remove(key) : _prefs.setInt(key, value);
}

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepository(ref.watch(sharedPreferencesProvider));
