import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_keypad.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/transactions/presentation/transaction_editor_screen.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

String _n(String s) => s.replaceAll(RegExp('[  ]'), ' ');

void main() {
  late AppDatabase db;

  // Drift runs real async work; let it complete between fake-async frames.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 12; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 5)));
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pumpEditor(WidgetTester tester, {Map<String, String>? eurRates}) async {
    db = AppDatabase(NativeDatabase.memory());
    await tester.runAsync(() async {
      await TrackedCurrencyRepository(db).ensure(['MAD', 'EUR', 'USD']);
      if (eurRates != null) {
        await insertSnapshot(db, base: 'EUR', rates: eurRates, fetchedAt: DateTime(2026, 10, 24, 8));
      }
    });
    addTearDown(() => tester.runAsync(db.close));

    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    SharedPreferences.setMockInitialValues({
      'settings.onboardingCompleted': true,
      'settings.homeCurrency': 'MAD',
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWithValue(db),
          clockProvider.overrideWithValue(FixedClock()),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => const TransactionEditorScreen()),
                  ),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await settle(tester);
  }

  Future<void> typeKeys(WidgetTester tester, String keys) async {
    for (final k in keys.split('')) {
      final finder = k == '.'
          ? find.descendant(of: find.byType(AmountKeypad), matching: find.text('.'))
          : find.descendant(of: find.byType(AmountKeypad), matching: find.text(k));
      await tester.tap(finder);
      await tester.pump();
    }
  }

  Finder saveButton() => find.widgetWithText(FilledButton, 'Save expense');

  testWidgets('keypad entry, currency switch with live conversion, then save', (tester) async {
    await pumpEditor(tester, eurRates: {'MAD': '10.84'});

    expect(find.text('Add expense'), findsOneWidget);
    expect(tester.widget<FilledButton>(saveButton()).onPressed, isNull);

    await typeKeys(tester, '240');
    expect(find.textContaining('240', findRichText: true), findsWidgets);

    // Home currency needs no conversion pill.
    expect(find.textContaining('≈', findRichText: true), findsNothing);

    await tester.tap(find.widgetWithText(CurrencyChip, 'EUR'));
    await settle(tester);

    final pill = find.textContaining('2,601.60', findRichText: true);
    expect(pill, findsOneWidget);
    expect(_n(tester.widget<RichText>(pill).text.toPlainText()), contains('1 EUR = 10.84 MAD'));

    expect(tester.widget<FilledButton>(saveButton()).onPressed, isNotNull);
    await tester.tap(saveButton());
    await settle(tester);

    final rows = (await tester.runAsync(() => db.select(db.transactions).get()))!;
    expect(rows, hasLength(1));
    final row = rows.single;
    expect(row.amountMinor, 24000);
    expect(row.currencyCode, 'EUR');
    expect(row.homeCurrencyCode, 'MAD');
    expect(row.fxRate, Decimal.parse('10.84'));
    expect(row.homeAmountMinor, 260160);
    expect(row.rateSource, RateSource.api);
    expect(row.categoryId, 'cat_dining');
    expect(find.text('Transaction saved'), findsOneWidget);
    // Unmount so drift's stream-close timers fire before the test ends.
    await tester.pumpWidget(const SizedBox());
    await settle(tester);
  });

  // TODO(lahcen): hangs after the manual-rate sheet saves (drift transaction under
  // fake async). Revisit if the exchange features are kept.
  testWidgets('missing rate blocks saving until a manual rate is entered', skip: true, (tester) async {
    await pumpEditor(tester);
    await typeKeys(tester, '12.5');
    final usd = find.widgetWithText(CurrencyChip, 'USD');
    await tester.ensureVisible(usd);
    await tester.pump();
    await tester.tap(usd);
    await settle(tester);

    expect(find.text('No rate yet · tap to enter'), findsOneWidget);
    expect(tester.widget<FilledButton>(saveButton()).onPressed, isNull);

    await tester.tap(find.text('No rate yet · tap to enter'));
    await settle(tester);
    await tester.enterText(find.byType(TextField).last, '10.05');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await settle(tester);

    // 12.50 × 10.05 = 125.625 → half-even → 125.62
    expect(find.textContaining('125.62', findRichText: true), findsOneWidget);

    await tester.tap(saveButton());
    await settle(tester);
    final row = (await tester.runAsync(() => db.select(db.transactions).get()))!.single;
    expect(row.homeAmountMinor, 12562);
    expect(row.rateSource, RateSource.manual);
  });
}
