import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Elevated surface from the design system: white (or dark card) fill,
/// hairline border, 24px radius, no blurred shadow.
///
/// [glow] adds the soft lime wash seen in the corner of hero cards.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(Space.margin),
    this.onTap,
    this.color,
    this.borderColor,
    this.radius = Radii.card,
    this.glow = false,
    this.semanticLabel,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final double radius;
  final bool glow;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final borderRadius = BorderRadius.circular(radius);
    Widget content = Padding(padding: padding, child: child);

    if (glow) {
      content = DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: RadialGradient(
            center: AlignmentDirectional.topEnd.resolve(Directionality.of(context)),
            radius: 1.1,
            colors: [c.glow, c.glow.withValues(alpha: 0)],
          ),
        ),
        child: content,
      );
    }

    return Semantics(
      container: true,
      label: semanticLabel,
      button: onTap != null,
      child: Material(
        color: color ?? c.card,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: BorderSide(color: borderColor ?? c.hairline),
        ),
        clipBehavior: Clip.antiAlias,
        child: onTap == null ? content : InkWell(onTap: onTap, child: content),
      ),
    );
  }
}

/// Recessed container (inputs, inset tiles): recessed fill, no border.
class RecessedBox extends StatelessWidget {
  const RecessedBox({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.md),
    this.radius = Radii.md,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Material(
      color: context.colors.recessed,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
