import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Circular category badge: glyph (emoji) on a pastel tint of the category
/// colour (design: "44px circular badge with pastel tint").
class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    required this.glyph,
    required this.color,
    super.key,
    this.size = Sizes.categoryIcon,
    this.selected = false,
  });

  final String glyph;
  final Color color;
  final double size;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tint = color.withValues(alpha: isDark ? 0.22 : 0.18);
    return AnimatedContainer(
      duration: Motion.medium,
      curve: Motion.standard,
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tint,
        shape: BoxShape.circle,
        border: selected
            ? Border.all(color: context.colors.accentStrong, width: 2)
            : null,
      ),
      child: ExcludeSemantics(
        child: Text(glyph, style: TextStyle(fontSize: size * 0.46, height: 1)),
      ),
    );
  }
}
