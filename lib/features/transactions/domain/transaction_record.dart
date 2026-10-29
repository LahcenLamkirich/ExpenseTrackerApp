import 'package:decimal/decimal.dart';
import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_record.freezed.dart';

/// A recorded expense or income.
///
/// [amount] is the original amount (always positive). [fxRate] and
/// [homeAmount] are frozen at entry time against [homeAmount]'s currency,
/// so later rate changes never rewrite history.
@freezed
abstract class TransactionRecord with _$TransactionRecord {
  const factory TransactionRecord({
    required String id,
    required TransactionType type,
    required Money amount,
    required Decimal fxRate,
    required Money homeAmount,
    required RateSource rateSource,
    required String categoryId,
    required PaymentMethod paymentMethod,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? title,
    String? note,
  }) = _TransactionRecord;

  const TransactionRecord._();

  Currency get currency => amount.currency;
  Currency get homeCurrency => homeAmount.currency;

  /// True when the original amount was converted to reach the home amount.
  bool get isConverted => amount.currencyCode != homeAmount.currencyCode;

  bool get isExpense => type == TransactionType.expense;

  /// Negative for expenses, positive for income.
  int get sign => isExpense ? -1 : 1;

  Money get signedAmount => amount.times(sign);
}
