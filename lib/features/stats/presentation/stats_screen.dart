import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/currencies/presentation/currency_sheets.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/stats/domain/spending_analytics.dart';
import 'package:flossi/features/stats/presentation/stats_providers.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Statistics (design 06).
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final query = ref.watch(statsQueryControllerProvider);
    final controller = ref.read(statsQueryControllerProvider.notifier);
    final home = ref.watch(homeCurrencyProvider);
    final view = query.viewCurrency ?? home;
    final stats = ref.watch(periodStatsProvider);
    final now = ref.watch(clockProvider).now();

    Future<void> pickCustom() async {
      final current = spanFor(query.period, now, custom: query.custom);
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(now.year + 1, 12, 31),
        initialDateRange: DateTimeRange(start: current.start, end: current.lastDay),
      );
      if (picked != null) controller.setCustom(DateSpan.days(picked.start, picked.end));
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: Space.navClearance),
          children: [
            TabHeader(label: l10n.navStats),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Space.margin),
              child: Row(
                children: [
                  Expanded(
                    child: SegmentedPill<StatsPeriod>(
                      selected: query.period,
                      onChanged: (p) => p == StatsPeriod.custom ? pickCustom() : controller.setPeriod(p),
                      segments: [
                        Segment(value: StatsPeriod.week, label: l10n.statsWeek),
                        Segment(value: StatsPeriod.month, label: l10n.statsMonth),
                        Segment(value: StatsPeriod.year, label: l10n.statsYear),
                        Segment(value: StatsPeriod.custom, label: l10n.statsCustom),
                      ],
                    ),
                  ),
                  const SizedBox(width: Space.sm),
                  PressableScale(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 44),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onPressed: () async {
                        final picked = await showCurrencyPicker(context, selected: view);
                        if (picked != null) controller.setViewCurrency(picked == home ? null : picked);
                      },
                      child: Row(
                        children: [
                          Text(view.flag),
                          const SizedBox(width: Space.xs),
                          Text(view.code, style: context.text.titleSmall),
                          const Icon(Icons.expand_more_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Space.md),
            ...switch (stats) {
              AsyncData(:final value) when value.count == 0 && value.unresolved == 0 => [
                _TotalCard(stats: value, period: query.period),
                EmptyState(glyph: '📊', title: l10n.statsEmptyTitle, message: l10n.statsEmptyBody),
              ],
              AsyncData(:final value) => [
                _TotalCard(stats: value, period: query.period),
                const SizedBox(height: Space.md),
                _DonutCard(stats: value),
                const SizedBox(height: Space.md),
                _TrendCard(stats: value, period: query.period),
                if (!value.foreignTotal.isZero) ...[
                  const SizedBox(height: Space.md),
                  _ForeignShareCard(stats: value),
                ],
                const SizedBox(height: Space.md),
                _TopCategories(stats: value),
              ],
              AsyncError(:final error) => [
                ErrorState(
                  title: l10n.errorTitle,
                  message: l10n.errorBody,
                  error: error,
                  retryLabel: l10n.commonRetry,
                  onRetry: () => ref.invalidate(periodStatsProvider),
                ),
              ],
              _ => [const Padding(padding: EdgeInsets.all(Space.xl), child: Center(child: CircularProgressIndicator()))],
            },
          ],
        ),
      ),
    );
  }
}

String _periodLabel(BuildContext context, StatsPeriod period, DateSpan span) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return switch (period) {
    StatsPeriod.month => DateFormat.yMMMM(locale).format(span.start),
    StatsPeriod.year => DateFormat.y(locale).format(span.start),
    _ => '${DateFormat.MMMd(locale).format(span.start)} – ${DateFormat.MMMd(locale).format(span.lastDay)}',
  };
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.stats, required this.period});

  final PeriodStats stats;
  final StatsPeriod period;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final change = stats.change;
    final up = (change ?? 0) > 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: AppCard(
        radius: Radii.lg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.statsTotalSpending(_periodLabel(context, period, stats.span)).toUpperCase(),
                    style: context.text.labelMedium,
                  ),
                ),
                if (change != null)
                  TagPill(
                    icon: up ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                    label: '${(change.abs() * 100).toStringAsFixed(1)}%',
                    background: up ? c.expenseSoft : c.incomeSoft,
                    foreground: up ? c.expense : c.income,
                  ),
              ],
            ),
            const SizedBox(height: Space.sm),
            HeroAmount(stats.total, currencyStyle: HeroCurrencyStyle.codeSuffix),
            const SizedBox(height: Space.sm),
            Row(
              children: [
                Container(width: 8, height: 8, decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle)),
                const SizedBox(width: Space.sm),
                Expanded(
                  child: Text(
                    l10n.statsVsPrevious(context.money.format(stats.previousTotal, display: MoneyDisplay.code)),
                    style: context.text.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DonutCard extends ConsumerStatefulWidget {
  const _DonutCard({required this.stats});

  final PeriodStats stats;

  @override
  ConsumerState<_DonutCard> createState() => _DonutCardState();
}

class _DonutCardState extends ConsumerState<_DonutCard> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final categories = ref.watch(categoriesByIdProvider).value ?? const <String, CategoryRecord>{};
    final shares = widget.stats.byCategory;
    final selected = shares.isEmpty ? null : shares[_selected.clamp(0, shares.length - 1)];
    final selectedCat = selected == null ? null : categories[selected.categoryId];

    Color colorOf(CategoryShare s) => categories[s.categoryId]?.color ?? c.muted;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: AppCard(
        radius: Radii.lg,
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.donut_large_rounded, color: c.accentStrong),
                const SizedBox(width: Space.sm),
                Expanded(child: Text(l10n.statsCategoryDistribution, style: context.text.headlineSmall)),
                Text(l10n.statsTapToInspect, style: context.text.bodySmall),
              ],
            ),
            const SizedBox(height: Space.md),
            SizedBox(
              height: 220,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    PieChartData(
                      sectionsSpace: 3,
                      centerSpaceRadius: 64,
                      startDegreeOffset: -90,
                      pieTouchData: PieTouchData(
                        touchCallback: (event, response) {
                          final i = response?.touchedSection?.touchedSectionIndex;
                          if (event is FlTapUpEvent && i != null && i >= 0) setState(() => _selected = i);
                        },
                      ),
                      sections: [
                        for (final (i, s) in shares.indexed)
                          PieChartSectionData(
                            value: math.max(s.share, 0.004),
                            color: colorOf(s),
                            radius: i == _selected ? 38 : 30,
                            showTitle: false,
                          ),
                      ],
                    ),
                    duration: Motion.medium,
                  ),
                  if (selected != null)
                    Container(
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: c.recessed, shape: BoxShape.circle),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedCat == null ? '' : l10n.categoryName(selectedCat),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.bodySmall,
                          ),
                          Text(
                            '${(selected.share * 100).round()}%',
                            style: AppTypography.headlineMd.copyWith(color: c.ink, fontWeight: FontWeight.w800),
                          ),
                          Text(
                            context.money.format(selected.amount, display: MoneyDisplay.code, trimZeroFraction: true),
                            style: AppTypography.labelCode.copyWith(color: c.muted),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Space.md),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: Space.sm,
              runSpacing: Space.sm,
              children: [
                for (final (i, s) in shares.take(8).indexed)
                  InkWell(
                    borderRadius: Radii.pillAll,
                    onTap: () => setState(() => _selected = i),
                    child: TagPill(
                      dot: true,
                      label: '${categories[s.categoryId] == null ? '' : l10n.categoryName(categories[s.categoryId]!)} ${(s.share * 100).round()}%',
                      foreground: i == _selected ? c.ink : c.muted,
                      background: i == _selected ? colorOf(s).withValues(alpha: 0.25) : c.recessed,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.stats, required this.period});

  final PeriodStats stats;
  final StatsPeriod period;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final series = stats.series;
    final currency = stats.total.currency;
    final avg = series.isEmpty ? Money.zero(currency) : stats.total.allocate(series.length).last;
    var peak = 0;
    for (var i = 0; i < series.length; i++) {
      if (series[i].$2 > series[peak].$2) peak = i;
    }
    // Chart coordinates are display-only doubles in major units.
    final spots = [
      for (final (i, (_, m)) in series.indexed) FlSpot(i.toDouble(), m.toDecimal().toDouble()),
    ];
    final maxY = spots.fold<double>(0, (m, s) => math.max(m, s.y));

    String bottomLabel(int i) {
      final span = series[i].$1;
      return switch (period) {
        StatsPeriod.month => l10n.statsWeekLabel(i + 1),
        StatsPeriod.year => DateFormat.MMM(locale).format(span.start),
        _ when series.length > 10 => i % 5 == 0 ? DateFormat.d(locale).format(span.start) : '',
        _ => DateFormat.E(locale).format(span.start).characters.first.toUpperCase(),
      };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: AppCard(
        radius: Radii.lg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.statsPacing, style: context.text.headlineSmall),
                      Text(l10n.statsPacingSubtitle(currency.code), style: context.text.bodySmall),
                    ],
                  ),
                ),
                TagPill(label: l10n.statsAvg(fmt.format(avg, display: MoneyDisplay.code, trimZeroFraction: true))),
              ],
            ),
            if (maxY > 0) ...[
              const SizedBox(height: Space.sm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TagPill(
                  label: l10n.statsPeak(fmt.formatCompact(series[peak].$2)),
                  background: c.selectedChip,
                  foreground: c.onSelectedChip,
                ),
              ),
            ],
            const SizedBox(height: Space.md),
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY == 0 ? 1 : maxY * 1.2,
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    horizontalInterval: maxY == 0 ? 1 : maxY * 0.6,
                    getDrawingHorizontalLine: (_) => FlLine(color: c.hairline, dashArray: [4, 4], strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= series.length || value != i.toDouble()) return const SizedBox.shrink();
                          return SideTitleWidget(
                            meta: meta,
                            child: Text(
                              bottomLabel(i),
                              style: AppTypography.labelCode.copyWith(color: i == peak ? c.ink : c.muted),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (_) => c.selectedChip,
                      getTooltipItems: (spots) => [
                        for (final s in spots)
                          LineTooltipItem(
                            fmt.format(series[s.x.toInt()].$2, display: MoneyDisplay.code),
                            AppTypography.labelCode.copyWith(color: c.onSelectedChip),
                          ),
                      ],
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      preventCurveOverShooting: true,
                      color: c.accentStrong,
                      barWidth: 3,
                      dotData: FlDotData(
                        getDotPainter: (spot, _, _, i) => FlDotCirclePainter(
                          radius: i == peak ? 6 : 3.5,
                          color: i == peak ? c.accent : c.card,
                          strokeWidth: 2,
                          strokeColor: c.accentStrong,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [c.accent.withValues(alpha: 0.45), c.accent.withValues(alpha: 0.02)],
                        ),
                      ),
                    ),
                  ],
                ),
                duration: Motion.slow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForeignShareCard extends StatelessWidget {
  const _ForeignShareCard({required this.stats});

  final PeriodStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: AppCard(
        color: c.recessed,
        borderColor: Colors.transparent,
        radius: Radii.lg,
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
              child: Icon(Icons.public_rounded, color: c.onAccent),
            ),
            const SizedBox(width: Space.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${(stats.foreignShare * 100).toStringAsFixed(1)}%  ',
                          style: AppTypography.headlineMd.copyWith(color: c.ink, fontWeight: FontWeight.w800),
                        ),
                        TextSpan(text: l10n.statsForeignShare, style: context.text.titleSmall),
                      ],
                    ),
                  ),
                  const SizedBox(height: Space.xs),
                  Text(
                    l10n.statsForeignBody(context.money.format(stats.foreignTotal, display: MoneyDisplay.code)),
                    style: context.text.bodyMedium?.copyWith(color: c.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopCategories extends ConsumerWidget {
  const _TopCategories({required this.stats});

  final PeriodStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final categories = ref.watch(categoriesByIdProvider).value ?? const <String, CategoryRecord>{};
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: AppCard(
        radius: Radii.lg,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text(l10n.statsTopCategories, style: context.text.headlineSmall)),
                Text(l10n.filterCategoriesCount(stats.byCategory.length), style: context.text.bodySmall),
              ],
            ),
            for (final s in stats.byCategory.take(6)) ...[
              const SizedBox(height: Space.md),
              Row(
                children: [
                  CategoryIcon(
                    glyph: categories[s.categoryId]?.glyph ?? '📦',
                    color: categories[s.categoryId]?.color ?? c.muted,
                    size: 40,
                  ),
                  const SizedBox(width: Space.smd),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: categories[s.categoryId] == null ? '' : l10n.categoryName(categories[s.categoryId]!),
                            style: context.text.titleMedium,
                          ),
                          TextSpan(text: '  ${(s.share * 100).round()}%', style: context.text.bodySmall),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AmountText(s.amount, display: MoneyDisplay.code, style: AppTypography.amount),
                ],
              ),
              const SizedBox(height: Space.sm),
              AppProgressBar(value: s.share, height: 8, color: categories[s.categoryId]?.color ?? c.accent),
            ],
          ],
        ),
      ),
    );
  }
}
