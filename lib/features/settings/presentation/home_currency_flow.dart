import 'dart:async';

import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/currencies/presentation/currency_sheets.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Picks a new home currency, explains what happens to existing totals,
/// then applies it. Stored transactions are never rewritten.
Future<void> changeHomeCurrency(BuildContext context, WidgetRef ref) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final current = ref.read(homeCurrencyProvider);
  final picked = await showCurrencyPicker(context, selected: current);
  if (picked == null || picked == current || !context.mounted) return;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.homeChangeTitle(picked.code)),
      content: Text(l10n.homeChangeBody(picked.code)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.homeChangeConfirm),
        ),
      ],
    ),
  );
  if (confirmed != true) return;

  await ref.read(trackedCurrencyRepositoryProvider).ensure([picked.code, current.code]);
  await ref.read(settingsControllerProvider.notifier).setHomeCurrency(picked.code);
  unawaited(ref.read(rateSyncProvider.notifier).refreshNow());
  messenger.showSnackBar(SnackBar(content: Text(l10n.homeChanged(picked.code))));
}
