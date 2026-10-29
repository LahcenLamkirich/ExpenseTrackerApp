import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Single-line formatted amount with tabular figures.
///
/// Set [colorBySign] to paint negatives in the expense colour and positives
/// in the income colour. [approximate] prefixes `≈` for converted values.
class AmountText extends StatelessWidget {
  const AmountText(
    this.money, {
    super.key,
    this.style,
    this.display = MoneyDisplay.auto,
    this.signed = false,
    this.absolute = false,
    this.approximate = false,
    this.colorBySign = false,
    this.color,
    this.textAlign,
  });

  final Money money;
  final TextStyle? style;
  final MoneyDisplay display;
  final bool signed;
  final bool absolute;
  final bool approximate;
  final bool colorBySign;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final formatted = context.money.format(
      money,
      display: display,
      signed: signed,
      absolute: absolute,
    );
    final text = approximate ? '≈ $formatted' : formatted;
    final resolvedColor =
        color ??
        (colorBySign
            ? money.isNegative
                  ? c.expense
                  : money.isPositive
                  ? c.income
                  : c.ink
            : null);
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: (style ?? AppTypography.amount)
          .merge(const TextStyle(fontFeatures: [FontFeature.tabularFigures()]))
          .copyWith(color: resolvedColor),
    );
  }
}

/// How [HeroAmount] renders the currency.
enum HeroCurrencyStyle {
  /// Small symbol before the number (`€ 240.00`, Add Expense design).
  prefixSymbol,

  /// Dark pill badge with the ISO code after the number (Dashboard design).
  codeBadge,

  /// Plain muted ISO code after the number (Stats design).
  codeSuffix,

  /// Number only.
  none,
}

/// Large animated amount used for hero totals.
///
/// Counts smoothly between values with an [IntTween] over minor units, so
/// the animation never goes through floating-point money. The fraction can
/// be rendered smaller ([smallFraction]) as in the onboarding design.
class HeroAmount extends StatelessWidget {
  const HeroAmount(
    this.money, {
    super.key,
    this.currencyStyle = HeroCurrencyStyle.codeBadge,
    this.style,
    this.smallFraction = false,
    this.animate = true,
    this.animateFromZero = false,
    this.alignment = MainAxisAlignment.start,
  });

  final Money money;
  final HeroCurrencyStyle currencyStyle;
  final TextStyle? style;
  final bool smallFraction;
  final bool animate;
  final bool animateFromZero;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final formatter = context.money;
    final semantics = formatter.format(money);
    if (!animate || MediaQuery.disableAnimationsOf(context)) {
      return Semantics(
        label: semantics,
        excludeSemantics: true,
        child: _HeroLayout(money: money, parent: this),
      );
    }
    return Semantics(
      label: semantics,
      excludeSemantics: true,
      child: TweenAnimationBuilder<int>(
        tween: IntTween(begin: animateFromZero ? 0 : money.minor, end: money.minor),
        duration: Motion.counter,
        curve: Motion.standard,
        builder: (context, value, _) =>
            _HeroLayout(money: Money(value, money.currency), parent: this),
      ),
    );
  }
}

class _HeroLayout extends StatelessWidget {
  const _HeroLayout({required this.money, required this.parent});

  final Money money;
  final HeroAmount parent;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final base = (parent.style ?? AppTypography.hero).copyWith(color: c.ink);
    final size = base.fontSize ?? 44;
    final p = context.money.parts(money, display: MoneyDisplay.none);
    final small = base.copyWith(fontSize: size * 0.5, letterSpacing: 0);

    final number = Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '${p.sign}${p.integer}'),
          if (p.fraction.isNotEmpty)
            TextSpan(
              text: '${p.decimalSeparator}${p.fraction}',
              style: parent.smallFraction ? small.copyWith(color: c.muted) : null,
            ),
        ],
      ),
      style: base,
      maxLines: 1,
    );

    final currency = money.currency;
    final children = <Widget>[
      if (parent.currencyStyle == HeroCurrencyStyle.prefixSymbol) ...[
        Text(currency.symbol, style: small.copyWith(fontSize: size * 0.55)),
        const SizedBox(width: Space.xs),
      ],
      Flexible(child: FittedBox(fit: BoxFit.scaleDown, child: number)),
      if (parent.currencyStyle == HeroCurrencyStyle.codeBadge) ...[
        const SizedBox(width: Space.sm),
        Padding(
          padding: EdgeInsets.only(bottom: size * 0.12),
          child: _CodeBadge(code: currency.code),
        ),
      ],
      if (parent.currencyStyle == HeroCurrencyStyle.codeSuffix) ...[
        const SizedBox(width: Space.xs),
        Text(
          currency.code,
          style: small.copyWith(color: c.muted, fontWeight: FontWeight.w700),
        ),
      ],
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: parent.alignment,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: children,
    );
  }
}

class _CodeBadge extends StatelessWidget {
  const _CodeBadge({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(color: c.selectedChip, borderRadius: Radii.pillAll),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          code,
          style: AppTypography.labelCode.copyWith(color: c.onSelectedChip, fontSize: 12),
        ),
      ),
    );
  }
}
