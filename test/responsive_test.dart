import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flossi/app.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/router/app_router.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/fakes.dart';

// Walks every screen of the real app with big amounts and long titles on
// small phones through tablets, in each language and with enlarged text.
// Tall sizes make lazy lists build all their rows.
const _sizes = <Size>[
  Size(320, 568),
  Size(320, 2600),
  Size(360, 640),
  Size(360, 2600),
  Size(390, 844),
  Size(430, 2600),
  Size(640, 360),
  Size(600, 960),
  Size(768, 1024),
  Size(1280, 800),
];
const _locales = ['en', 'fr', 'ar'];
const _textScales = [1.0, 1.3];

const List<String> _appRoutes = [
  Routes.home,
  Routes.history,
  Routes.stats,
  Routes.settings,
  Routes.addTransaction,
  '/transaction/t0',
  Routes.categories,
  Routes.currencies,
];
const List<String> _onboardingRoutes = [Routes.onboarding, Routes.onboardingCurrency, Routes.onboardingBudget];

final _widgetSource = RegExp(r'(\w+):?\s*file:///.*?/lib/([^\s]+)');

void main() {
  Future<Set<String>> walk(
    WidgetTester tester, {
    required String locale,
    required double textScale,
    required bool onboarded,
    required List<String> routes,
  }) async {
    SharedPreferences.setMockInitialValues({
      'settings.onboardingCompleted': onboarded,
      'settings.homeCurrency': 'MAD',
      'settings.locale': locale,
      'settings.monthlyBudgetMinor': 1234567890,
    });
    final prefs = await SharedPreferences.getInstance();
    final db = AppDatabase(DatabaseConnection(NativeDatabase.memory(), closeStreamsSynchronously: true));
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        appDatabaseProvider.overrideWithValue(db),
        clockProvider.overrideWithValue(FixedClock()),
      ],
    );

    final problems = <String>{};
    final previous = FlutterError.onError;
    FlutterError.onError = (details) {
      final text = details.toString();
      final source = _widgetSource.firstMatch(text);
      final summary = details.exceptionAsString().split('\n').first;
      problems.add('$summary  [${source?.group(2) ?? 'unknown'}]');
    };

    Future<void> settle() async {
      for (var i = 0; i < 6; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 15)));
        await tester.pump(const Duration(milliseconds: 300));
      }
    }

    await tester.runAsync(() async {
      final repository = container.read(transactionRepositoryProvider);
      for (var i = 0; i < 6; i++) {
        await repository.save(
          makeTransaction(
            id: 't$i',
            amount: Money.ofCode(987654321 + i, 'MAD'),
            title: 'A very long merchant name that keeps going and going',
            note: 'A long note about this particular expense',
            date: DateTime(2026, 10, 24 - i, 9, 42),
          ),
        );
      }
    });

    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const FlossiApp()));
    await tester.pump(const Duration(seconds: 3));
    await settle();
    for (final route in routes) {
      container.read(appRouterProvider).go(route);
      await settle();
    }

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
    FlutterError.onError = previous;
    container.dispose();
    await tester.runAsync(db.close);
    return problems;
  }

  for (final size in _sizes) {
    testWidgets('no layout overflow at ${size.width.toInt()}x${size.height.toInt()}', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      final problems = <String>{};
      for (final locale in _locales) {
        for (final textScale in _textScales) {
          tester.platformDispatcher.textScaleFactorTestValue = textScale;
          for (final (onboarded, routes) in [(true, _appRoutes), (false, _onboardingRoutes)]) {
            final found = await walk(tester, locale: locale, textScale: textScale, onboarded: onboarded, routes: routes);
            problems.addAll(found.map((p) => '$locale x$textScale: $p'));
          }
        }
      }
      if (problems.isNotEmpty) fail((problems.toList()..sort()).join(' || '));
    }, timeout: const Timeout(Duration(minutes: 8)));
  }
}
