import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rational/rational.dart';

void main() {
  final mad = CurrencyCatalog.of('MAD');
  final eur = CurrencyCatalog.of('EUR');
  final jpy = CurrencyCatalog.of('JPY');
  final kwd = CurrencyCatalog.of('KWD');

  group('CurrencyCatalog', () {
    test('exposes ISO 4217 minor-unit exponents', () {
      expect(mad.decimals, 2);
      expect(jpy.decimals, 0);
      expect(kwd.decimals, 3);
      expect(CurrencyCatalog.of('TND').decimals, 3);
      expect(CurrencyCatalog.of('KRW').decimals, 0);
    });

    test('lookup is case-insensitive and falls back for unknown codes', () {
      expect(CurrencyCatalog.of('eur'), eur);
      final unknown = CurrencyCatalog.of('XYZ');
      expect(unknown.code, 'XYZ');
      expect(unknown.decimals, 2);
      expect(CurrencyCatalog.isKnown('XYZ'), isFalse);
    });

    test('pins MAD, EUR, USD and excludes them from the rest', () {
      expect(CurrencyCatalog.pinned.map((c) => c.code), ['MAD', 'EUR', 'USD']);
      expect(CurrencyCatalog.others.map((c) => c.code), isNot(contains('MAD')));
    });

    test('search matches code, name and country, ignoring accents', () {
      expect(CurrencyCatalog.search('dirham').map((c) => c.code), containsAll(['MAD', 'AED']));
      expect(CurrencyCatalog.search('morocco').single.code, 'MAD');
      expect(CurrencyCatalog.search('turkiye').single.code, 'TRY');
      expect(CurrencyCatalog.search('  '), hasLength(CurrencyCatalog.all.length));
    });
  });

  group('Money', () {
    test('adds and subtracts in minor units', () {
      final a = Money(1050, mad);
      final b = Money(275, mad);
      expect((a + b).minor, 1325);
      expect((a - b).minor, 775);
      expect((-a).minor, -1050);
    });

    test('rejects mixing currencies', () {
      expect(() => Money(1, mad) + Money(1, eur), throwsArgumentError);
      expect(() => Money(1, mad).compareTo(Money(1, eur)), throwsArgumentError);
    });

    test('equality uses amount and currency code', () {
      expect(Money(100, mad), Money.ofCode(100, 'mad'));
      expect(Money(100, mad), isNot(Money(100, eur)));
    });

    test('toDecimal respects the currency exponent', () {
      expect(Money(125000, mad).toDecimal(), Decimal.parse('1250'));
      expect(Money(1234, jpy).toDecimal(), Decimal.parse('1234'));
      expect(Money(1234, kwd).toDecimal(), Decimal.parse('1.234'));
    });

    test('fromDecimal rounds half-even to minor units', () {
      expect(Money.fromDecimal(Decimal.parse('12.345'), eur).minor, 1234);
      expect(Money.fromDecimal(Decimal.parse('12.355'), eur).minor, 1236);
      expect(Money.fromDecimal(Decimal.parse('12.3451'), eur).minor, 1235);
      expect(Money.fromDecimal(Decimal.parse('-12.345'), eur).minor, -1234);
      expect(Money.fromDecimal(Decimal.parse('1500.5'), jpy).minor, 1500);
      expect(Money.fromDecimal(Decimal.parse('1501.5'), jpy).minor, 1502);
      expect(Money.fromDecimal(Decimal.parse('1.2345'), kwd).minor, 1234);
    });

    test('allocate splits without losing a minor unit', () {
      final parts = Money(1000, mad).allocate(3);
      expect(parts.map((m) => m.minor), [334, 333, 333]);
      expect(sumMoney(parts, mad), Money(1000, mad));

      final negative = Money(-1000, mad).allocate(3);
      expect(negative.map((m) => m.minor), [-334, -333, -333]);
      expect(() => Money(1, mad).allocate(0), throwsArgumentError);
    });

    test('toString prints the fixed major value', () {
      expect(Money(5, mad).toString(), '0.05 MAD');
      expect(Money(7, jpy).toString(), '7 JPY');
    });
  });

  group('roundHalfEven', () {
    int r(int n, int d) => roundHalfEven(Rational(BigInt.from(n), BigInt.from(d)));

    test('rounds ties to the even neighbour', () {
      expect(r(5, 2), 2); // 2.5
      expect(r(7, 2), 4); // 3.5
      expect(r(-5, 2), -2);
      expect(r(-7, 2), -4);
    });

    test('rounds non-ties to the nearest integer', () {
      expect(r(26, 10), 3);
      expect(r(24, 10), 2);
      expect(r(-26, 10), -3);
      expect(r(0, 3), 0);
    });
  });
}
