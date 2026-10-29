import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mad = CurrencyCatalog.of('MAD');
  final eur = CurrencyCatalog.of('EUR');
  final usd = CurrencyCatalog.of('USD');
  final jpy = CurrencyCatalog.of('JPY');
  final kwd = CurrencyCatalog.of('KWD');

  Decimal d(String s) => Decimal.parse(s);

  group('ExchangeRate.convert', () {
    test('converts EUR to MAD like the Add Expense design', () {
      final rate = ExchangeRate(from: eur, to: mad, rate: d('10.84'));
      // €240.00 → 2,601.60 MAD
      expect(rate.convert(Money(24000, eur)), Money(260160, mad));
    });

    test('rounds half-even to the target minor unit', () {
      final rate = ExchangeRate(from: eur, to: mad, rate: d('10.845'));
      // 0.10 EUR × 10.845 = 1.0845 MAD → 1.08
      expect(rate.convert(Money(10, eur)).minor, 108);
      // 0.30 EUR × 10.845 = 3.2535 → 3.25
      expect(rate.convert(Money(30, eur)).minor, 325);
      final tie = ExchangeRate(from: eur, to: mad, rate: d('1.25'));
      // 0.10 × 1.25 = 0.125 → 0.12 (tie to even)
      expect(tie.convert(Money(10, eur)).minor, 12);
      // 0.30 × 1.25 = 0.375 → 0.38
      expect(tie.convert(Money(30, eur)).minor, 38);
    });

    test('handles different exponents in both directions', () {
      // 1,000 JPY at 0.0668 MAD/JPY = 66.80 MAD
      final jpyMad = ExchangeRate(from: jpy, to: mad, rate: d('0.0668'));
      expect(jpyMad.convert(Money(1000, jpy)), Money(6680, mad));

      // 100.00 MAD at 14.97 JPY/MAD = 1,497 JPY (no minor units)
      final madJpy = ExchangeRate(from: mad, to: jpy, rate: d('14.97'));
      expect(madJpy.convert(Money(10000, mad)), Money(1497, jpy));

      // 1.234 KWD at 32.6 MAD/KWD = 40.2284 MAD → 40.23
      final kwdMad = ExchangeRate(from: kwd, to: mad, rate: d('32.6'));
      expect(kwdMad.convert(Money(1234, kwd)), Money(4023, mad));

      // 10,000 JPY → KWD at 0.00205 = 20.500 KWD
      final jpyKwd = ExchangeRate(from: jpy, to: kwd, rate: d('0.00205'));
      expect(jpyKwd.convert(Money(10000, jpy)), Money(20500, kwd));
    });

    test('keeps the sign for negative amounts', () {
      final rate = ExchangeRate(from: eur, to: mad, rate: d('10.84'));
      expect(rate.convert(Money(-24000, eur)), Money(-260160, mad));
    });

    test('identity returns the same minor units', () {
      expect(ExchangeRate.identity(mad).convert(Money(4500, mad)), Money(4500, mad));
      expect(ExchangeRate.identity(mad).isIdentity, isTrue);
    });

    test('rejects an amount in the wrong currency', () {
      final rate = ExchangeRate(from: eur, to: mad, rate: d('10.84'));
      expect(() => rate.convert(Money(1, usd)), throwsArgumentError);
    });

    test('rejects non-positive rates', () {
      expect(() => ExchangeRate(from: eur, to: mad, rate: Decimal.zero), throwsArgumentError);
      expect(() => ExchangeRate(from: eur, to: mad, rate: d('-1')), throwsArgumentError);
    });

    test('large amounts stay exact (no double drift)', () {
      final rate = ExchangeRate(from: usd, to: mad, rate: d('10.05'));
      // 99,999,999,999.99 USD
      final big = Money(9999999999999, usd);
      // × 10.05 = 1,004,999,999,999.8995 MAD → 100499999999990 minor
      expect(rate.convert(big).minor, 100499999999990);
    });
  });

  group('cross and inverse', () {
    test('cross rate from a common base', () {
      // base USD: 1 USD = 0.9268 EUR, 1 USD = 10.05 MAD
      final eurMad = ExchangeRate.cross(
        from: eur,
        to: mad,
        baseToFrom: d('0.9268'),
        baseToTo: d('10.05'),
      );
      expect(eurMad.rate.round(scale: 4), d('10.8438'));
      expect(eurMad.convert(Money(10000, eur)).minor, 108438);
    });

    test('cross from the base itself equals the quoted rate', () {
      final usdMad = ExchangeRate.cross(
        from: usd,
        to: mad,
        baseToFrom: Decimal.one,
        baseToTo: d('10.05'),
      );
      expect(usdMad.rate, d('10.05'));
    });

    test('inverse round-trips within one minor unit', () {
      final eurMad = ExchangeRate(from: eur, to: mad, rate: d('10.84'));
      final madEur = eurMad.inverse;
      expect(madEur.from, mad);
      expect(madEur.to, eur);
      final back = madEur.convert(eurMad.convert(Money(12345, eur)));
      expect((back.minor - 12345).abs(), lessThanOrEqualTo(1));
    });
  });
}
