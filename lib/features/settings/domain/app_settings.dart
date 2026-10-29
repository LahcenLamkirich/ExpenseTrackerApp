import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    /// ISO code of the home currency; null until onboarding picks one.
    String? homeCurrencyCode,

    /// Monthly budget in home-currency minor units; null = no budget.
    int? monthlyBudgetMinor,
    @Default(true) bool budgetAlertEnabled,
    @Default(ThemeMode.system) ThemeMode themeMode,

    /// Language tag (`en`, `fr`, `ar`); null follows the device.
    String? localeCode,
    @Default(false) bool appLockEnabled,
    @Default(false) bool onboardingCompleted,
  }) = _AppSettings;

  const AppSettings._();

  Locale? get locale => localeCode == null ? null : Locale(localeCode!);
}
