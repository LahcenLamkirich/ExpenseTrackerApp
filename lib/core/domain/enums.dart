/// Enums shared by the database schema and feature domains.
///
/// Persisted by index (drift `intEnum`), so **only append** new values.
library;

enum TransactionType { expense, income }

enum PaymentMethod { card, cash, transfer, other }

enum CategoryKind { expense, income }

/// Where a transaction's frozen exchange rate came from.
enum RateSource {
  /// Transaction currency equals the home currency.
  identity,

  /// Cached rate from the exchange-rate API.
  api,

  /// Entered by the user (offline / first launch).
  manual,
}
