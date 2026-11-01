import 'package:flossi/core/widgets/splash_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the tagline, then reveals the app', (tester) async {
    await tester.pumpApp(const SplashGate(child: Text('app')));
    final tagline = find.text('Expense tracker');
    double opacity() => tester
        .widget<FadeTransition>(find.ancestor(of: tagline, matching: find.byType(FadeTransition)).first)
        .opacity
        .value;

    expect(tagline, findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1500));
    expect(opacity(), 1);
    expect(tester.getBottomLeft(tagline).dy, lessThan(tester.view.physicalSize.height / tester.view.devicePixelRatio));

    await tester.pumpAndSettle();
    expect(tagline, findsNothing);
    expect(find.text('app'), findsOneWidget);
  });
}
