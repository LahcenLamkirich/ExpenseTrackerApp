import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Transaction card (designs 03/05): category badge, title, category and
/// time, home amount (≈ when converted) and the original amount or "Direct".
class TransactionTile extends StatelessWidget {
  const TransactionTile({
    required this.transaction,
    required this.category,
    required this.resolved,
    super.key,
    this.onTap,
  });

  final TransactionRecord transaction;
  final CategoryRecord? category;

  /// Amount in the current home currency; null when no rate is known.
  final ResolvedAmount? resolved;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final t = transaction;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final categoryName = category == null ? l10n.categoryOther : l10n.categoryName(category!);
    final title = (t.title?.isNotEmpty ?? false) ? t.title! : categoryName;
    final time = DateFormat.jm(locale).format(t.date);
    final amountColor = t.isExpense ? c.expense : c.income;
    final converted = t.isConverted || (resolved?.isApproximate ?? false);

    final primary = resolved == null
        ? fmt.format(t.signedAmount, display: MoneyDisplay.code)
        : fmt.format(resolved!.amount.times(t.sign), display: MoneyDisplay.code, signed: !t.isExpense);
    final secondary = converted || resolved == null
        ? fmt.format(t.amount)
        : l10n.historyDirect;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.md),
      semanticLabel: '$title, $categoryName, $primary',
      child: Row(
        children: [
          CategoryIcon(
            glyph: category?.glyph ?? '📦',
            color: category?.color ?? c.muted,
            size: 48,
          ),
          const SizedBox(width: Space.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  t.note?.isNotEmpty ?? false ? '$categoryName • ${t.note}' : '$categoryName • $time',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.text.bodySmall?.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                converted ? '≈ $primary' : primary,
                maxLines: 1,
                style: AppTypography.amount.copyWith(color: amountColor),
              ),
              const SizedBox(height: 2),
              Text(
                secondary,
                maxLines: 1,
                style: AppTypography.labelCode.copyWith(color: c.muted, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
