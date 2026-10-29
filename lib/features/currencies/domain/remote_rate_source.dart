import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';

/// Rates fetched from a provider: `1 base = rates[code] code`.
@immutable
class RemoteRates {
  const RemoteRates({
    required this.base,
    required this.rates,
    required this.provider,
    this.providerUpdatedAt,
  });

  final String base;
  final Map<String, Decimal> rates;
  final String provider;
  final DateTime? providerUpdatedAt;
}

class RateFetchException implements Exception {
  const RateFetchException(this.message);

  final String message;

  @override
  String toString() => 'RateFetchException: $message';
}

/// Swappable remote provider of latest exchange rates.
abstract interface class RemoteRateSource {
  /// Throws [RateFetchException] (or a network exception) on failure.
  Future<RemoteRates> fetchLatest(String base);
}
