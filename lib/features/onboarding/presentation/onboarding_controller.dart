import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/onboarding/domain/budget_presets.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@immutable
class OnboardingState {
  const OnboardingState({
    required this.currency,
    required this.budget,
    this.alertEnabled = true,
  });

  final Currency currency;

  /// Null means "No budget".
  final Money? budget;
  final bool alertEnabled;

  OnboardingState copyWith({
    Currency? currency,
    Money? Function()? budget,
    bool? alertEnabled,
  }) => OnboardingState(
    currency: currency ?? this.currency,
    budget: budget == null ? this.budget : budget(),
    alertEnabled: alertEnabled ?? this.alertEnabled,
  );
}

/// Holds choices across the three onboarding steps.
@Riverpod(keepAlive: true)
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() {
    final currency = CurrencyCatalog.of(CurrencyCatalog.pinnedCodes.first);
    return OnboardingState(currency: currency, budget: BudgetPresets.of(currency).suggested);
  }

  /// Picking a new currency resets the budget to that currency's suggestion.
  void selectCurrency(Currency currency) {
    if (currency == state.currency) return;
    state = state.copyWith(
      currency: currency,
      budget: () => state.budget == null ? null : BudgetPresets.of(currency).suggested,
    );
  }

  void setBudget(Money? budget) => state = state.copyWith(budget: () => budget);

  void addToBudget(Money delta) =>
      state = state.copyWith(budget: () => (state.budget ?? Money.zero(state.currency)) + delta);

  void setAlert({required bool enabled}) => state = state.copyWith(alertEnabled: enabled);

  /// Persists the choices, seeds tracked currencies and finishes onboarding
  /// (the router then redirects into the app).
  Future<void> complete({bool skipBudget = false}) async {
    final s = state;
    await ref.read(trackedCurrencyRepositoryProvider).ensure([
      s.currency.code,
      ...CurrencyCatalog.pinnedCodes,
      'GBP',
    ]);
    await ref
        .read(settingsControllerProvider.notifier)
        .completeOnboarding(
          homeCurrencyCode: s.currency.code,
          monthlyBudgetMinor: skipBudget ? null : s.budget?.minor,
          budgetAlertEnabled: s.alertEnabled,
        );
  }
}
