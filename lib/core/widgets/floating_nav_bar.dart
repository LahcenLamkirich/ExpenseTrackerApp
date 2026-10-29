import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class FloatingNavItem {
  const FloatingNavItem({required this.icon, required this.label, this.activeIcon});

  final IconData icon;
  final IconData? activeIcon;
  final String label;
}

/// Dark floating capsule with four destinations and a raised lime "+" in
/// the middle (designs 03/05/06/10).
///
/// Expects exactly four [items]; the add button sits between items 1 and 2.
class FloatingNavBar extends StatelessWidget {
  const FloatingNavBar({
    required this.items,
    required this.currentIndex,
    required this.onSelected,
    required this.onAdd,
    required this.addLabel,
    super.key,
  }) : assert(items.length == 4, 'FloatingNavBar expects 4 items');

  final List<FloatingNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onAdd;
  final String addLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final bottom = MediaQuery.paddingOf(context).bottom;

    Widget item(int i) => Expanded(
      child: _NavButton(
        item: items[i],
        selected: i == currentIndex,
        onTap: () => onSelected(i),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(Space.margin, 0, Space.margin, bottom > 0 ? bottom : Space.md),
      child: Container(
        height: Sizes.navBarHeight,
        decoration: BoxDecoration(
          color: c.navBar,
          borderRadius: Radii.pillAll,
          border: Theme.of(context).brightness == Brightness.dark ? Border.all(color: c.hairline) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 28,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: Space.sm),
        child: Row(
          children: [
            item(0),
            item(1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Space.xs),
              child: _AddButton(onTap: onAdd, label: addLabel),
            ),
            item(2),
            item(3),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.item, required this.selected, required this.onTap});

  final FloatingNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = selected ? c.accent : c.onNavBar;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 36,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Motion.fast,
              child: Icon(
                selected ? (item.activeIcon ?? item.icon) : item.icon,
                key: ValueKey(selected),
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: Space.xs),
            AnimatedDefaultTextStyle(
              duration: Motion.fast,
              style: AppTypography.bodySm.copyWith(
                color: color,
                fontSize: 12,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: 0.3,
              ),
              child: Text(item.label, maxLines: 1, overflow: TextOverflow.fade, softWrap: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap, required this.label});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: PressableScale(
        child: Material(
          color: c.accent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox.square(
              dimension: Sizes.fab,
              child: Icon(Icons.add_rounded, color: c.onAccent, size: 34),
            ),
          ),
        ),
      ),
    );
  }
}
