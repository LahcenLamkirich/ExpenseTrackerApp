import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flutter/foundation.dart';
import 'package:rational/rational.dart';

/// An exact monetary amount: integer minor units plus a currency.
///
/// Doubles are never used for money. Arithmetic between different
/// currencies throws; convert explicitly with an `ExchangeRate`.
@immutable
class Money implements Comparable<Money> {
  const Money(this.minor, this.currency);

  const Money.zero(this.currency) : minor = 0;

  factory Money.ofCode(int minor, String currencyCode) =>
      Money(minor, CurrencyCatalog.of(currencyCode));

  /// Builds money from a decimal major-unit value, rounding half-even to the
  /// currency's minor units (e.g. `Decimal.parse('12.345')` EUR → 1234).
  factory Money.fromDecimal(Decimal major, Currency currency) => Money(
    roundHalfEven(major.toRational() * _pow10(currency.decimals)),
    currency,
  );

  final int minor;
  final Currency currency;

  String get currencyCode => currency.code;

  bool get isZero => minor == 0;
  bool get isNegative => minor < 0;
  bool get isPositive => minor > 0;

  /// Exact major-unit value, e.g. 1250 MAD minor → 12.50.
  Decimal toDecimal() =>
      Decimal.fromInt(minor).shift(-currency.decimals);

  Money operator +(Money other) {
    _assertSameCurrency(other);
    return Money(minor + other.minor, currency);
  }

  Money operator -(Money other) {
    _assertSameCurrency(other);
    return Money(minor - other.minor, currency);
  }

  Money operator -() => Money(-minor, currency);

  Money abs() => Money(minor.abs(), currency);

  /// Multiplies by an integer factor (exact).
  Money times(int factor) => Money(minor * factor, currency);

  /// Splits into [parts] amounts that sum exactly to this amount; the
  /// remainder is spread over the first items (largest-remainder method).
  List<Money> allocate(int parts) {
    if (parts <= 0) throw ArgumentError.value(parts, 'parts', 'must be > 0');
    final base = minor ~/ parts;
    var remainder = minor - base * parts;
    final step = remainder.sign;
    return List.generate(parts, (_) {
      if (remainder == 0) return Money(base, currency);
      remainder -= step;
      return Money(base + step, currency);
    });
  }

  /// Ratio of this amount to [other] in the range of doubles. Only for
  /// display purposes (progress bars, percentages), never for money math.
  double ratioTo(Money other) {
    _assertSameCurrency(other);
    if (other.minor == 0) return 0;
    return minor / other.minor;
  }

  void _assertSameCurrency(Money other) {
    if (other.currency.code != currency.code) {
      throw ArgumentError(
        'Currency mismatch: ${currency.code} vs ${other.currency.code}',
      );
    }
  }

  @override
  int compareTo(Money other) {
    _assertSameCurrency(other);
    return minor.compareTo(other.minor);
  }

  bool operator <(Money other) => compareTo(other) < 0;
  bool operator >(Money other) => compareTo(other) > 0;
  bool operator <=(Money other) => compareTo(other) <= 0;
  bool operator >=(Money other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minor == minor &&
      other.currency.code == currency.code;

  @override
  int get hashCode => Object.hash(minor, currency.code);

  @override
  String toString() =>
      '${toDecimal().toStringAsFixed(currency.decimals)} ${currency.code}';
}

/// Sums a list of amounts that share [currency].
Money sumMoney(Iterable<Money> amounts, Currency currency) =>
    amounts.fold(Money.zero(currency), (acc, m) => acc + m);

/// Rounds a rational to the nearest integer, ties to even (banker's
/// rounding), which avoids systematic bias when summing converted amounts.
int roundHalfEven(Rational value) {
  final n = value.numerator;
  final d = value.denominator; // always positive
  var q = n ~/ d; // truncates toward zero
  final twiceRemainder = (n - q * d).abs() * BigInt.two;
  if (twiceRemainder > d || (twiceRemainder == d && q.isOdd)) {
    q += n.isNegative ? -BigInt.one : BigInt.one;
  }
  return q.toInt();
}

Rational _pow10(int exp) => Rational(BigInt.from(10).pow(exp));
