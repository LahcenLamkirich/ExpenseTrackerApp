import 'package:drift/native.dart';
import 'package:flossi/app.dart';
import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Future<void> pumpFlossi(WidgetTester tester, Map<String, Object> prefsValues) async {
    SharedPreferences.setMockInitialValues(prefsValues);
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          appDatabaseProvider.overrideWith((ref) {
            final db = AppDatabase(NativeDatabase.memory());
            ref.onDispose(db.close);
            return db;
          }),
        ],
        child: const FlossiApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  // TODO(phase-6): re-enable with the drift-aware settle helper.
  testWidgets('first launch runs the 3-step onboarding, then enters the shell', skip: true, (tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpFlossi(tester, {});
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Home'), findsNothing);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Choose your home currency'), findsOneWidget);

    await tester.tap(find.text('EUR').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirm home currency (EUR)'));
    await tester.pumpAndSettle();
    expect(find.text('Set your monthly spending target'), findsOneWidget);

    await tester.tap(find.text('Complete setup & enter Flossi'));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('HOME'), findsOneWidget);
  });

  // TODO: dashboard DB streams under fake async; same issue as the onboarding test.
  testWidgets('returning user lands on Home and can switch tabs', skip: true, (tester) async {
    await pumpFlossi(tester, {'settings.onboardingCompleted': true, 'settings.homeCurrency': 'MAD'});
    expect(find.text('HOME'), findsOneWidget);

    await tester.tap(find.text('Stats'));
    await tester.pumpAndSettle();
    expect(find.text('STATS'), findsOneWidget);
  });

  testWidgets('Arabic locale renders right-to-left', skip: true, (tester) async {
    await pumpFlossi(tester, {
      'settings.onboardingCompleted': true,
      'settings.locale': 'ar',
    });
    final context = tester.element(find.byType(Scaffold).first);
    expect(Directionality.of(context), TextDirection.rtl);
    expect(find.text('الرئيسية'), findsWidgets);
  });
}
