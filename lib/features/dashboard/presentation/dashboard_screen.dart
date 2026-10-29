import 'dart:async';

import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/amount_sheet.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/currencies/presentation/rates_status_pill.dart';
import 'package:flossi/features/dashboard/presentation/dashboard_providers.dart';
import 'package:flossi/features/settings/presentation/home_currency_flow.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/stats/domain/spending_analytics.dart';
import 'package:flossi/features/transactions/presentation/transaction_providers.dart';
import 'package:flossi/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Home dashboard (design 03).
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(dashboardProvider);
    final recent = ref.watch(recentTransactionsProvider).value ?? const [];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => ref.read(rateSyncProvider.notifier).refreshNow(),
          child: ListView(
            padding: const EdgeInsets.only(bottom: Space.navClearance),
            children: [
              TabHeader(label: l10n.navHome),
              const _Greeting(),
              const SizedBox(height: Space.md),
              ...switch (data) {
                AsyncData(:final value) => [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                    child: _HeroCard(data: value),
                  ),
                  _BudgetAlert(data: value),
                  if (value.month.byCurrency.isNotEmpty) ...[
                    const SizedBox(height: Space.lg),
                    _CurrencyBreakdown(stats: value.month),
                  ],
                  const SizedBox(height: Space.lg),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                    child: _WeekPace(data: value),
                  ),
                ],
                AsyncError(:final error) => [
                  ErrorState(
                    title: l10n.errorTitle,
                    message: l10n.errorBody,
                    error: error,
                    retryLabel: l10n.commonRetry,
                    onRetry: () => ref.invalidate(dashboardProvider),
                  ),
                ],
                _ => [const Padding(padding: EdgeInsets.all(Space.xl), child: Center(child: CircularProgressIndicator()))],
              },
              const SizedBox(height: Space.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                child: Row(
                  children: [
                    Expanded(child: Text(l10n.dashRecent, style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w700))),
                    if (recent.isNotEmpty)
                      TextButton.icon(
                        onPressed: () => context.go(Routes.history),
                        iconAlignment: IconAlignment.end,
                        icon: const Icon(Icons.chevron_right_rounded),
                        label: Text(l10n.dashSeeAll),
                        style: TextButton.styleFrom(foregroundColor: context.colors.accentStrong),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: Space.sm),
              if (recent.isEmpty)
                EmptyState(title: l10n.dashEmptyTitle, message: l10n.dashEmptyBody)
              else
                const _RecentList(),
              const SizedBox(height: Space.lg),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: Space.margin),
                child: RatesStatusPill(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Greeting extends ConsumerWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final now = ref.watch(clockProvider).now();
    final home = ref.watch(homeCurrencyProvider);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final greeting = now.hour < 12
        ? l10n.dashGreetingMorning
        : now.hour < 18
        ? l10n.dashGreetingAfternoon
        : l10n.dashGreetingEvening;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.MMMMEEEEd(locale).format(now).toUpperCase(), style: context.text.labelMedium),
                Text(greeting, style: context.text.headlineMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          PressableScale(
            child: Material(
              color: c.recessed,
              shape: const StadiumBorder(),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: () => changeHomeCurrency(context, ref),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 10, 10),
                  child: Row(
                    children: [
                      Text(home.flag, style: const TextStyle(fontSize: 16)),
                      const SizedBox(width: Space.sm),
                      Text(l10n.dashHomeCurrency(home.code), style: context.text.titleSmall),
                      const Icon(Icons.expand_more_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends ConsumerWidget {
  const _HeroCard({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = ref.watch(clockProvider).now();
    final month = data.month;
    final budget = data.budget;
    final ratio = data.budgetRatio;
    final change = month.change;

    Future<void> editBudget() async {
      final picked = await showAmountSheet(
        context,
        initial: budget ?? Money.zero(month.total.currency),
        title: l10n.budgetEditTitle,
      );
      if (picked != null) {
        await ref.read(settingsControllerProvider.notifier).setMonthlyBudget(picked.isZero ? null : picked.minor);
      }
    }

    return AppCard(
      glow: true,
      radius: Radii.lg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.donut_large_rounded, size: 20, color: c.accentStrong),
              const SizedBox(width: Space.sm),
              Expanded(
                child: Text(
                  l10n.dashTotalSpent(DateFormat.MMMM(locale).format(now)).toUpperCase(),
                  style: context.text.labelMedium,
                ),
              ),
              TagPill(label: l10n.dashDaysLeft(data.daysLeft), uppercase: true),
            ],
          ),
          const SizedBox(height: Space.md),
          HeroAmount(month.total, animateFromZero: true),
          const SizedBox(height: Space.md),
          if (budget != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.dashOfBudget(
                      fmt.formatNumber(month.total, trimZeroFraction: true),
                      fmt.format(budget, display: MoneyDisplay.code, trimZeroFraction: true),
                      (ratio * 100).round(),
                    ),
                    style: context.text.bodyMedium,
                  ),
                ),
                const SizedBox(width: Space.sm),
                Flexible(
                  child: TagPill(
                    icon: ratio >= 0.8 ? Icons.warning_amber_rounded : Icons.check_circle_outline_rounded,
                    label: data.remaining!.isNegative
                        ? l10n.dashOverBudget(fmt.format(-data.remaining!, display: MoneyDisplay.code))
                        : l10n.dashRemaining(fmt.format(data.remaining!, display: MoneyDisplay.code)),
                    background: ratio >= 0.8 ? c.expenseSoft : c.incomeSoft,
                    foreground: ratio >= 0.8 ? c.expense : c.income,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Space.smd),
            AppProgressBar(value: ratio, color: ratio >= 1 ? c.expense : c.accent),
          ] else
            Row(
              children: [
                Expanded(child: Text(l10n.dashNoBudget, style: context.text.bodyMedium?.copyWith(color: c.muted))),
                TextButton(onPressed: editBudget, child: Text(l10n.dashSetBudget)),
              ],
            ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              if (change != null) ...[
                Icon(
                  change > 0 ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                  size: 20,
                  color: change > 0 ? c.expense : c.income,
                ),
                const SizedBox(width: Space.sm),
                Expanded(
                  child: Text(
                    l10n.dashVsLastMonth('${change > 0 ? '+' : ''}${(change * 100).toStringAsFixed(1)}%'),
                    style: context.text.bodyMedium,
                  ),
                ),
              ] else
                const Spacer(),
              if (budget != null)
                TextButton.icon(
                  onPressed: editBudget,
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                  label: Text(l10n.dashBudgetDetails),
                  style: TextButton.styleFrom(foregroundColor: c.accentStrong),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BudgetAlert extends ConsumerWidget {
  const _BudgetAlert({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(settingsControllerProvider.select((s) => s.budgetAlertEnabled));
    if (!enabled || data.budget == null || data.budgetRatio < 0.8) return const SizedBox.shrink();
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Space.margin, Space.smd, Space.margin, 0),
      child: Container(
        padding: const EdgeInsets.all(Space.md),
        decoration: BoxDecoration(color: c.expenseSoft, borderRadius: Radii.mdAll),
        child: Row(
          children: [
            Icon(Icons.notifications_active_outlined, color: c.expense),
            const SizedBox(width: Space.smd),
            Expanded(
              child: Text(
                context.l10n.dashBudgetAlert((data.budgetRatio * 100).round()),
                style: context.text.titleSmall?.copyWith(color: c.expense),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyBreakdown extends ConsumerWidget {
  const _CurrencyBreakdown({required this.stats});

  final PeriodStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final home = stats.total.currency;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.margin),
          child: SectionLabel(
            l10n.dashByCurrency,
            trailing: Row(
              children: [
                TagPill(label: l10n.currenciesActive(stats.byCurrency.length)),
                IconButton(
                  tooltip: l10n.currenciesTitle,
                  onPressed: () => context.push(Routes.currencies),
                  style: IconButton.styleFrom(backgroundColor: Colors.transparent),
                  icon: Icon(Icons.currency_exchange_rounded, size: 20, color: c.accentStrong),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 132,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.margin),
            itemCount: stats.byCurrency.length,
            separatorBuilder: (_, _) => const SizedBox(width: Space.smd),
            itemBuilder: (context, i) {
              final s = stats.byCurrency[i];
              final isHome = s.currency == home;
              return SizedBox(
                width: 200,
                child: AppCard(
                  padding: const EdgeInsets.all(Space.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(s.currency.flag, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: Space.sm),
                          Text(s.currency.code, style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                          const Spacer(),
                          if (isHome)
                            TagPill(label: l10n.historyDirect, background: c.accent.withValues(alpha: 0.45), foreground: c.accentStrong),
                        ],
                      ),
                      const Spacer(),
                      AmountText(s.original, style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: Space.xs),
                      Text(
                        isHome
                            ? l10n.dashShareOfTotal((s.share * 100).round())
                            : '≈ ${fmt.format(s.converted, display: MoneyDisplay.code)}',
                        style: AppTypography.labelCode.copyWith(color: c.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _WeekPace extends StatelessWidget {
  const _WeekPace({required this.data});

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final fmt = context.money;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final days = data.week.series;
    final maxMinor = days.fold<int>(0, (m, d) => d.$2.minor > m ? d.$2.minor : m);

    return AppCard(
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
                    Text(l10n.dashWeekPace.toUpperCase(), style: context.text.labelMedium),
                    const SizedBox(height: Space.xs),
                    AmountText(data.week.total, display: MoneyDisplay.code, style: AppTypography.headlineMd.copyWith(fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
              TagPill(
                icon: Icons.speed_rounded,
                label: l10n.dashAvgPerDay(fmt.format(data.weekDailyAverage, display: MoneyDisplay.code, trimZeroFraction: true)),
              ),
            ],
          ),
          const SizedBox(height: Space.lg),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final (i, (span, amount)) in days.indexed)
                  Expanded(
                    child: _Bar(
                      label: DateFormat.E(locale).format(span.start).characters.first.toUpperCase(),
                      value: amount.isZero ? null : fmt.formatCompact(amount),
                      fraction: maxMinor == 0 ? 0 : amount.minor / maxMinor,
                      isToday: i == data.todayIndex,
                      isFuture: i > data.todayIndex,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.label, required this.value, required this.fraction, required this.isToday, required this.isFuture});

  final String label;
  final String? value;
  final double fraction;
  final bool isToday;
  final bool isFuture;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = isToday ? c.accent : (isFuture || value == null ? c.recessed : c.selectedChip);
    return Semantics(
      label: '$label ${value ?? '0'}',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              value ?? '--',
              maxLines: 1,
              style: AppTypography.labelCode.copyWith(
                color: isToday ? c.ink : c.muted,
                fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
            const SizedBox(height: Space.xs),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: fraction),
              duration: Motion.slow,
              curve: Motion.standard,
              builder: (context, f, _) => Container(
                height: 16 + 84 * f,
                decoration: BoxDecoration(color: color, borderRadius: Radii.pillAll),
              ),
            ),
            const SizedBox(height: Space.sm),
            Text(label, style: context.text.titleSmall?.copyWith(color: isToday ? c.ink : c.muted)),
          ],
        ),
      ),
    );
  }
}

class _RecentList extends ConsumerWidget {
  const _RecentList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = ref.watch(recentTransactionsProvider).value ?? const [];
    final categories = ref.watch(categoriesByIdProvider).value ?? const {};
    final resolver = ref.watch(homeAmountResolverProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin),
      child: Column(
        children: [
          for (final t in recent) ...[
            TransactionTile(
              transaction: t,
              category: categories[t.categoryId],
              resolved: resolver.resolve(t),
              onTap: () => unawaited(context.push(Routes.editTransaction(t.id))),
            ),
            const SizedBox(height: Space.sm),
          ],
        ],
      ),
    );
  }
}
