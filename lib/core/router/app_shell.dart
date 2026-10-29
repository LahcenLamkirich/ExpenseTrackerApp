import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/widgets/floating_nav_bar.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hosts the four tab branches above the floating nav bar.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: FloatingNavBar(
        currentIndex: navigationShell.currentIndex,
        addLabel: l10n.navAdd,
        onAdd: () => context.push(Routes.addTransaction),
        onSelected: (i) => navigationShell.goBranch(
          i,
          initialLocation: i == navigationShell.currentIndex,
        ),
        items: [
          FloatingNavItem(icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view_rounded, label: l10n.navHome),
          FloatingNavItem(icon: Icons.swap_horiz_rounded, label: l10n.navHistory),
          FloatingNavItem(icon: Icons.insights_outlined, activeIcon: Icons.insights_rounded, label: l10n.navStats),
          FloatingNavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings_rounded, label: l10n.navSettings),
        ],
      ),
    );
  }
}
