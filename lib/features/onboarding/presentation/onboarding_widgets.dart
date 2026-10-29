import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// "● ● ●  STEP 1 OF 3" pill (welcome / budget designs).
class StepPill extends StatelessWidget {
  const StepPill({required this.step, required this.total, super.key});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      label: context.l10n.onboardingStep(step, total),
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.pillAll),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 1; i <= total; i++) ...[
              AnimatedContainer(
                duration: Motion.medium,
                width: i == step ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i <= step ? c.accentStrong : c.hairline,
                  borderRadius: Radii.pillAll,
                ),
              ),
              const SizedBox(width: Space.xs),
            ],
            const SizedBox(width: Space.xs),
            Flexible(
              child: Text(
                context.l10n.onboardingStep(step, total).toUpperCase(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.labelCaps.copyWith(color: c.ink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Small coloured tag above onboarding titles ("PRIMARY LEDGER").
class OnboardingTag extends StatelessWidget {
  const OnboardingTag({
    required this.label,
    required this.icon,
    super.key,
    this.background,
    this.foreground,
  });

  final String label;
  final IconData icon;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = foreground ?? c.accentStrong;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: background ?? c.recessed, borderRadius: Radii.pillAll),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(label.toUpperCase(), style: AppTypography.labelCaps.copyWith(color: fg)),
        ],
      ),
    );
  }
}

/// Title + body block shared by the onboarding steps.
class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({required this.tag, required this.title, required this.body, super.key});

  final Widget tag;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tag,
      const SizedBox(height: Space.md),
      Text(title, style: context.text.headlineLarge?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: Space.sm),
      Text(body, style: context.text.bodyLarge?.copyWith(color: context.colors.muted, fontWeight: FontWeight.w400)),
    ],
  );
}

/// Round selection indicator: empty recessed circle or lime check.
class SelectionDot extends StatelessWidget {
  const SelectionDot({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedContainer(
      duration: Motion.medium,
      curve: Motion.standard,
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: selected ? c.accent : c.recessed, shape: BoxShape.circle),
      child: AnimatedSwitcher(
        duration: Motion.fast,
        child: selected
            ? Icon(Icons.check_rounded, key: const ValueKey(true), size: 18, color: c.onAccent)
            : const SizedBox.shrink(key: ValueKey(false)),
      ),
    );
  }
}

/// Large pinned-currency card (design 02a "Suggested for you").
class CurrencyChoiceCard extends StatelessWidget {
  const CurrencyChoiceCard({
    required this.currency,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Currency currency;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      selected: selected,
      button: true,
      child: PressableScale(
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.standard,
          decoration: BoxDecoration(
            color: c.card,
            borderRadius: Radii.cardAll,
            border: Border.all(color: selected ? c.accent : c.hairline, width: selected ? 2.5 : 1),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: Radii.cardAll,
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(Space.md),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.mdAll),
                      child: Text(currency.flag, style: const TextStyle(fontSize: 28)),
                    ),
                    const SizedBox(width: Space.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(child: Text(currency.code, overflow: TextOverflow.ellipsis, style: context.text.headlineMedium)),
                              if (selected) ...[
                                const SizedBox(width: Space.sm),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(color: c.accent, borderRadius: Radii.pillAll),
                                  child: Text(
                                    context.l10n.currencyPrimaryBadge.toUpperCase(),
                                    style: AppTypography.labelCode.copyWith(color: c.onAccent),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(currency.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: context.text.bodyMedium?.copyWith(color: c.muted)),
                        ],
                      ),
                    ),
                    Text(currency.symbol, style: context.text.titleMedium?.copyWith(color: c.muted)),
                    const SizedBox(width: Space.md),
                    SelectionDot(selected: selected),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact list row for the full currency list.
class CurrencyListRow extends StatelessWidget {
  const CurrencyListRow({
    required this.currency,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final Currency currency;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.smd),
          child: Row(
            children: [
              CurrencyFlag(currency: currency, size: 44),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: currency.code, style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                          TextSpan(text: ' · ${currency.name}', style: context.text.bodyMedium?.copyWith(color: c.muted)),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (currency.country.isNotEmpty)
                      Text(
                        currency.country,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.4),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Space.sm),
              Text(currency.symbol, style: context.text.titleMedium),
              const SizedBox(width: Space.md),
              SelectionDot(selected: selected),
            ],
          ),
        ),
      ),
    );
  }
}
