import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final eur = CurrencyCatalog.of('EUR');
  final jpy = CurrencyCatalog.of('JPY');
  final kwd = CurrencyCatalog.of('KWD');

  MoneyInput type(MoneyInput input, String keys) {
    var next = input;
    for (final k in keys.split('')) {
      next = switch (k) {
        '.' => next.appendDecimalSeparator(),
        '<' => next.backspace(),
        _ => next.appendDigit(int.parse(k)),
      };
    }
    return next;
  }

  test('builds minor units from typed digits', () {
    expect(type(MoneyInput.empty(eur), '240').minor, 24000);
    expect(type(MoneyInput.empty(eur), '240.5').minor, 24050);
    expect(type(MoneyInput.empty(eur), '240.55').minor, 24055);
    expect(type(MoneyInput.empty(eur), '.5').raw, '0.5');
    expect(MoneyInput.empty(eur).minor, 0);
  });

  test('caps fraction digits at the currency exponent', () {
    expect(type(MoneyInput.empty(eur), '1.239').raw, '1.23');
    expect(type(MoneyInput.empty(kwd), '1.2345').minor, 1234);
    expect(type(MoneyInput.empty(jpy), '15.5').raw, '155');
    expect(type(MoneyInput.empty(jpy), '1500').minor, 1500);
  });

  test('ignores leading zeros and a second separator', () {
    expect(type(MoneyInput.empty(eur), '007').raw, '7');
    expect(type(MoneyInput.empty(eur), '1..2').raw, '1.2');
  });

  test('caps integer digits', () {
    final long = type(MoneyInput.empty(eur), '9' * 20);
    expect(long.integerPart.length, MoneyInput.maxIntegerDigits);
  });

  test('backspace removes the last key and clears a lone zero', () {
    expect(type(MoneyInput.empty(eur), '12.5<').raw, '12.');
    expect(type(MoneyInput.empty(eur), '12.5<<').raw, '12');
    expect(type(MoneyInput.empty(eur), '0.<').raw, '');
    expect(MoneyInput.empty(eur).backspace().isEmpty, isTrue);
  });

  test('switching currency trims unsupported decimals', () {
    final input = type(MoneyInput.empty(eur), '12.55');
    expect(input.withCurrency(jpy).raw, '12');
    expect(input.withCurrency(jpy).minor, 12);
    expect(input.withCurrency(kwd).minor, 12550);
    expect(type(MoneyInput.empty(kwd), '1.234').withCurrency(eur).raw, '1.23');
  });

  test('prefills from existing money', () {
    expect(MoneyInput.fromMoney(Money(24000, eur)).raw, '240');
    expect(MoneyInput.fromMoney(Money(24050, eur)).raw, '240.5');
    expect(MoneyInput.fromMoney(Money(5, eur)).raw, '0.05');
    expect(MoneyInput.fromMoney(Money(1500, jpy)).raw, '1500');
    expect(MoneyInput.fromMoney(Money(0, eur)).isEmpty, isTrue);
    expect(MoneyInput.fromMoney(Money(24050, eur)).toMoney(), Money(24050, eur));
  });
}
