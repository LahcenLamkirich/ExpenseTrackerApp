import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/floating_nav_bar.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

String _n(String s) => s.replaceAll(RegExp('[  ]'), ' ');

void main() {
  final mad = CurrencyCatalog.of('MAD');
  final eur = CurrencyCatalog.of('EUR');

  group('AmountText', () {
    testWidgets('formats per locale', (tester) async {
      await tester.pumpApp(AmountText(Money(125000, mad)), locale: const Locale('fr'));
      expect(_n(tester.widget<Text>(find.byType(Text)).data!), '1 250,00 MAD');
    });

    testWidgets('colours by sign and marks approximations', (tester) async {
      await tester.pumpApp(AmountText(Money(-4500, mad), colorBySign: true, approximate: true));
      final text = tester.widget<Text>(find.byType(Text));
      expect(_n(text.data!), '≈ -45.00 MAD');
      expect(text.style?.color, AppColors.light.expense);
    });
  });

  group('HeroAmount', () {
    testWidgets('counts up to the target without doubles', (tester) async {
      await tester.pumpApp(HeroAmount(Money(1248050, mad), animateFromZero: true));
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();
      expect(find.bySemanticsLabel(RegExp('12,480.50')), findsOneWidget);
      expect(find.textContaining('12,480', findRichText: true), findsOneWidget);
      expect(find.text('MAD'), findsOneWidget);
    });
  });

  group('CurrencyChip', () {
    testWidgets('selected chip uses the inverted colours', (tester) async {
      var taps = 0;
      await tester.pumpApp(CurrencyChip(currency: eur, selected: true, onTap: () => taps++));
      expect(find.text('EUR'), findsOneWidget);
      expect(find.text('€'), findsOneWidget);
      final code = tester.widget<Text>(find.text('EUR'));
      expect(code.style?.color, AppColors.light.onSelectedChip);
      await tester.tap(find.byType(CurrencyChip));
      expect(taps, 1);
    });
  });

  group('SegmentedPill', () {
    testWidgets('reports the tapped segment', (tester) async {
      String? picked;
      await tester.pumpApp(
        SegmentedPill<String>(
          selected: 'm',
          onChanged: (v) => picked = v,
          segments: const [
            Segment(value: 'w', label: 'Week'),
            Segment(value: 'm', label: 'Month'),
          ],
        ),
      );
      await tester.tap(find.text('Week'));
      expect(picked, 'w');
    });
  });

  group('FloatingNavBar', () {
    testWidgets('selects tabs and triggers add', (tester) async {
      var selected = -1;
      var added = false;
      await tester.pumpApp(
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingNavBar(
            currentIndex: 0,
            onSelected: (i) => selected = i,
            onAdd: () => added = true,
            addLabel: 'Add',
            items: const [
              FloatingNavItem(icon: Icons.home, label: 'Home'),
              FloatingNavItem(icon: Icons.history, label: 'History'),
              FloatingNavItem(icon: Icons.insights, label: 'Stats'),
              FloatingNavItem(icon: Icons.settings, label: 'Settings'),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Stats'));
      expect(selected, 2);
      await tester.tap(find.byIcon(Icons.add_rounded));
      expect(added, isTrue);

      // The active tab label is painted in the lime accent.
      final context = tester.element(find.text('Home'));
      expect(DefaultTextStyle.of(context).style.color, context.colors.accent);
    });
  });
}
