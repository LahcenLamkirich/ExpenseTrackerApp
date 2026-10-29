import 'dart:async';

import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/utils/date_labels.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "● Mid-market rates updated 4 min ago  ⟳" (designs 03/08), or the
/// offline / never-fetched variants.
class RatesStatusPill extends ConsumerWidget {
  const RatesStatusPill({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final sync = ref.watch(rateSyncProvider);
    final now = ref.watch(clockProvider).now();
    final last = sync.lastFetch;

    final String label;
    final Color dot;
    if (sync.refreshing) {
      label = l10n.ratesRefreshing;
      dot = c.accentStrong;
    } else if (last == null) {
      label = l10n.ratesNever;
      dot = c.expense;
    } else if (sync.failed) {
      label = l10n.ratesOfflineAgo(timeAgo(l10n, last, now));
      dot = c.muted;
    } else {
      label = l10n.ratesUpdatedAgo(timeAgo(l10n, last, now));
      dot = c.income;
    }

    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(Space.md, Space.xs, Space.xs, Space.xs),
      decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.pillAll),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
          const SizedBox(width: Space.smd),
          Expanded(
            child: Text(label, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.text.bodyMedium),
          ),
          IconButton(
            tooltip: l10n.ratesRefresh,
            onPressed: sync.refreshing ? null : () => unawaited(ref.read(rateSyncProvider.notifier).refreshNow()),
            style: IconButton.styleFrom(backgroundColor: c.card),
            icon: sync.refreshing
                ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.sync_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}
