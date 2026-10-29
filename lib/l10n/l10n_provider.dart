import 'dart:ui';

import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'l10n_provider.g.dart';

/// Locale the app renders in: the user's choice, else the device locale
/// when supported, else English.
@Riverpod(keepAlive: true)
Locale appLocale(Ref ref) {
  final chosen = ref.watch(settingsControllerProvider.select((s) => s.locale));
  if (chosen != null) return chosen;
  final device = PlatformDispatcher.instance.locale;
  final supported = AppLocalizations.supportedLocales.any(
    (l) => l.languageCode == device.languageCode,
  );
  return supported ? Locale(device.languageCode) : const Locale('en');
}

/// Localized strings outside the widget tree (search, export).
@Riverpod(keepAlive: true)
AppLocalizations appLocalizations(Ref ref) =>
    lookupAppLocalizations(ref.watch(appLocaleProvider));
