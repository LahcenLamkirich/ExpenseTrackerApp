import 'dart:math' as math;

import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_widgets.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Onboarding step 1 (design 01): brand promise and illustration.
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
                    const SizedBox(height: Space.md),
                    const _Illustration(),
                    const SizedBox(height: Space.lg),
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
                        _FeaturePill(glyph: '✨', label: l10n.onboardingFeatureRates),
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

/// Decorative stack: three tilted foreign-currency cards flowing into one
/// consolidated home balance. Amounts are illustrative sample values.
class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final samples = [
      (Money(485000, CurrencyCatalog.of('MAD')), -2.0, Space.md),
      (Money(45000, CurrencyCatalog.of('EUR')), 1.5, Space.xl + Space.sm),
      (Money(52000, CurrencyCatalog.of('USD')), -0.8, Space.lg),
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
        child: Column(
          children: [
            for (final (i, (money, angle, inset)) in samples.indexed)
              Padding(
                padding: EdgeInsetsDirectional.only(start: inset, end: Space.xl - inset / 2, bottom: Space.sm),
                child: Transform.rotate(
                  angle: angle * math.pi / 180,
                  child: _MiniCurrencyCard(money: money, showLiveTag: i == 0, liveLabel: l10n.onboardingLiveRates),
                ),
              ),
            const SizedBox(height: Space.xs),
            Container(width: 2, height: 20, color: c.accentStrong.withValues(alpha: 0.4)),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
              child: Icon(Icons.arrow_downward_rounded, size: 20, color: c.onAccent),
            ),
            const SizedBox(height: Space.md),
            _HomeBalanceCard(),
          ],
        ),
      ),
    );
  }
}

class _MiniCurrencyCard extends StatelessWidget {
  const _MiniCurrencyCard({required this.money, required this.showLiveTag, required this.liveLabel});

  final Money money;
  final bool showLiveTag;
  final String liveLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final p = context.money.parts(money, display: MoneyDisplay.none, trimZeroFraction: true);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Space.margin, vertical: Space.md),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: Radii.pillAll,
        border: Border.all(color: c.hairline),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Row(
        children: [
          Text(money.currency.flag, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: Space.smd),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: p.number, style: AppTypography.headlineSm.copyWith(color: c.ink, fontWeight: FontWeight.w700)),
                  TextSpan(text: ' ${money.currencyCode}', style: context.text.bodyMedium?.copyWith(color: c.muted)),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: Space.sm),
          if (showLiveTag)
            TagPill(label: liveLabel, icon: Icons.swap_horiz_rounded, foreground: c.accentStrong, uppercase: true)
          else
            Icon(Icons.east_rounded, size: 20, color: c.muted),
        ],
      ),
    );
  }
}

class _HomeBalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.onboardingHomeBalance.toUpperCase(), style: context.text.labelMedium),
                    Text(l10n.onboardingConsolidated, style: context.text.titleSmall),
                  ],
                ),
              ),
              TagPill(label: l10n.onboardingSynced, dot: true, background: c.accent, foreground: c.onAccent),
            ],
          ),
          const SizedBox(height: Space.md),
          HeroAmount(
            Money(148620, CurrencyCatalog.of('USD')),
            currencyStyle: HeroCurrencyStyle.prefixSymbol,
            smallFraction: true,
            animateFromZero: true,
            style: AppTypography.heroXl,
          ),
          const SizedBox(height: Space.md),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.smd),
            decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.mdAll),
            child: Row(
              children: [
                Icon(Icons.auto_awesome_outlined, size: 18, color: c.accentStrong),
                const SizedBox(width: Space.sm),
                Expanded(child: Text(l10n.onboardingRateNote, style: context.text.bodyMedium)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
