import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';

/// Sensible monthly-budget presets for a currency.
///
/// Rates may not be available during onboarding (offline first launch), so
/// presets use a coarse per-currency magnitude instead of live conversion:
/// the base ladder is roughly "1,000 / 1,500 / 2,500 EUR-like units".
class BudgetPresets {
  BudgetPresets._(this.currency, this._unit);

  factory BudgetPresets.of(Currency currency) =>
      BudgetPresets._(currency, _magnitudes[currency.code] ?? 1);

  final Currency currency;
  final int _unit;

  static const _magnitudes = <String, int>{
    'MAD': 10, 'AED': 4, 'SAR': 4, 'QAR': 4, 'TND': 3, 'DZD': 100, 'EGP': 30,
    'TRY': 30, 'LBP': 50000, 'IQD': 1000, 'ILS': 4, 'CNY': 7, 'HKD': 8,
    'INR': 80, 'PKR': 200, 'IDR': 10000, 'MYR': 4, 'THB': 30, 'VND': 20000,
    'PHP': 50, 'JPY': 150, 'KRW': 1000, 'SEK': 10, 'NOK': 10, 'DKK': 7,
    'ISK': 100, 'PLN': 4, 'CZK': 20, 'HUF': 300, 'RON': 4, 'BGN': 2,
    'RSD': 100, 'UAH': 30, 'RUB': 80, 'BRL': 5, 'MXN': 15, 'ARS': 500,
    'CLP': 800, 'COP': 3000, 'PEN': 3, 'ZAR': 15, 'NGN': 1000, 'KES': 100,
    'GHS': 10, 'XOF': 500, 'XAF': 500, 'MRU': 30,
  };

  Money _major(int units) {
    var minor = units * _unit;
    for (var i = 0; i < currency.decimals; i++) {
      minor *= 10;
    }
    return Money(minor, currency);
  }

  /// Quick-select targets (e.g. 10,000 / 15,000 / 25,000 MAD).
  List<Money> get targets => [_major(1000), _major(1500), _major(2500)];

  /// Initial suggestion (the middle preset).
  Money get suggested => targets[1];

  /// Increments for the "+" chips (e.g. +1,000 / +5,000 MAD).
  List<Money> get increments => [_major(100), _major(500)];
}
