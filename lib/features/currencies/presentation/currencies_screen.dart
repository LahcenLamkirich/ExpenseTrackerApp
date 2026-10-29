import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/presentation/currency_sheets.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/currencies/presentation/rates_status_pill.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Currencies and exchange rates (design 08).
class CurrenciesScreen extends ConsumerWidget {
  const CurrenciesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final home = ref.watch(homeCurrencyProvider);
    final table = ref.watch(rateTableProvider).value ?? RateTable.empty;
    final tracked = (ref.watch(allTrackedCurrenciesProvider).value ?? const <(Currency, bool)>[])
        .where((t) => t.$1 != home)
        .toList();
    final active = tracked.where((t) => t.$2).length;

    Future<void> addCurrency() async {
      final picked = await showCurrencyPicker(context);
      if (picked == null || picked == home) return;
      await ref.read(trackedCurrencyRepositoryProvider).ensure([picked.code]);
      // A new code may need rates the in-memory table filtered out.
      unawaited(ref.read(rateSyncProvider.notifier).refreshIfStale());
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(title: l10n.currenciesTitle),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(rateSyncProvider.notifier).refreshNow(),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    Space.margin,
                    Space.sm,
                    Space.margin,
                    Space.xl + MediaQuery.paddingOf(context).bottom,
                  ),
                  children: [
                    const RatesStatusPill(),
                    const SizedBox(height: Space.md),
                    _BaseCard(home: home),
                    const SizedBox(height: Space.lg),
                    Row(
                      children: [
                        Expanded(child: Text(l10n.currenciesTracking, style: context.text.headlineSmall)),
                        TagPill(label: l10n.currenciesActive(active), uppercase: true),
                        const SizedBox(width: Space.sm),
                        Text(l10n.currenciesBaseUnit(home.code), style: context.text.bodySmall),
                      ],
                    ),
                    const SizedBox(height: Space.md),
                    if (tracked.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(Space.lg),
                        child: Text(
                          l10n.currenciesEmpty,
                          textAlign: TextAlign.center,
                          style: context.text.bodyMedium?.copyWith(color: c.muted),
                        ),
                      ),
                    for (final (currency, enabled) in tracked) ...[
                      _RateRow(currency: currency, home: home, enabled: enabled, table: table),
                      const SizedBox(height: Space.smd),
                    ],
                    const SizedBox(height: Space.sm),
                    SecondaryButton(label: l10n.currenciesAdd, icon: Icons.add_circle_outline_rounded, onPressed: addCurrency),
                    const SizedBox(height: Space.lg),
                    AppCard(
                      color: c.recessed,
                      borderColor: Colors.transparent,
                      radius: Radii.lg,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: c.card,
                            child: Icon(Icons.cloud_off_rounded, color: c.muted),
                          ),
                          const SizedBox(width: Space.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.currenciesOfflineTitle, style: context.text.titleMedium),
                                const SizedBox(height: Space.xs),
                                Text(l10n.currenciesOfflineBody, style: context.text.bodyMedium?.copyWith(color: c.muted)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BaseCard extends StatelessWidget {
  const _BaseCard({required this.home});

  final Currency home;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return AppCard(
      glow: true,
      radius: Radii.lg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TagPill(label: l10n.currenciesPrimaryBase, background: c.accent, foreground: c.onAccent, uppercase: true),
              const SizedBox(width: Space.sm),
              Icon(Icons.lock_outline_rounded, size: 16, color: c.income),
              const SizedBox(width: Space.xs),
              Text(l10n.currenciesLocked, style: context.text.titleSmall?.copyWith(color: c.income)),
            ],
          ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              CurrencyFlag(currency: home, size: 60),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: home.code, style: context.text.headlineLarge),
                          TextSpan(text: '  ${home.name}', style: context.text.titleMedium?.copyWith(color: c.muted)),
                        ],
                      ),
                    ),
                    Text(l10n.currenciesChangeHint, style: context.text.bodySmall),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          RecessedBox(
            radius: Radii.lg,
            child: Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 20, color: c.accentStrong),
                const SizedBox(width: Space.smd),
                Expanded(child: Text(l10n.currenciesBaseNote, style: context.text.bodyMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RateRow extends ConsumerWidget {
  const _RateRow({required this.currency, required this.home, required this.enabled, required this.table});

  final Currency currency;
  final Currency home;
  final bool enabled;
  final RateTable table;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final rate = table.rate(currency, home)?.rate;
    // Small units (JPY into MAD) read better per 100.
    final per100 = rate != null && rate < Decimal.parse('0.1');
    final shown = rate == null ? null : (per100 ? rate * Decimal.fromInt(100) : rate);
    final previous = table.rateDaysBefore(currency, home, 1)?.rate;
    final change = rate == null || previous == null || previous == Decimal.zero
        ? null
        : ((rate - previous) / previous).toDouble() * 100;
    final history = table.dailyHistory(currency, home);

    final (Color chipBg, Color chipFg) = switch (change) {
      null => (c.recessed, c.muted),
      > 0.005 => (c.incomeSoft, c.income),
      < -0.005 => (c.expenseSoft, c.expense),
      _ => (c.recessed, c.muted),
    };

    return AppCard(
      radius: Radii.lg,
      padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.md),
      child: Row(
        children: [
          CurrencyFlag(currency: currency, size: 52),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: currency.code, style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                      TextSpan(text: '  ${currency.name}', style: context.text.bodyMedium?.copyWith(color: c.muted)),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: Space.xs),
                Wrap(
                  spacing: Space.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      shown == null
                          ? l10n.currenciesNoRate
                          : '${fmt.formatRateValue(shown, maxDecimals: 3)} ${home.code}${per100 ? ' ${l10n.currenciesPer100}' : ''}',
                      style: context.text.titleSmall?.copyWith(
                        color: shown == null ? c.muted : c.ink,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    if (change != null)
                      TagPill(
                        label: '${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%',
                        background: chipBg,
                        foreground: chipFg,
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (history.length >= 2) ...[
            const SizedBox(width: Space.sm),
            SizedBox(width: 64, height: 32, child: _Sparkline(values: history, color: chipFg == c.muted ? c.accentStrong : chipFg)),
          ],
          const SizedBox(width: Space.sm),
          Switch(
            value: enabled,
            onChanged: (v) => ref.read(trackedCurrencyRepositoryProvider).setEnabled(currency.code, enabled: v),
          ),
        ],
      ),
    );
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.values, required this.color});

  final List<Decimal> values;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Display-only: chart coordinates are doubles by nature.
    final spots = [for (final (i, v) in values.indexed) FlSpot(i.toDouble(), v.toDouble())];
    return ExcludeSemantics(
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: const LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: color,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: true, color: color.withValues(alpha: 0.12)),
            ),
          ],
        ),
      ),
    );
  }
}
