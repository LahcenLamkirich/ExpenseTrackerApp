import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/onboarding/domain/budget_presets.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';

void main() {
  final mad = CurrencyCatalog.of('MAD');
  final eur = CurrencyCatalog.of('EUR');

  group('HomeAmountResolver', () {
    final converted = makeTransaction(
      amount: Money.ofCode(12000, 'EUR'),
      homeAmount: Money.ofCode(130140, 'MAD'),
      fxRate: '10.845',
    );

    test('uses the frozen home amount when the home currency is unchanged', () {
      final r = HomeAmountResolver(mad).resolve(converted)!;
      expect(r.amount, Money.ofCode(130140, 'MAD'));
      expect(r.source, HomeAmountSource.stored);
    });

    test('uses the original amount when it is in the new home currency', () {
      final r = HomeAmountResolver(eur).resolve(converted)!;
      expect(r.amount, Money.ofCode(12000, 'EUR'));
      expect(r.source, HomeAmountSource.original);
    });

    test('re-converts through the supplied converter, else unresolved', () {
      final usd = CurrencyCatalog.of('USD');
      expect(HomeAmountResolver(usd).resolve(converted), isNull);
      final withRates = HomeAmountResolver(
        usd,
        convert: (amount, to, at) => Money((amount.minor * 108) ~/ 100, to),
      );
      final r = withRates.resolve(converted)!;
      expect(r.amount, Money.ofCode(12960, 'USD'));
      expect(r.isApproximate, isTrue);
    });
  });

  group('TransactionFilter', () {
    String names(String id) => id == 'cat_dining' ? 'Dining' : 'Groceries';
    final coffee = makeTransaction(id: 'a', title: 'Espresso Lab', note: 'oat milk');
    final flight = makeTransaction(
      id: 'b',
      amount: Money.ofCode(12000, 'EUR'),
      homeAmount: Money.ofCode(130140, 'MAD'),
      categoryId: 'cat_groceries',
      type: TransactionType.income,
    );

    test('empty filter matches everything', () {
      const f = TransactionFilter();
      expect(f.matches(coffee, names), isTrue);
      expect(f.matches(flight, names), isTrue);
      expect(f.hasRefinements, isFalse);
    });

    test('search matches title, note, category name and currency code', () {
      expect(const TransactionFilter(query: 'espresso').matches(coffee, names), isTrue);
      expect(const TransactionFilter(query: 'OAT').matches(coffee, names), isTrue);
      expect(const TransactionFilter(query: 'groc').matches(flight, names), isTrue);
      expect(const TransactionFilter(query: 'eur').matches(flight, names), isTrue);
      expect(const TransactionFilter(query: 'eur').matches(coffee, names), isFalse);
    });

    test('refinements combine with AND', () {
      const f = TransactionFilter(currencyCodes: {'EUR'}, type: TransactionType.income);
      expect(f.matches(flight, names), isTrue);
      expect(f.matches(coffee, names), isFalse);
      expect(const TransactionFilter(categoryIds: {'cat_dining'}).matches(flight, names), isFalse);
      expect(f.hasRefinements, isTrue);
    });

    test('DateSpan is start-inclusive and end-exclusive', () {
      final oct = DateSpan.month(DateTime(2026, 10, 15));
      expect(oct.contains(DateTime(2026, 10)), isTrue);
      expect(oct.contains(DateTime(2026, 10, 31, 23, 59)), isTrue);
      expect(oct.contains(DateTime(2026, 11)), isFalse);
      expect(oct.lastDay, DateTime(2026, 10, 31));
      expect(DateSpan.days(DateTime(2026, 10, 2), DateTime(2026, 10, 5)).end, DateTime(2026, 10, 6));
    });
  });

  group('groupByDay', () {
    test('groups newest first and nets income against expenses', () {
      final items = [
        makeTransaction(id: '1', date: DateTime(2026, 10, 23, 8), amount: Money.ofCode(4500, 'MAD')),
        makeTransaction(id: '2', date: DateTime(2026, 10, 24, 9), amount: Money.ofCode(10000, 'MAD')),
        makeTransaction(
          id: '3',
          date: DateTime(2026, 10, 24, 18),
          type: TransactionType.income,
          amount: Money.ofCode(2500, 'MAD'),
        ),
        makeTransaction(
          id: '4',
          date: DateTime(2026, 10, 23, 20),
          amount: Money.ofCode(1100, 'EUR'),
          homeAmount: Money.ofCode(12000, 'MAD'),
        ),
      ];
      final groups = groupByDay(items, HomeAmountResolver(mad));
      expect(groups.map((g) => g.day), [DateTime(2026, 10, 24), DateTime(2026, 10, 23)]);
      expect(groups.first.items.map((t) => t.id), ['3', '2']);
      expect(groups.first.net, Money.ofCode(-7500, 'MAD'));
      expect(groups.first.approximate, isFalse);
      expect(groups.last.net, Money.ofCode(-16500, 'MAD'));
      expect(groups.last.approximate, isTrue);
    });
  });

  group('BudgetPresets', () {
    test('scale to the currency magnitude', () {
      expect(BudgetPresets.of(mad).targets.map((m) => m.minor), [1000000, 1500000, 2500000]);
      expect(BudgetPresets.of(eur).suggested, Money.ofCode(150000, 'EUR'));
      expect(BudgetPresets.of(CurrencyCatalog.of('JPY')).suggested, Money.ofCode(225000, 'JPY'));
      expect(BudgetPresets.of(mad).increments.map((m) => m.minor), [100000, 500000]);
    });
  });
}
