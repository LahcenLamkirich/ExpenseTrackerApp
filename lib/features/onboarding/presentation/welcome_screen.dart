import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_widgets.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Onboarding step 1 (design 01): brand promise and a preview of the app.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    void next() => context.push(Routes.onboardingCurrency);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.sm, 0),
              child: Row(
                children: [
                  const Flexible(child: StepPill(step: 1, total: 3)),
                  const Spacer(),
                  TextButton(onPressed: next, child: Text(l10n.onboardingSkip)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                child: Column(
                  children: [
                    const SizedBox(height: Space.lg),
                    const _PreviewCard(),
                    const SizedBox(height: Space.xl),
                    Text(
                      l10n.onboardingHeadline,
                      textAlign: TextAlign.center,
                      style: AppTypography.headlineLg.copyWith(
                        color: c.ink,
                        fontSize: 38,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: Space.md),
                    Text(
                      l10n.onboardingSubtitle,
                      textAlign: TextAlign.center,
                      style: context.text.bodyLarge?.copyWith(color: c.muted, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: Space.lg),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: Space.sm,
                      runSpacing: Space.sm,
                      children: [
                        _FeaturePill(glyph: '🎯', label: l10n.onboardingFeatureBudget),
                        _FeaturePill(glyph: '⚡', label: l10n.onboardingFeatureTracking),
                        _FeaturePill(glyph: '🔒', label: l10n.onboardingFeaturePrivate),
                      ],
                    ),
                    const SizedBox(height: Space.lg),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.margin, Space.md),
              child: Column(
                children: [
                  PrimaryButton(label: l10n.onboardingGetStarted, onPressed: next),
                  const SizedBox(height: Space.smd),
                  Text(
                    l10n.onboardingFootnote,
                    textAlign: TextAlign.center,
                    style: context.text.bodySmall,
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

class _FeaturePill extends StatelessWidget {
  const _FeaturePill({required this.glyph, required this.label});

  final String glyph;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: Radii.pillAll,
        border: Border.all(color: c.hairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(child: Text(glyph, style: const TextStyle(fontSize: 16))),
          const SizedBox(width: Space.sm),
          Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: context.text.titleSmall)),
        ],
      ),
    );
  }
}

/// Decorative preview of the monthly overview: total, budget bar and a few
/// categories. Amounts are illustrative sample values.
class _PreviewCard extends StatelessWidget {
  const _PreviewCard();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final mad = CurrencyCatalog.of('MAD');
    final rows = [
      ('🍜', Palette.categoryAccents[1], l10n.categoryDining, Money(185000, mad)),
      ('🛒', Palette.categoryAccents[5], l10n.categoryGroceries, Money(212000, mad)),
      ('🚕', Palette.categoryAccents[6], l10n.categoryTransport, Money(88000, mad)),
    ];

    return ExcludeSemantics(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Motion.slow * 2,
        curve: Motion.emphasized,
        builder: (context, t, child) => Opacity(
          opacity: t,
          child: Transform.translate(offset: Offset(0, 24 * (1 - t)), child: child),
        ),
        child: Container(
          padding: const EdgeInsets.all(Space.margin),
          decoration: BoxDecoration(
            color: c.card,
            borderRadius: Radii.lgAll,
            border: Border.all(color: c.hairline),
            gradient: RadialGradient(
              center: AlignmentDirectional.topEnd.resolve(Directionality.of(context)),
              radius: 1.2,
              colors: [c.glow, c.card],
            ),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 32, offset: const Offset(0, 12))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: c.selectedChip, shape: BoxShape.circle),
                    child: Icon(Icons.account_balance_wallet_outlined, color: c.onSelectedChip, size: 22),
                  ),
                  const SizedBox(width: Space.smd),
                  Expanded(
                    child: Text(l10n.onboardingPreviewLabel.toUpperCase(), style: context.text.labelMedium),
                  ),
                  TagPill(label: l10n.onboardingPreviewOnTrack, dot: true, background: c.accent, foreground: c.onAccent),
                ],
              ),
              const SizedBox(height: Space.md),
              HeroAmount(
                Money(485000, mad),
                smallFraction: true,
                animateFromZero: true,
                style: AppTypography.heroXl,
              ),
              const SizedBox(height: Space.md),
              const AppProgressBar(value: 0.62),
              const SizedBox(height: Space.md),
              for (final (glyph, color, name, amount) in rows)
                Padding(
                  padding: const EdgeInsets.only(top: Space.sm),
                  child: Row(
                    children: [
                      CategoryIcon(glyph: glyph, color: color, size: 36),
                      const SizedBox(width: Space.smd),
                      Expanded(child: Text(name, style: context.text.titleSmall)),
                      Text(
                        context.money.format(amount, display: MoneyDisplay.code, trimZeroFraction: true),
                        style: AppTypography.labelCode.copyWith(color: c.ink, fontSize: 13),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
