// Generates the app icon and splash images from Flutter widgets so they
// match the in-app logo exactly.
//
//   flutter test tool/brand_assets_test.dart
//   dart run flutter_launcher_icons
//   dart run flutter_native_splash:create
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flossi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _outDir = 'assets/branding';

Future<void> _loadFont() async {
  final loader = FontLoader('PlusJakartaSans')
    ..addFont(
      File('assets/fonts/PlusJakartaSans-ExtraBold.ttf').readAsBytes().then((b) => ByteData.view(b.buffer)),
    );
  await loader.load();
}

/// The "f" glyph, optically centred inside a [size] box.
Widget _glyph(double size, Color color) => SizedBox.square(
  dimension: size,
  child: Center(
    child: Transform.translate(
      offset: Offset(0, size * 0.055),
      child: Text(
        'f',
        textDirection: TextDirection.ltr,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontWeight: FontWeight.w800,
          fontSize: size,
          height: 1,
          color: color,
          letterSpacing: -size * 0.02,
        ),
      ),
    ),
  ),
);

Future<void> _render(WidgetTester tester, String name, double size, Widget child) async {
  final key = GlobalKey();
  tester.view.physicalSize = Size.square(size);
  tester.view.devicePixelRatio = 1;
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(key: key, child: SizedBox.square(dimension: size, child: child)),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.runAsync(() async {
    final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$_outDir/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(_loadFont);
  tearDown(() => TestWidgetsFlutterBinding.instance.platformDispatcher.views.first.reset());

  // Full-bleed icon (iOS, legacy Android): lime square, ink "f".
  testWidgets('icon', (tester) async {
    await _render(tester, 'icon', 1024, ColoredBox(color: Palette.lime, child: Center(child: _glyph(700, Palette.ink))));
  });

  // Android adaptive foreground: glyph inside the 66% safe zone.
  testWidgets('icon_foreground', (tester) async {
    await _render(tester, 'icon_foreground', 1024, Center(child: _glyph(500, Palette.ink)));
  });

  // Splash: the rounded lime tile from the in-app logo, centred with room
  // for the Android 12 circular mask.
  testWidgets('splash_logo', (tester) async {
    await _render(
      tester,
      'splash_logo',
      1152,
      Center(
        child: Container(
          width: 560,
          height: 560,
          decoration: BoxDecoration(color: Palette.lime, borderRadius: BorderRadius.circular(560 * 0.3)),
          child: Center(child: _glyph(400, Palette.ink)),
        ),
      ),
    );
  });
}
