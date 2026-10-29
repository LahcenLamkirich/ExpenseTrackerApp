import 'package:flutter/material.dart';

/// Type scale from the design system (Plus Jakarta Sans). Styles are
/// colourless; colours come from the theme.
abstract final class AppTypography {
  static const fontFamily = 'PlusJakartaSans';

  static const _tabular = [FontFeature.tabularFigures()];

  static TextStyle _style(
    double size,
    double height,
    FontWeight weight, {
    double tracking = 0,
    List<FontFeature>? features,
  }) => TextStyle(
    fontFamily: fontFamily,
    fontSize: size,
    height: height / size,
    fontWeight: weight,
    letterSpacing: size * tracking,
    fontFeatures: features,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 56/60 w800 — onboarding/marketing figures.
  static final TextStyle heroXl = _style(56, 60, FontWeight.w800, tracking: -0.04, features: _tabular);

  /// 44/48 w800 — hero amounts (dashboard total, add expense).
  static final TextStyle hero = _style(44, 48, FontWeight.w800, tracking: -0.035, features: _tabular);

  static final TextStyle headlineLg = _style(32, 38, FontWeight.w700, tracking: -0.025);
  static final TextStyle headlineMd = _style(24, 30, FontWeight.w700, tracking: -0.02);
  static final TextStyle headlineSm = _style(20, 26, FontWeight.w600, tracking: -0.015);
  static final TextStyle bodyLg = _style(17, 24, FontWeight.w500, tracking: -0.01);
  static final TextStyle bodyMd = _style(15, 22, FontWeight.w400);
  static final TextStyle bodySm = _style(13, 18, FontWeight.w500);

  /// 12/16 w700 +0.04em, uppercase section labels.
  static final TextStyle labelCaps = _style(12, 16, FontWeight.w700, tracking: 0.04);

  /// 11/14 w700 +0.08em, ISO code micro-badges.
  static final TextStyle labelCode = _style(11, 14, FontWeight.w700, tracking: 0.08);

  /// Row amounts (transaction lists): headline-sm with tabular figures.
  static final TextStyle amount = _style(18, 24, FontWeight.w700, tracking: -0.015, features: _tabular);

  static TextTheme textTheme(Color ink, Color muted) => TextTheme(
    displayLarge: heroXl.copyWith(color: ink),
    displayMedium: hero.copyWith(color: ink),
    displaySmall: headlineLg.copyWith(color: ink),
    headlineLarge: headlineLg.copyWith(color: ink),
    headlineMedium: headlineMd.copyWith(color: ink),
    headlineSmall: headlineSm.copyWith(color: ink),
    titleLarge: headlineSm.copyWith(color: ink),
    titleMedium: bodyLg.copyWith(color: ink, fontWeight: FontWeight.w600),
    titleSmall: bodyMd.copyWith(color: ink, fontWeight: FontWeight.w600),
    bodyLarge: bodyLg.copyWith(color: ink),
    bodyMedium: bodyMd.copyWith(color: ink),
    bodySmall: bodySm.copyWith(color: muted),
    labelLarge: bodyMd.copyWith(color: ink, fontWeight: FontWeight.w700),
    labelMedium: labelCaps.copyWith(color: muted),
    labelSmall: labelCode.copyWith(color: muted),
  );
}
