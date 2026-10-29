import 'package:flutter/material.dart';

/// Raw palette from the Flossi (Stitch "Floss") design system.
abstract final class Palette {
  static const lime = Color(0xFFC6F432);
  static const limeDim = Color(0xFFAAD600);
  static const olive = Color(0xFF506600);
  static const oliveDeep = Color(0xFF3B4D00);
  static const ink = Color(0xFF111111);
  static const muted = Color(0xFF73736C);
  static const canvas = Color(0xFFF9F8F2);
  static const white = Color(0xFFFFFFFF);
  static const hairline = Color(0xFFE6E6E1);
  static const recessed = Color(0xFFEFEFEA);
  static const expense = Color(0xFFFA5252);
  static const expenseDeep = Color(0xFFC92A2A);
  static const income = Color(0xFF10B981);
  static const incomeDeep = Color(0xFF006C49);
  static const mint = Color(0xFF70FCBE);
  static const navBar = Color(0xFF2B2B28);

  // Dark theme (derived; the Stitch export only ships light mode).
  static const darkCanvas = Color(0xFF0F100D);
  static const darkCard = Color(0xFF1A1B17);
  static const darkRecessed = Color(0xFF23241F);
  static const darkHairline = Color(0xFF2E2F29);
  static const darkInk = Color(0xFFF2F1E8);
  static const darkMuted = Color(0xFF9F9F96);
  static const darkNavBar = Color(0xFF24251F);

  /// Accent palette offered when creating a category (design 09) plus a few
  /// extras so default categories stay distinguishable.
  static const categoryAccents = <Color>[
    Color(0xFFA9E34B), // lime
    Color(0xFFFCC419), // amber
    Color(0xFFFF6B81), // coral
    Color(0xFFB57BFF), // lilac
    Color(0xFF339AF0), // sky
    Color(0xFF20C997), // teal
    Color(0xFFFD7E14), // orange
    Color(0xFF5C7CFA), // indigo
    Color(0xFFE64980), // pink
    Color(0xFF868E96), // stone
  ];

  /// Series colours for charts (donut, stacked bars), in order.
  static const chart = <Color>[
    lime,
    olive,
    mint,
    Color(0xFF1B1C17),
    limeDim,
    Color(0xFF8CA0FF),
    Color(0xFFFFC078),
    Color(0xFFB3B3AA),
  ];
}

/// Semantic colour tokens exposed through the theme so widgets never
/// hard-code a palette value.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.canvas,
    required this.card,
    required this.recessed,
    required this.hairline,
    required this.ink,
    required this.muted,
    required this.accent,
    required this.onAccent,
    required this.accentStrong,
    required this.expense,
    required this.expenseSoft,
    required this.income,
    required this.incomeSoft,
    required this.navBar,
    required this.onNavBar,
    required this.selectedChip,
    required this.onSelectedChip,
    required this.glow,
  });

  static const light = AppColors(
    canvas: Palette.canvas,
    card: Palette.white,
    recessed: Palette.recessed,
    hairline: Palette.hairline,
    ink: Palette.ink,
    muted: Palette.muted,
    accent: Palette.lime,
    onAccent: Palette.ink,
    accentStrong: Palette.olive,
    expense: Palette.expenseDeep,
    expenseSoft: Color(0xFFFFE3E3),
    income: Palette.incomeDeep,
    incomeSoft: Color(0xFFD3F9E8),
    navBar: Palette.navBar,
    onNavBar: Color(0xFFE4E3DA),
    selectedChip: Palette.ink,
    onSelectedChip: Palette.white,
    glow: Color(0x33C6F432),
  );

  static const dark = AppColors(
    canvas: Palette.darkCanvas,
    card: Palette.darkCard,
    recessed: Palette.darkRecessed,
    hairline: Palette.darkHairline,
    ink: Palette.darkInk,
    muted: Palette.darkMuted,
    accent: Palette.lime,
    onAccent: Palette.ink,
    accentStrong: Palette.lime,
    expense: Color(0xFFFF8787),
    expenseSoft: Color(0xFF3A1D1D),
    income: Color(0xFF4EDEA3),
    incomeSoft: Color(0xFF123326),
    navBar: Palette.darkNavBar,
    onNavBar: Color(0xFFC8C7BE),
    selectedChip: Palette.lime,
    onSelectedChip: Palette.ink,
    glow: Color(0x1FC6F432),
  );

  final Color canvas;
  final Color card;
  final Color recessed;
  final Color hairline;
  final Color ink;
  final Color muted;
  final Color accent;
  final Color onAccent;

  /// Accent that reads as text on [canvas]/[card] (lime is too light for
  /// text on paper, so light mode uses olive).
  final Color accentStrong;
  final Color expense;
  final Color expenseSoft;
  final Color income;
  final Color incomeSoft;
  final Color navBar;
  final Color onNavBar;
  final Color selectedChip;
  final Color onSelectedChip;

  /// Soft lime wash used in the top corner of hero cards.
  final Color glow;

  @override
  AppColors copyWith({
    Color? canvas,
    Color? card,
    Color? recessed,
    Color? hairline,
    Color? ink,
    Color? muted,
    Color? accent,
    Color? onAccent,
    Color? accentStrong,
    Color? expense,
    Color? expenseSoft,
    Color? income,
    Color? incomeSoft,
    Color? navBar,
    Color? onNavBar,
    Color? selectedChip,
    Color? onSelectedChip,
    Color? glow,
  }) => AppColors(
    canvas: canvas ?? this.canvas,
    card: card ?? this.card,
    recessed: recessed ?? this.recessed,
    hairline: hairline ?? this.hairline,
    ink: ink ?? this.ink,
    muted: muted ?? this.muted,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    accentStrong: accentStrong ?? this.accentStrong,
    expense: expense ?? this.expense,
    expenseSoft: expenseSoft ?? this.expenseSoft,
    income: income ?? this.income,
    incomeSoft: incomeSoft ?? this.incomeSoft,
    navBar: navBar ?? this.navBar,
    onNavBar: onNavBar ?? this.onNavBar,
    selectedChip: selectedChip ?? this.selectedChip,
    onSelectedChip: onSelectedChip ?? this.onSelectedChip,
    glow: glow ?? this.glow,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      canvas: l(canvas, other.canvas),
      card: l(card, other.card),
      recessed: l(recessed, other.recessed),
      hairline: l(hairline, other.hairline),
      ink: l(ink, other.ink),
      muted: l(muted, other.muted),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      accentStrong: l(accentStrong, other.accentStrong),
      expense: l(expense, other.expense),
      expenseSoft: l(expenseSoft, other.expenseSoft),
      income: l(income, other.income),
      incomeSoft: l(incomeSoft, other.incomeSoft),
      navBar: l(navBar, other.navBar),
      onNavBar: l(onNavBar, other.onNavBar),
      selectedChip: l(selectedChip, other.selectedChip),
      onSelectedChip: l(onSelectedChip, other.onSelectedChip),
      glow: l(glow, other.glow),
    );
  }
}
