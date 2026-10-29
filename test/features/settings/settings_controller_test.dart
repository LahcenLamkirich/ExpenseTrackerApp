import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<ProviderContainer> containerWith([Map<String, Object> values = const {}]) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('defaults before onboarding', () async {
    final container = await containerWith();
    final s = container.read(settingsControllerProvider);
    expect(s.onboardingCompleted, isFalse);
    expect(s.homeCurrencyCode, isNull);
    expect(s.themeMode, ThemeMode.system);
    expect(s.budgetAlertEnabled, isTrue);
    expect(s.locale, isNull);
  });

  test('completeOnboarding persists currency and budget', () async {
    final container = await containerWith();
    await container
        .read(settingsControllerProvider.notifier)
        .completeOnboarding(homeCurrencyCode: 'MAD', monthlyBudgetMinor: 1500000);

    final prefs = container.read(sharedPreferencesProvider);
    expect(prefs.getString('settings.homeCurrency'), 'MAD');
    expect(prefs.getInt('settings.monthlyBudgetMinor'), 1500000);
    expect(prefs.getBool('settings.onboardingCompleted'), isTrue);

    // A fresh container reads the persisted values back.
    final reloaded = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(reloaded.dispose);
    final s = reloaded.read(settingsControllerProvider);
    expect(s.homeCurrencyCode, 'MAD');
    expect(s.monthlyBudgetMinor, 1500000);
    expect(s.onboardingCompleted, isTrue);
  });

  test('clearing the budget removes the key', () async {
    final container = await containerWith({'settings.monthlyBudgetMinor': 100});
    await container.read(settingsControllerProvider.notifier).setMonthlyBudget(null);
    expect(container.read(sharedPreferencesProvider).containsKey('settings.monthlyBudgetMinor'), isFalse);
    expect(container.read(settingsControllerProvider).monthlyBudgetMinor, isNull);
  });

  test('theme and locale round-trip', () async {
    final container = await containerWith();
    final notifier = container.read(settingsControllerProvider.notifier);
    await notifier.setThemeMode(ThemeMode.dark);
    await notifier.setLocale('ar');
    final s = container.read(settingsControllerProvider);
    expect(s.themeMode, ThemeMode.dark);
    expect(s.locale, const Locale('ar'));
  });

  test('reset clears everything', () async {
    final container = await containerWith({
      'settings.homeCurrency': 'EUR',
      'settings.onboardingCompleted': true,
    });
    await container.read(settingsControllerProvider.notifier).reset();
    final s = container.read(settingsControllerProvider);
    expect(s.onboardingCompleted, isFalse);
    expect(s.homeCurrencyCode, isNull);
  });
}
