import 'dart:async';

import 'package:flossi/core/router/app_router.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/settings/presentation/app_lock.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flossi/l10n/l10n_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlossiApp extends ConsumerStatefulWidget {
  const FlossiApp({super.key});

  @override
  ConsumerState<FlossiApp> createState() => _FlossiAppState();
}

class _FlossiAppState extends ConsumerState<FlossiApp> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    // Refresh stale rates whenever the app returns to the foreground.
    _lifecycle = AppLifecycleListener(
      onResume: () => unawaited(ref.read(rateSyncProvider.notifier).refreshIfStale()),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(settingsControllerProvider.select((s) => s.themeMode));
    final locale = ref.watch(appLocaleProvider);
    // Instantiates the sync service (which refreshes on start) and keeps it alive.
    ref.listen(rateSyncProvider, (_, _) {});

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: (context, child) => AppLockGate(child: child ?? const SizedBox.shrink()),
    );
  }
}
