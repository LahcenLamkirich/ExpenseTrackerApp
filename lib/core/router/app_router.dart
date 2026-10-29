import 'package:flossi/core/router/app_shell.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/features/categories/presentation/categories_screen.dart';
import 'package:flossi/features/currencies/presentation/currencies_screen.dart';
import 'package:flossi/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flossi/features/dev/design_gallery_screen.dart';
import 'package:flossi/features/onboarding/presentation/budget_step_screen.dart';
import 'package:flossi/features/onboarding/presentation/currency_step_screen.dart';
import 'package:flossi/features/onboarding/presentation/welcome_screen.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/settings/presentation/settings_screen.dart';
import 'package:flossi/features/stats/presentation/stats_screen.dart';
import 'package:flossi/features/transactions/presentation/transaction_editor_screen.dart';
import 'package:flossi/features/transactions/presentation/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final onboarded = ValueNotifier<bool>(
    ref.read(settingsControllerProvider).onboardingCompleted,
  );
  ref.listen(
    settingsControllerProvider.select((s) => s.onboardingCompleted),
    (_, next) => onboarded.value = next,
  );

  final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: Routes.home,
    refreshListenable: onboarded,
    redirect: (context, state) {
      final inOnboarding = state.matchedLocation.startsWith(Routes.onboarding);
      if (!onboarded.value) return inOnboarding ? null : Routes.onboarding;
      if (inOnboarding) return Routes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        builder: (context, state) => const WelcomeScreen(),
        routes: [
          GoRoute(path: 'currency', builder: (context, state) => const CurrencyStepScreen()),
          GoRoute(path: 'budget', builder: (context, state) => const BudgetStepScreen()),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (context, state) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.history,
                builder: (context, state) => const TransactionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.stats,
                builder: (context, state) => const StatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Routes.addTransaction,
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) => sheetPage(state, const TransactionEditorScreen()),
      ),
      GoRoute(
        path: Routes.editTransactionPattern,
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) => sheetPage(
          state,
          TransactionEditorScreen(transactionId: state.pathParameters['id']),
        ),
      ),
      GoRoute(
        path: Routes.categories,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: Routes.currencies,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const CurrenciesScreen(),
      ),
      GoRoute(
        path: Routes.gallery,
        parentNavigatorKey: _rootKey,
        builder: (context, state) => const DesignGalleryScreen(),
      ),
    ],
  );

  ref.onDispose(() {
    onboarded.dispose();
    router.dispose();
  });
  return router;
}

/// Full-screen modal that slides up like a sheet (Add/Edit transaction).
CustomTransitionPage<void> sheetPage(GoRouterState state, Widget child) =>
    CustomTransitionPage<void>(
      key: state.pageKey,
      fullscreenDialog: true,
      transitionDuration: Motion.slow,
      reverseTransitionDuration: Motion.medium,
      child: child,
      transitionsBuilder: (context, animation, secondary, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Motion.emphasized,
          reverseCurve: Curves.easeInCubic,
        );
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(curved),
          child: child,
        );
      },
    );
