import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';

/// How a display amount in the current home currency was obtained.
enum HomeAmountSource {
  /// The frozen amount stored with the transaction (same home currency).
  stored,

  /// The transaction itself is in the current home currency.
  original,

  /// Re-converted with a cached rate (home currency changed since entry).
  reconverted,
}

class ResolvedAmount {
  const ResolvedAmount(this.amount, this.source);

  /// Positive amount in the current home currency.
  final Money amount;
  final HomeAmountSource source;

  bool get isApproximate => source == HomeAmountSource.reconverted;
}

/// Converts `from → to` for a transaction date, or returns null when no rate
/// is known. Supplied by the rate layer; synchronous so aggregations stay
/// cheap (implementations work from an in-memory rate table).
typedef HistoricalConverter = Money? Function(Money amount, Currency to, DateTime at);

/// Resolves every transaction to the *current* home currency without ever
/// rewriting stored values:
///
/// 1. stored home amount when the home currency hasn't changed;
/// 2. the original amount when it is already in the new home currency;
/// 3. a re-conversion via [convert] (historical rate, then latest);
/// 4. otherwise null — the caller excludes it and flags it.
class HomeAmountResolver {
  const HomeAmountResolver(this.home, {this.convert});

  final Currency home;
  final HistoricalConverter? convert;

  ResolvedAmount? resolve(TransactionRecord t) {
    if (t.homeCurrency.code == home.code) {
      return ResolvedAmount(t.homeAmount, HomeAmountSource.stored);
    }
    if (t.currency.code == home.code) {
      return ResolvedAmount(Money(t.amount.minor, home), HomeAmountSource.original);
    }
    final converted = convert?.call(t.amount, home, t.date);
    if (converted == null) return null;
    return ResolvedAmount(converted, HomeAmountSource.reconverted);
  }
}
