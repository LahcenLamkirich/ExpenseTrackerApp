import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Debug-only showcase of the design system, reachable from Settings in
/// debug builds. Lets us review tokens and components against the Stitch
/// designs in light and dark mode.
class DesignGalleryScreen extends StatefulWidget {
  const DesignGalleryScreen({super.key});

  @override
  State<DesignGalleryScreen> createState() => _DesignGalleryScreenState();
}

enum _Period { week, month, year }

class _DesignGalleryScreenState extends State<DesignGalleryScreen> {
  _Period _period = _Period.month;
  Currency _currency = CurrencyCatalog.of('EUR');
  Money _total = Money.ofCode(1248050, 'MAD');

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final currencies = CurrencyCatalog.pinned + [CurrencyCatalog.of('GBP'), CurrencyCatalog.of('JPY')];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.galleryTitle)),
      body: ListView(
        padding: const EdgeInsets.all(Space.margin),
        children: [
          AppCard(
            glow: true,
            onTap: () => setState(() => _total = _total + Money.ofCode(12345, 'MAD')),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionLabel(l10n.gallerySampleAmount),
                HeroAmount(_total),
                const SizedBox(height: Space.md),
                const AppProgressBar(value: 0.83),
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          AppCard(
            child: Center(
              child: HeroAmount(
                Money(24000, _currency),
                currencyStyle: HeroCurrencyStyle.prefixSymbol,
              ),
            ),
          ),
          const SizedBox(height: Space.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final cur in currencies) ...[
                  CurrencyChip(
                    currency: cur,
                    selected: cur == _currency,
                    onTap: () => setState(() => _currency = cur),
                  ),
                  const SizedBox(width: Space.sm),
                ],
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          SegmentedPill<_Period>(
            selected: _period,
            onChanged: (p) => setState(() => _period = p),
            segments: [
              Segment(value: _Period.week, label: l10n.gallerySegmentWeek),
              Segment(value: _Period.month, label: l10n.gallerySegmentMonth),
              Segment(value: _Period.year, label: l10n.gallerySegmentYear),
            ],
          ),
          const SizedBox(height: Space.md),
          AppCard(
            child: Column(
              children: [
                for (final (i, glyph) in ['☕', '✈️', '💻', '🛒'].indexed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Space.sm),
                    child: Row(
                      children: [
                        CategoryIcon(glyph: glyph, color: Palette.categoryAccents[i]),
                        const SizedBox(width: Space.md),
                        Expanded(child: Text(glyph * 3, style: context.text.titleMedium)),
                        AmountText(Money(-(4500 + i * 12000), CurrencyCatalog.of('MAD')), colorBySign: true),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          Wrap(
            spacing: Space.sm,
            runSpacing: Space.sm,
            children: [
              TagPill(label: 'MAD', background: c.accent, foreground: c.onAccent, uppercase: true),
              TagPill(label: '+0.14%', background: c.incomeSoft, foreground: c.income),
              TagPill(label: '-0.08%', background: c.expenseSoft, foreground: c.expense),
              TagPill(label: 'Live', dot: true, foreground: c.income),
              CurrencyCodeBadge(currency: CurrencyCatalog.of('MAD'), showFlag: true),
              CurrencyCodeBadge(currency: CurrencyCatalog.of('EUR'), inverted: true),
            ],
          ),
          const SizedBox(height: Space.lg),
          PrimaryButton(label: l10n.gallerySampleButton, onPressed: () {}),
          const SizedBox(height: Space.sm),
          SecondaryButton(label: l10n.gallerySampleSecondary, onPressed: () {}),
          const SizedBox(height: Space.xl),
        ],
      ),
    );
  }
}
