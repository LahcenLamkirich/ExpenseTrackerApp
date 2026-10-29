import 'dart:async';

import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lock.g.dart';

@Riverpod(keepAlive: true)
LocalAuthentication localAuth(Ref ref) => LocalAuthentication();

/// Whether biometric / device-credential auth can be used here.
@riverpod
Future<bool> appLockSupported(Ref ref) async {
  if (kIsWeb) return false;
  try {
    return await ref.watch(localAuthProvider).isDeviceSupported();
  } on Object {
    return false;
  }
}

/// Locked state: locked on cold start and after [relockAfter] in the
/// background, when the app lock is enabled.
@Riverpod(keepAlive: true)
class AppLock extends _$AppLock {
  static const relockAfter = Duration(seconds: 30);
  DateTime? _pausedAt;

  @override
  bool build() => ref.read(settingsControllerProvider).appLockEnabled;

  void onPaused() => _pausedAt = ref.read(clockProvider).now();

  void onResumed() {
    final pausedAt = _pausedAt;
    _pausedAt = null;
    if (!ref.read(settingsControllerProvider).appLockEnabled || pausedAt == null) return;
    if (ref.read(clockProvider).now().difference(pausedAt) >= relockAfter) state = true;
  }

  /// Prompts for biometrics / device credential. Returns true on success.
  Future<bool> authenticate(String reason) async {
    try {
      final ok = await ref.read(localAuthProvider).authenticate(localizedReason: reason, persistAcrossBackgrounding: true);
      if (ok) state = false;
      return ok;
    } on Object catch (e) {
      debugPrint('Authentication failed: $e');
      return false;
    }
  }

  /// Turning the lock on requires one successful authentication first.
  Future<bool> setEnabled({required bool enabled, required String reason}) async {
    if (enabled && !await authenticate(reason)) return false;
    await ref.read(settingsControllerProvider.notifier).setAppLock(enabled: enabled);
    if (!enabled) state = false;
    return true;
  }
}

/// Covers the app with the lock screen while locked.
class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onPause: () => ref.read(appLockProvider.notifier).onPaused(),
      onResume: () => ref.read(appLockProvider.notifier).onResumed(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = ref.watch(appLockProvider);
    return Stack(
      children: [
        widget.child,
        if (locked) const Positioned.fill(child: _LockScreen()),
      ],
    );
  }
}

class _LockScreen extends ConsumerStatefulWidget {
  const _LockScreen();

  @override
  ConsumerState<_LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<_LockScreen> {
  @override
  void initState() {
    super.initState();
    // Prompt right away; the button retries.
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_unlock()));
  }

  Future<void> _unlock() => ref.read(appLockProvider.notifier).authenticate(context.l10n.lockReason);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Material(
      color: c.canvas,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Space.xl),
          child: Column(
            children: [
              FlossiLogo(name: l10n.appTitle),
              const Spacer(),
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                child: Icon(Icons.lock_rounded, size: 44, color: c.onAccent),
              ),
              const SizedBox(height: Space.lg),
              Text(l10n.lockTitle, style: context.text.headlineMedium),
              const SizedBox(height: Space.sm),
              Text(l10n.lockBody, style: context.text.bodyMedium?.copyWith(color: c.muted)),
              const Spacer(),
              PrimaryButton(label: l10n.lockUnlock, trailingIcon: Icons.fingerprint_rounded, onPressed: _unlock),
            ],
          ),
        ),
      ),
    );
  }
}
