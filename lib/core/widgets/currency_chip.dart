import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

/// Tactile currency capsule: flag + ISO code (+ optional symbol).
///
/// Selected: ink fill with white text. Unselected: card fill with hairline
/// and muted text (design: "Multi-Currency Chips & Pills").
class CurrencyChip extends StatelessWidget {
  const CurrencyChip({
    required this.currency,
    super.key,
    this.selected = false,
    this.onTap,
    this.showSymbol = true,
    this.trailing,
    this.dense = false,
  });

  final Currency currency;
  final bool selected;
  final VoidCallback? onTap;
  final bool showSymbol;
  final Widget? trailing;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = selected ? c.onSelectedChip : c.ink;
    final bg = selected ? c.selectedChip : c.recessed;
    final codeStyle = (dense ? AppTypography.bodySm : AppTypography.bodyLg).copyWith(
      color: fg,
      fontWeight: FontWeight.w600,
    );

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: '${currency.code}, ${currency.name}',
      excludeSemantics: true,
      child: PressableScale(
        enabled: onTap != null,
        child: AnimatedContainer(
          duration: Motion.medium,
          curve: Motion.standard,
          decoration: BoxDecoration(color: bg, borderRadius: Radii.pillAll),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: Radii.pillAll,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: dense ? 12 : 18,
                  vertical: dense ? 6 : 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(currency.flag, style: TextStyle(fontSize: dense ? 14 : 18)),
                    const SizedBox(width: Space.sm),
                    Text(currency.code, style: codeStyle),
                    if (showSymbol && currency.symbol != currency.code) ...[
                      const SizedBox(width: Space.xs + 2),
                      Text(
                        currency.symbol,
                        style: codeStyle.copyWith(
                          color: selected ? fg : c.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    if (trailing != null) ...[
                      const SizedBox(width: Space.xs),
                      IconTheme.merge(data: IconThemeData(color: fg, size: 18), child: trailing!),
                    ],
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

/// Compact ISO-code badge (`MAD`, `🇲🇦 MAD`) used next to amounts and in
/// list rows.
class CurrencyCodeBadge extends StatelessWidget {
  const CurrencyCodeBadge({
    required this.currency,
    super.key,
    this.showFlag = false,
    this.inverted = false,
  });

  final Currency currency;
  final bool showFlag;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: inverted ? c.selectedChip : c.recessed,
        borderRadius: Radii.pillAll,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showFlag) ...[
              Text(currency.flag, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: Space.xs),
            ],
            Text(
              currency.code,
              style: AppTypography.labelCode.copyWith(
                color: inverted ? c.onSelectedChip : c.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Round flag avatar used in currency lists.
class CurrencyFlag extends StatelessWidget {
  const CurrencyFlag({required this.currency, super.key, this.size = 48});

  final Currency currency;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(color: context.colors.recessed, shape: BoxShape.circle),
    child: Text(currency.flag, style: TextStyle(fontSize: size * 0.5)),
  );
}
