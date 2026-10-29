import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Builds the light and dark [ThemeData] from design tokens. Every Material
/// component used by the app is restyled so nothing looks like stock M3.
abstract final class AppTheme {
  static ThemeData light() => _build(AppColors.light, Brightness.light);
  static ThemeData dark() => _build(AppColors.dark, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.accent,
      onPrimary: c.onAccent,
      primaryContainer: c.accent,
      onPrimaryContainer: c.onAccent,
      secondary: c.ink,
      onSecondary: c.canvas,
      secondaryContainer: c.recessed,
      onSecondaryContainer: c.ink,
      tertiary: c.income,
      onTertiary: Palette.white,
      tertiaryContainer: c.incomeSoft,
      onTertiaryContainer: c.income,
      error: c.expense,
      onError: Palette.white,
      errorContainer: c.expenseSoft,
      onErrorContainer: c.expense,
      surface: c.canvas,
      onSurface: c.ink,
      onSurfaceVariant: c.muted,
      surfaceContainerLowest: c.card,
      surfaceContainerLow: c.card,
      surfaceContainer: c.recessed,
      surfaceContainerHigh: c.recessed,
      surfaceContainerHighest: c.hairline,
      outline: c.muted,
      outlineVariant: c.hairline,
      inverseSurface: c.ink,
      onInverseSurface: c.canvas,
      inversePrimary: Palette.olive,
      shadow: Palette.ink,
      scrim: Palette.ink,
      surfaceTint: Colors.transparent,
    );

    final text = AppTypography.textTheme(c.ink, c.muted);
    const pillShape = StadiumBorder();
    final overlay = isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: AppTypography.fontFamily,
      textTheme: text,
      scaffoldBackgroundColor: c.canvas,
      canvasColor: c.canvas,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: [c],
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.canvas,
        foregroundColor: c.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: text.headlineSmall,
        systemOverlayStyle: overlay.copyWith(statusBarColor: Colors.transparent),
      ),
      cardTheme: CardThemeData(
        color: c.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: Radii.cardAll,
          side: BorderSide(color: c.hairline),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.hairline, thickness: 1, space: 1),
      iconTheme: IconThemeData(color: c.ink, size: 22),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.accent,
          foregroundColor: c.onAccent,
          disabledBackgroundColor: c.recessed,
          disabledForegroundColor: c.muted,
          minimumSize: const Size.fromHeight(Sizes.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: pillShape,
          textStyle: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w700),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: c.card,
          foregroundColor: c.ink,
          minimumSize: const Size(0, Sizes.buttonHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: pillShape,
          side: BorderSide(color: c.hairline),
          textStyle: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.muted,
          shape: pillShape,
          textStyle: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: c.recessed,
          foregroundColor: c.ink,
          minimumSize: const Size.square(Sizes.minTap),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.accent,
        foregroundColor: c.onAccent,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.recessed,
        hintStyle: AppTypography.bodyLg.copyWith(color: c.muted, fontWeight: FontWeight.w400),
        prefixIconColor: c.muted,
        suffixIconColor: c.muted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: const OutlineInputBorder(borderRadius: Radii.pillAll, borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderRadius: Radii.pillAll, borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: Radii.pillAll,
          borderSide: BorderSide(color: c.accentStrong, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: Radii.pillAll,
          borderSide: BorderSide(color: c.expense),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.ink,
        selectionColor: c.accent.withValues(alpha: 0.5),
        selectionHandleColor: c.accentStrong,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Palette.ink : c.card,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accent : c.recessed,
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? Colors.transparent : c.hairline,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accent : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(c.onAccent),
        side: BorderSide(color: c.hairline, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? c.accentStrong : c.hairline,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.accent,
        linearTrackColor: c.recessed,
        circularTrackColor: c.recessed,
        borderRadius: Radii.pillAll,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.card,
        selectedColor: c.selectedChip,
        disabledColor: c.recessed,
        labelStyle: AppTypography.bodySm.copyWith(color: c.ink, fontWeight: FontWeight.w600),
        secondaryLabelStyle: AppTypography.bodySm.copyWith(color: c.onSelectedChip, fontWeight: FontWeight.w600),
        side: BorderSide(color: c.hairline),
        shape: pillShape,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.card,
        modalBackgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: c.hairline,
        elevation: 0,
        modalBarrierColor: Palette.ink.withValues(alpha: 0.32),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.lg)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: Radii.cardAll),
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyMedium?.copyWith(color: c.muted),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? c.recessed : Palette.ink,
        contentTextStyle: AppTypography.bodyMd.copyWith(color: isDark ? c.ink : Palette.white),
        actionTextColor: c.accent,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: Radii.mdAll),
        insetPadding: const EdgeInsets.fromLTRB(Space.margin, 0, Space.margin, Space.navClearance - 24),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.ink,
        textColor: c.ink,
        titleTextStyle: text.titleMedium,
        subtitleTextStyle: text.bodySmall,
        contentPadding: const EdgeInsets.symmetric(horizontal: Space.md),
        minVerticalPadding: Space.smd,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: const BoxDecoration(color: Palette.ink, borderRadius: Radii.smAll),
        textStyle: AppTypography.bodySm.copyWith(color: Palette.white),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: c.card,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: c.card,
        headerForegroundColor: c.ink,
        todayBorder: BorderSide(color: c.accentStrong),
        shape: const RoundedRectangleBorder(borderRadius: Radii.cardAll),
      ),
    );
  }
}

/// Short accessors used across widgets.
extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
}
