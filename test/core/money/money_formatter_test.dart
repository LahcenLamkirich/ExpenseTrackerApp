import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

/// Normalizes the various non-breaking spaces intl emits so expectations
/// stay readable.
String _n(String s) => s.replaceAll(RegExp('[  ]'), ' ');

void main() {
  final mad = CurrencyCatalog.of('MAD');
  final eur = CurrencyCatalog.of('EUR');
  final usd = CurrencyCatalog.of('USD');
  final jpy = CurrencyCatalog.of('JPY');
  final kwd = CurrencyCatalog.of('KWD');

  group('en', () {
    final f = MoneyFormatter('en');

    test('symbol currencies are prefixed', () {
      expect(f.format(Money(1250, eur)), '€12.50');
      expect(f.format(Money(1250, usd)), r'$12.50');
      expect(f.format(Money(150000, jpy)), '¥150,000');
    });

    test('code currencies get an ISO suffix', () {
      expect(_n(f.format(Money(1248050, mad))), '12,480.50 MAD');
      expect(_n(f.format(Money(1234, kwd))), '1.234 KWD');
    });

    test('signs', () {
      expect(_n(f.format(Money(-4500, mad))), '-45.00 MAD');
      expect(f.format(Money(-1250, eur)), '-€12.50');
      expect(f.format(Money(1250, eur), signed: true), '+€12.50');
      expect(f.format(Money(-1250, eur), absolute: true), '€12.50');
      expect(f.format(Money(0, eur), signed: true), '€0.00');
    });

    test('display overrides', () {
      expect(_n(f.format(Money(1250, eur), display: MoneyDisplay.code)), '12.50 EUR');
      expect(f.format(Money(1250, mad), display: MoneyDisplay.symbol), 'DH12.50');
      expect(f.formatNumber(Money(1248050, mad)), '12,480.50');
      expect(_n(f.format(Money(150000, mad), trimZeroFraction: true)), '1,500 MAD');
    });

    test('parts split integer and fraction', () {
      final p = f.parts(Money(148620, usd));
      expect(p.integer, '1,486');
      expect(p.fraction, '20');
      expect(p.currency, r'$');
      expect(p.currencyFirst, isTrue);
    });

    test('rates', () {
      final rate = ExchangeRate(from: eur, to: mad, rate: Decimal.parse('10.84'));
      expect(f.formatRate(rate), '1 EUR = 10.84 MAD');
      expect(f.formatRateValue(Decimal.parse('10.845123')), '10.8451');
      expect(f.formatRateValue(Decimal.parse('0.0668')), '0.0668');
      expect(f.formatRateValue(Decimal.parse('1200')), '1,200.00');
    });
  });

  group('fr', () {
    final f = MoneyFormatter('fr');

    test('code suffix with French grouping and comma', () {
      expect(_n(f.format(Money(125000, mad))), '1 250,00 MAD');
    });

    test('symbol goes after the number', () {
      expect(_n(f.format(Money(1250, eur))), '12,50 €');
      expect(_n(f.format(Money(-1250, eur))), '-12,50 €');
    });
  });

  group('ar', () {
    final f = MoneyFormatter('ar');

    test('formats with Arabic separators and keeps the code', () {
      final out = f.format(Money(125000, mad));
      expect(out, contains('MAD'));
      expect(out, contains(f.decimalSeparator));
      expect(f.parts(Money(125000, mad)).fraction.length, 2);
    });
  });
}
