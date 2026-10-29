import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Uppercase section label with optional trailing widget
/// (`ORIGINAL CURRENCIES SPENT … 3 active`).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key, this.trailing, this.padding});

  final String label;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding ?? const EdgeInsets.symmetric(vertical: Space.sm),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              label.toUpperCase(),
              style: AppTypography.labelCaps.copyWith(color: context.colors.muted),
            ),
          ),
        ),
        ?trailing,
      ],
    ),
  );
}

/// Small rounded tag: `PRIMARY`, `Direct`, `+0.14%`, `Near cap`.
class TagPill extends StatelessWidget {
  const TagPill({
    required this.label,
    super.key,
    this.background,
    this.foreground,
    this.icon,
    this.dot = false,
    this.uppercase = false,
  });

  final String label;
  final Color? background;
  final Color? foreground;
  final IconData? icon;
  final bool dot;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = foreground ?? c.ink;
    return DecoratedBox(
      decoration: BoxDecoration(color: background ?? c.recessed, borderRadius: Radii.pillAll),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dot) ...[
              Container(width: 6, height: 6, decoration: BoxDecoration(color: fg, shape: BoxShape.circle)),
              const SizedBox(width: 6),
            ],
            if (icon != null) ...[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: Space.xs),
            ],
            Text(
              uppercase ? label.toUpperCase() : label,
              style: (uppercase ? AppTypography.labelCode : AppTypography.bodySm).copyWith(
                color: fg,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Rounded progress bar that animates to [value] (0..1, display only).
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    required this.value,
    super.key,
    this.color,
    this.trackColor,
    this.height = 10,
  });

  final double value;
  final Color? color;
  final Color? trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final target = value.isNaN ? 0.0 : value.clamp(0.0, 1.0);
    return Semantics(
      value: '${(target * 100).round()}%',
      child: ClipRRect(
        borderRadius: Radii.pillAll,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: target),
            duration: Motion.slow,
            curve: Motion.standard,
            builder: (context, v, _) => Stack(
              // Tight constraints so the track spans the full width and the
              // fill is a true fraction of it.
              fit: StackFit.expand,
              children: [
                ColoredBox(color: trackColor ?? c.recessed),
                FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: v,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color ?? c.accent, borderRadius: Radii.pillAll),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Flossi wordmark: lime rounded tile with an "f" and the product name.
class FlossiLogo extends StatelessWidget {
  const FlossiLogo({required this.name, super.key, this.size = 32});

  final String name;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: name,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: c.accent, borderRadius: BorderRadius.circular(size * 0.32)),
            child: Text(
              'f',
              style: AppTypography.headlineMd.copyWith(
                color: c.onAccent,
                fontWeight: FontWeight.w800,
                fontSize: size * 0.7,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: Space.sm),
          Text(name, style: AppTypography.headlineSm.copyWith(color: c.ink, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

/// Friendly empty / placeholder state.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    super.key,
    this.message,
    this.glyph = '🌱',
    this.action,
  });

  final String title;
  final String? message;
  final String glyph;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Space.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: c.glow, shape: BoxShape.circle),
              child: Text(glyph, style: const TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: Space.lg),
            Text(title, style: context.text.headlineSmall, textAlign: TextAlign.center),
            if (message != null) ...[
              const SizedBox(height: Space.sm),
              Text(
                message!,
                style: context.text.bodyMedium?.copyWith(color: c.muted),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[const SizedBox(height: Space.lg), action!],
          ],
        ),
      ),
    );
  }
}

/// Friendly failure state with an optional retry. The technical error is
/// logged, never shown to the user.
class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.title,
    required this.message,
    required this.error,
    super.key,
    this.retryLabel,
    this.onRetry,
  });

  final String title;
  final String message;
  final Object error;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    debugPrint('ErrorState: $error');
    return EmptyState(
      glyph: '🧯',
      title: title,
      message: message,
      action: onRetry == null || retryLabel == null
          ? null
          : OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(retryLabel!),
            ),
    );
  }
}
