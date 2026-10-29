import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:intl/intl.dart';

/// Builds a CSV of [transactions] (oldest first).
///
/// Amounts are written as plain decimals with `.` (spreadsheet friendly,
/// locale independent) straight from minor units — no doubles involved.
String buildTransactionsCsv({
  required List<TransactionRecord> transactions,
  required Map<String, CategoryRecord> categories,
  required AppLocalizations l10n,
}) {
  final dateFormat = DateFormat('yyyy-MM-dd HH:mm');
  final rows = <List<Object?>>[
    [
      l10n.csvDate,
      l10n.csvType,
      l10n.csvTitle,
      l10n.csvCategory,
      l10n.csvAmount,
      l10n.csvCurrency,
      l10n.csvRate,
      l10n.csvHomeAmount,
      l10n.csvHomeCurrency,
      l10n.csvPayment,
      l10n.csvNote,
    ],
    for (final t in [...transactions]..sort((a, b) => a.date.compareTo(b.date)))
      [
        dateFormat.format(t.date),
        if (t.isExpense) l10n.filterExpenses else l10n.filterIncome,
        t.title ?? '',
        if (categories[t.categoryId] case final c?) l10n.categoryName(c) else '',
        t.signedAmount.toDecimal().toStringAsFixed(t.currency.decimals),
        t.currency.code,
        t.fxRate.toString(),
        t.homeAmount.times(t.sign).toDecimal().toStringAsFixed(t.homeCurrency.decimals),
        t.homeCurrency.code,
        switch (t.paymentMethod) {
          PaymentMethod.card => l10n.txPaymentCard,
          PaymentMethod.cash => l10n.txPaymentCash,
          PaymentMethod.transfer => l10n.txPaymentTransfer,
          PaymentMethod.other => l10n.txPaymentOther,
        },
        t.note ?? '',
      ],
  ];
  return csv.encode(rows);
}

/// UTF-8 with BOM so Excel opens Arabic / accented text correctly.
List<int> csvBytes(String content) => [0xEF, 0xBB, 0xBF, ...utf8.encode(content)];
