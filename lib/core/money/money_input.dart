import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter/foundation.dart';

/// Immutable buffer behind the custom amount keypad.
///
/// Holds the raw digits typed by the user (always with `.` as the decimal
/// separator internally) and converts to [Money] with integer math only.
/// The number of fraction digits is capped by the currency exponent, so JPY
/// accepts no decimals and KWD accepts three.
@immutable
class MoneyInput {
  const MoneyInput._(this.raw, this.currency);

  const MoneyInput.empty(Currency currency) : this._('', currency);

  /// Pre-fills the keypad from an existing amount (edit flow). Trailing
  /// zero fraction digits are kept off so the user can keep typing.
  factory MoneyInput.fromMoney(Money money) {
    if (money.isZero) return MoneyInput.empty(money.currency);
    final abs = money.minor.abs();
    final decimals = money.currency.decimals;
    if (decimals == 0) return MoneyInput._('$abs', money.currency);
    final padded = abs.toString().padLeft(decimals + 1, '0');
    final intPart = padded.substring(0, padded.length - decimals);
    var frac = padded.substring(padded.length - decimals);
    frac = frac.replaceFirst(RegExp(r'0+$'), '');
    return MoneyInput._(
      frac.isEmpty ? intPart : '$intPart.$frac',
      money.currency,
    );
  }

  /// Upper bound on integer digits; keeps minor units well inside int64.
  static const maxIntegerDigits = 12;

  final String raw;
  final Currency currency;

  bool get isEmpty => raw.isEmpty;
  bool get hasDecimalSeparator => raw.contains('.');

  String get integerPart => raw.split('.').first;
  String get fractionPart => hasDecimalSeparator ? raw.split('.')[1] : '';

  MoneyInput appendDigit(int digit) {
    assert(digit >= 0 && digit <= 9, 'digit must be 0-9');
    if (hasDecimalSeparator) {
      if (fractionPart.length >= currency.decimals) return this;
      return MoneyInput._('$raw$digit', currency);
    }
    if (raw == '0') {
      // Replace a lone leading zero instead of producing "07".
      return MoneyInput._('$digit', currency);
    }
    if (integerPart.length >= maxIntegerDigits) return this;
    return MoneyInput._('$raw$digit', currency);
  }

  MoneyInput appendDecimalSeparator() {
    if (currency.decimals == 0 || hasDecimalSeparator) return this;
    return MoneyInput._(raw.isEmpty ? '0.' : '$raw.', currency);
  }

  MoneyInput backspace() {
    if (raw.isEmpty) return this;
    final next = raw.substring(0, raw.length - 1);
    return MoneyInput._(next == '0' ? '' : next, currency);
  }

  MoneyInput clear() => MoneyInput.empty(currency);

  /// Switching currency keeps the typed value but trims fraction digits the
  /// new currency cannot represent (e.g. EUR 12.50 → JPY 12).
  MoneyInput withCurrency(Currency next) {
    if (next.code == currency.code) return this;
    if (!hasDecimalSeparator) return MoneyInput._(raw, next);
    if (next.decimals == 0) return MoneyInput._(integerPart, next);
    final frac = fractionPart.length > next.decimals
        ? fractionPart.substring(0, next.decimals)
        : fractionPart;
    return MoneyInput._('$integerPart.$frac', next);
  }

  /// Exact value in minor units.
  int get minor {
    if (raw.isEmpty) return 0;
    final intDigits = integerPart.isEmpty ? '0' : integerPart;
    final frac = fractionPart.padRight(currency.decimals, '0');
    return int.parse('$intDigits$frac');
  }

  Money toMoney() => Money(minor, currency);

  @override
  bool operator ==(Object other) =>
      other is MoneyInput && other.raw == raw && other.currency == currency;

  @override
  int get hashCode => Object.hash(raw, currency);

  @override
  String toString() => 'MoneyInput($raw ${currency.code})';
}
