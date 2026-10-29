import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/utils/date_labels.dart';
import 'package:flossi/core/widgets/amount_sheet.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/features/onboarding/domain/budget_presets.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_widgets.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Onboarding step 3 (design 02b): optional monthly budget.
class BudgetStepScreen extends ConsumerStatefulWidget {
  const BudgetStepScreen({super.key});

  @override
  ConsumerState<BudgetStepScreen> createState() => _BudgetStepScreenState();
}

class _BudgetStepScreenState extends ConsumerState<BudgetStepScreen> {
  bool _saving = false;

  Future<void> _finish({bool skip = false}) async {
    setState(() => _saving = true);
    await ref.read(onboardingControllerProvider.notifier).complete(skipBudget: skip);
    // The router redirects away from onboarding once settings change.
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);
    final presets = BudgetPresets.of(state.currency);
    final budget = state.budget;
    final fmt = context.money;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.sm, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: l10n.commonBack,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: Space.sm),
                  const Expanded(child: Center(child: StepPill(step: 3, total: 3))),
                  const SizedBox(width: Space.sm),
                  TextButton(
                    onPressed: _saving ? null : () => _finish(skip: true),
                    child: Text(l10n.budgetSkip),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(Space.margin, Space.lg, Space.margin, Space.lg),
                children: [
                  OnboardingIntro(
                    tag: OnboardingTag(
                      label: l10n.budgetStepTag,
                      icon: Icons.spa_outlined,
                      background: Palette.mint,
                      foreground: Palette.incomeDeep,
                    ),
                    title: l10n.budgetStepTitle,
                    body: l10n.budgetStepBody,
                  ),
                  const SizedBox(height: Space.lg),
                  AppCard(
                    glow: true,
                    radius: Radii.lg,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionLabel(l10n.budgetMonthlyCap),
                        Semantics(
                          button: true,
                          hint: l10n.budgetTapToEdit,
                          child: InkWell(
                            borderRadius: Radii.mdAll,
                            onTap: () async {
                              final picked = await showAmountSheet(
                                context,
                                initial: budget ?? Money.zero(state.currency),
                                title: l10n.budgetEditTitle,
                              );
                              if (picked != null) controller.setBudget(picked.isZero ? null : picked);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: budget == null
                                      ? Text(l10n.budgetNone, style: AppTypography.hero.copyWith(color: c.muted))
                                      : HeroAmount(
                                          budget,
                                          currencyStyle: HeroCurrencyStyle.none,
                                          style: AppTypography.heroXl,
                                        ),
                                ),
                                const SizedBox(width: Space.sm),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: Space.smd),
                                  child: CurrencyCodeBadge(currency: state.currency, showFlag: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Space.md),
                        const Divider(),
                        const SizedBox(height: Space.md),
                        SectionLabel(l10n.budgetQuickAdjust),
                        Wrap(
                          spacing: Space.sm,
                          runSpacing: Space.sm,
                          children: [
                            for (final inc in presets.increments)
                              _BudgetChip(
                                label: fmt.formatNumber(inc, signed: true, trimZeroFraction: true),
                                onTap: () => controller.addToBudget(inc),
                              ),
                            for (final target in presets.targets)
                              _BudgetChip(
                                label: fmt.format(target, display: MoneyDisplay.code, trimZeroFraction: true),
                                selected: budget == target,
                                onTap: () => controller.setBudget(target),
                              ),
                            _BudgetChip(
                              label: l10n.budgetNone,
                              selected: budget == null,
                              muted: true,
                              onTap: () => controller.setBudget(null),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Space.md),
                  AnimatedSwitcher(
                    duration: Motion.medium,
                    child: budget == null
                        ? AppCard(
                            key: const ValueKey('none'),
                            child: Text(l10n.budgetNoneHint, style: context.text.bodyMedium?.copyWith(color: c.muted)),
                          )
                        : _PacingCard(key: const ValueKey('pace'), budget: budget, alert: state.alertEnabled),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.margin, Space.md),
              child: Column(
                children: [
                  PrimaryButton(label: l10n.budgetComplete, loading: _saving, onPressed: _finish),
                  const SizedBox(height: Space.smd),
                  Text(l10n.budgetAdjustLater, style: context.text.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BudgetChip extends StatelessWidget {
  const _BudgetChip({required this.label, required this.onTap, this.selected = false, this.muted = false});

  final String label;
  final VoidCallback onTap;
  final bool selected;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return PressableScale(
      child: Material(
        color: selected ? c.selectedChip : c.recessed,
        borderRadius: Radii.pillAll,
        child: InkWell(
          borderRadius: Radii.pillAll,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Text(
              label,
              style: context.text.titleSmall?.copyWith(
                color: selected ? c.onSelectedChip : (muted ? c.muted : c.ink),
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PacingCard extends ConsumerWidget {
  const _PacingCard({required this.budget, required this.alert, super.key});

  final Money budget;
  final bool alert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final days = daysInMonth(ref.watch(clockProvider).now());
    final perDay = budget.allocate(days).last;
    // 50 / 30 / 20 split with integer math; savings absorbs the remainder.
    final needs = Money(budget.minor * 50 ~/ 100, budget.currency);
    final wants = Money(budget.minor * 30 ~/ 100, budget.currency);
    final savings = budget - needs - wants;

    return AppCard(
      radius: Radii.lg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RecessedBox(
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                  child: Icon(Icons.speed_rounded, color: c.onAccent),
                ),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.budgetDailyPace.toUpperCase(), style: context.text.labelMedium),
                      Text(
                        l10n.budgetPerDay(fmt.format(perDay, display: MoneyDisplay.code, trimZeroFraction: true)),
                        style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                TagPill(label: l10n.budgetDays(days), background: c.accent.withValues(alpha: 0.4), foreground: c.accentStrong, uppercase: true),
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: c.recessed,
                child: Icon(Icons.notifications_active_outlined, color: c.ink, size: 20),
              ),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.budgetNotifyTitle, style: context.text.titleMedium),
                    Text(l10n.budgetNotifyBody, style: context.text.bodySmall),
                  ],
                ),
              ),
              Switch(
                value: alert,
                onChanged: (v) => ref.read(onboardingControllerProvider.notifier).setAlert(enabled: v),
              ),
            ],
          ),
          const SizedBox(height: Space.lg),
          SectionLabel(
            l10n.budgetAllocation,
            trailing: Text(l10n.budgetRule, style: context.text.labelMedium?.copyWith(color: c.income)),
          ),
          const ClipRRect(
            borderRadius: Radii.pillAll,
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  Expanded(flex: 50, child: ColoredBox(color: Palette.olive)),
                  Expanded(flex: 30, child: ColoredBox(color: Palette.lime)),
                  Expanded(flex: 20, child: ColoredBox(color: Palette.mint)),
                ],
              ),
            ),
          ),
          const SizedBox(height: Space.smd),
          Row(
            children: [
              for (final (i, (label, amount)) in [
                (l10n.budgetNeeds, needs),
                (l10n.budgetWants, wants),
                (l10n.budgetSavings, savings),
              ].indexed) ...[
                if (i > 0) const SizedBox(width: Space.sm),
                Expanded(
                  child: RecessedBox(
                    radius: Radii.sm,
                    padding: const EdgeInsets.symmetric(horizontal: Space.xs, vertical: Space.smd),
                    child: Column(
                      children: [
                        Text(label.toUpperCase(), style: context.text.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: Space.xs),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: AmountText(
                            amount,
                            display: MoneyDisplay.code,
                            style: context.text.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
