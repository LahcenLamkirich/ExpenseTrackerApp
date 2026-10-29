import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter/foundation.dart';
import 'package:rational/rational.dart';

/// A directed exchange rate: `1 [from] = [rate] [to]` in major units.
@immutable
class ExchangeRate {
  ExchangeRate({required this.from, required this.to, required this.rate}) {
    if (rate <= Decimal.zero) {
      throw ArgumentError.value(rate, 'rate', 'must be > 0');
    }
  }

  /// `1 x = 1 x`; used when a transaction is already in the home currency.
  factory ExchangeRate.identity(Currency currency) =>
      ExchangeRate(from: currency, to: currency, rate: Decimal.one);

  /// Derives `from → to` from two quotes against a common base, as returned
  /// by rate APIs: `rate(from→to) = rate(base→to) / rate(base→from)`.
  factory ExchangeRate.cross({
    required Currency from,
    required Currency to,
    required Decimal baseToFrom,
    required Decimal baseToTo,
  }) => ExchangeRate(
    from: from,
    to: to,
    rate: _toDecimal(baseToTo / baseToFrom),
  );

  /// Digits kept when a rate is derived by division (cross or inverse).
  static const derivedScale = 12;

  final Currency from;
  final Currency to;
  final Decimal rate;

  bool get isIdentity => from.code == to.code;

  ExchangeRate get inverse =>
      ExchangeRate(from: to, to: from, rate: _toDecimal(rate.inverse));

  /// Converts [amount] (which must be in [from]) into [to], rounding half-even
  /// to the target currency's minor units. Handles differing exponents,
  /// e.g. JPY (0) → KWD (3).
  Money convert(Money amount) {
    if (amount.currency.code != from.code) {
      throw ArgumentError(
        'Expected ${from.code} but got ${amount.currency.code}',
      );
    }
    if (isIdentity) return Money(amount.minor, to);
    final scale = Rational(
      BigInt.from(10).pow(to.decimals),
      BigInt.from(10).pow(from.decimals),
    );
    final result = Rational.fromInt(amount.minor) * rate.toRational() * scale;
    return Money(roundHalfEven(result), to);
  }

  @override
  bool operator ==(Object other) =>
      other is ExchangeRate &&
      other.from == from &&
      other.to == to &&
      other.rate == rate;

  @override
  int get hashCode => Object.hash(from, to, rate);

  @override
  String toString() => '1 ${from.code} = $rate ${to.code}';

  static Decimal _toDecimal(Rational r) =>
      r.toDecimal(scaleOnInfinitePrecision: derivedScale);
}
