import 'dart:async';

import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_editor_sheet.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/transactions/presentation/transaction_providers.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Categories management (design 09).
class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  CategoryKind _kind = CategoryKind.expense;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final categories = ref.watch(activeCategoriesProvider(_kind));
    final totals = ref.watch(monthCategoryTotalsProvider).value ?? const <String, Money>{};
    final home = ref.watch(homeCurrencyProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(title: l10n.categoriesTitle),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(
                  Space.margin,
                  Space.sm,
                  Space.margin,
                  Space.xl + MediaQuery.paddingOf(context).bottom,
                ),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(l10n.categoriesTitle, style: context.text.headlineMedium),
                            Text(l10n.categoriesSubtitle, style: context.text.bodySmall),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        label: l10n.categoriesNew,
                        expand: false,
                        leadingIcon: Icons.add_rounded,
                        trailingIcon: null,
                        onPressed: () => showCategoryEditor(context, kind: _kind),
                      ),
                    ],
                  ),
                  const SizedBox(height: Space.md),
                  SegmentedPill<CategoryKind>(
                    selected: _kind,
                    onChanged: (k) => setState(() => _kind = k),
                    segments: [
                      Segment(value: CategoryKind.expense, label: l10n.categoriesExpenses),
                      Segment(value: CategoryKind.income, label: l10n.categoriesIncome),
                    ],
                  ),
                  const SizedBox(height: Space.md),
                  ...switch (categories) {
                    AsyncData(:final value) when value.isEmpty => [
                      Padding(
                        padding: const EdgeInsets.all(Space.xl),
                        child: Text(l10n.categoriesEmpty, textAlign: TextAlign.center, style: context.text.bodyMedium?.copyWith(color: c.muted)),
                      ),
                    ],
                    AsyncData(:final value) => [
                      if (_kind == CategoryKind.expense) _CapsSummary(categories: value, totals: totals, home: home),
                      for (final cat in value) ...[
                        const SizedBox(height: Space.smd),
                        _CategoryCard(
                          category: cat,
                          spent: totals[cat.id] ?? Money.zero(home),
                        ),
                      ],
                    ],
                    _ => [const Center(child: CircularProgressIndicator())],
                  },
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CapsSummary extends StatelessWidget {
  const _CapsSummary({required this.categories, required this.totals, required this.home});

  final List<CategoryRecord> categories;
  final Map<String, Money> totals;
  final Currency home;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final capped = categories.where((cat) => cat.monthlyCapMinor != null).toList();
    if (capped.isEmpty) return const SizedBox.shrink();
    // Caps and totals are both in the home currency's minor units.
    final cap = Money(capped.fold(0, (s, cat) => s + cat.monthlyCapMinor!), home);
    final spent = Money(capped.fold(0, (s, cat) => s + (totals[cat.id]?.minor ?? 0)), home);
    final percent = cap.isZero ? 0 : (spent.ratioTo(cap) * 100).round();

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: c.accent.withValues(alpha: 0.35), shape: BoxShape.circle),
            child: Icon(Icons.donut_large_rounded, color: c.accentStrong),
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.categoriesCapsSummary.toUpperCase(), style: context.text.labelMedium),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: context.money.formatNumber(spent, trimZeroFraction: true),
                        style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: ' / ${context.money.format(cap, display: MoneyDisplay.code, trimZeroFraction: true)}',
                        style: context.text.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TagPill(
            label: l10n.categoriesCapUsed(percent),
            background: percent >= 100 ? c.expenseSoft : c.incomeSoft,
            foreground: percent >= 100 ? c.expense : c.income,
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends ConsumerWidget {
  const _CategoryCard({required this.category, required this.spent});

  final CategoryRecord category;
  final Money spent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final capMinor = category.monthlyCapMinor;
    final cap = capMinor == null ? null : Money(capMinor, spent.currency);
    final ratio = cap == null || cap.isZero ? 0.0 : spent.ratioTo(cap);
    final percent = (ratio * 100).round();
    final isExpense = category.kind == CategoryKind.expense;

    final (String? badge, bool alarming) = switch (ratio) {
      _ when cap == null => (null, false),
      >= 1.0 => (l10n.categoriesOverCap, true),
      >= 0.95 => (l10n.categoriesCritical, true),
      >= 0.85 => (l10n.categoriesNearCap, true),
      _ => (null, false),
    };

    return AppCard(
      onTap: () => showCategoryEditor(context, kind: category.kind, category: category),
      child: Column(
        children: [
          Row(
            children: [
              CategoryIcon(glyph: category.glyph, color: category.color, size: 52),
              const SizedBox(width: Space.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            l10n.categoryName(category),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.titleMedium,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: Space.sm),
                          TagPill(label: badge, background: c.expenseSoft, foreground: c.expense),
                        ],
                      ],
                    ),
                    Text(
                      cap == null ? l10n.categoriesNoCap : l10n.categoriesOfCap(percent),
                      style: context.text.bodySmall,
                    ),
                  ],
                ),
              ),
              CurrencyCodeBadge(currency: spent.currency),
              PopupMenuButton<String>(
                tooltip: l10n.commonMore,
                icon: Icon(Icons.more_vert_rounded, color: c.ink),
                onSelected: (v) {
                  if (v == 'edit') unawaited(showCategoryEditor(context, kind: category.kind, category: category));
                  if (v == 'delete') unawaited(confirmDeleteCategory(context, ref, category));
                },
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'edit', child: Text(l10n.commonEdit)),
                  PopupMenuItem(value: 'delete', child: Text(l10n.commonDelete)),
                ],
              ),
            ],
          ),
          const SizedBox(height: Space.md),
          if (cap != null) ...[
            AppProgressBar(value: ratio, color: alarming ? c.expense : category.color),
            const SizedBox(height: Space.sm),
          ],
          Row(
            children: [
              Expanded(
                child: Text(
                  isExpense
                      ? l10n.categoriesSpent(fmt.format(spent, display: MoneyDisplay.code, trimZeroFraction: true))
                      : l10n.categoriesReceived(fmt.format(spent, display: MoneyDisplay.code, trimZeroFraction: true)),
                  style: context.text.bodyMedium?.copyWith(color: alarming ? c.expense : c.ink),
                ),
              ),
              if (cap != null)
                Text(
                  l10n.categoriesCap(fmt.format(cap, display: MoneyDisplay.code, trimZeroFraction: true)),
                  style: context.text.bodyMedium,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
