import 'package:flutter/foundation.dart';

/// An ISO 4217 currency with the metadata needed to store, convert and
/// display amounts.
@immutable
class Currency {
  const Currency({
    required this.code,
    required this.decimals,
    required this.symbol,
    required this.name,
    required this.flag,
    this.country = '',
    this.prefersSymbol = false,
  });

  /// Fallback for codes returned by a rate provider that are not in the
  /// bundled catalog. ISO 4217 defaults to 2 minor-unit digits.
  factory Currency.unknown(String code) => Currency(
    code: code.toUpperCase(),
    decimals: 2,
    symbol: code.toUpperCase(),
    name: code.toUpperCase(),
    flag: '🏳️',
  );

  /// ISO 4217 alphabetic code, e.g. `MAD`.
  final String code;

  /// Number of minor-unit digits (0 for JPY, 2 for EUR, 3 for KWD).
  final int decimals;

  /// Short display symbol, e.g. `€` or `DH`.
  final String symbol;

  /// English display name. Localized names come from ARB files.
  final String name;

  /// Flag emoji representing the currency.
  final String flag;

  /// Primary country or region, for search.
  final String country;

  /// Whether amounts read better with the symbol (`€12.50`) than with the
  /// ISO code suffix (`1,250.00 MAD`). Only true for unambiguous symbols.
  final bool prefersSymbol;

  @override
  bool operator ==(Object other) => other is Currency && other.code == code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'Currency($code)';
}

/// Bundled, offline currency table.
abstract final class CurrencyCatalog {
  /// Currencies pinned at the top of every picker.
  static const pinnedCodes = ['MAD', 'EUR', 'USD'];

  static const List<Currency> all = [
    Currency(code: 'MAD', decimals: 2, symbol: 'DH', name: 'Moroccan Dirham', flag: '🇲🇦', country: 'Morocco'),
    Currency(code: 'EUR', decimals: 2, symbol: '€', name: 'Euro', flag: '🇪🇺', country: 'Eurozone', prefersSymbol: true),
    Currency(code: 'USD', decimals: 2, symbol: r'$', name: 'US Dollar', flag: '🇺🇸', country: 'United States', prefersSymbol: true),
    Currency(code: 'GBP', decimals: 2, symbol: '£', name: 'British Pound', flag: '🇬🇧', country: 'United Kingdom', prefersSymbol: true),
    Currency(code: 'CHF', decimals: 2, symbol: 'CHF', name: 'Swiss Franc', flag: '🇨🇭', country: 'Switzerland'),
    Currency(code: 'AED', decimals: 2, symbol: 'د.إ', name: 'UAE Dirham', flag: '🇦🇪', country: 'United Arab Emirates'),
    Currency(code: 'SAR', decimals: 2, symbol: '﷼', name: 'Saudi Riyal', flag: '🇸🇦', country: 'Saudi Arabia'),
    Currency(code: 'QAR', decimals: 2, symbol: 'QR', name: 'Qatari Riyal', flag: '🇶🇦', country: 'Qatar'),
    Currency(code: 'KWD', decimals: 3, symbol: 'KD', name: 'Kuwaiti Dinar', flag: '🇰🇼', country: 'Kuwait'),
    Currency(code: 'BHD', decimals: 3, symbol: 'BD', name: 'Bahraini Dinar', flag: '🇧🇭', country: 'Bahrain'),
    Currency(code: 'OMR', decimals: 3, symbol: 'OMR', name: 'Omani Rial', flag: '🇴🇲', country: 'Oman'),
    Currency(code: 'JOD', decimals: 3, symbol: 'JD', name: 'Jordanian Dinar', flag: '🇯🇴', country: 'Jordan'),
    Currency(code: 'TND', decimals: 3, symbol: 'DT', name: 'Tunisian Dinar', flag: '🇹🇳', country: 'Tunisia'),
    Currency(code: 'LYD', decimals: 3, symbol: 'LD', name: 'Libyan Dinar', flag: '🇱🇾', country: 'Libya'),
    Currency(code: 'IQD', decimals: 3, symbol: 'IQD', name: 'Iraqi Dinar', flag: '🇮🇶', country: 'Iraq'),
    Currency(code: 'DZD', decimals: 2, symbol: 'DA', name: 'Algerian Dinar', flag: '🇩🇿', country: 'Algeria'),
    Currency(code: 'EGP', decimals: 2, symbol: 'E£', name: 'Egyptian Pound', flag: '🇪🇬', country: 'Egypt'),
    Currency(code: 'LBP', decimals: 2, symbol: 'LBP', name: 'Lebanese Pound', flag: '🇱🇧', country: 'Lebanon'),
    Currency(code: 'ILS', decimals: 2, symbol: '₪', name: 'Israeli New Shekel', flag: '🇮🇱', country: 'Israel', prefersSymbol: true),
    Currency(code: 'TRY', decimals: 2, symbol: '₺', name: 'Turkish Lira', flag: '🇹🇷', country: 'Türkiye', prefersSymbol: true),
    Currency(code: 'CAD', decimals: 2, symbol: r'CA$', name: 'Canadian Dollar', flag: '🇨🇦', country: 'Canada'),
    Currency(code: 'AUD', decimals: 2, symbol: r'A$', name: 'Australian Dollar', flag: '🇦🇺', country: 'Australia'),
    Currency(code: 'NZD', decimals: 2, symbol: r'NZ$', name: 'New Zealand Dollar', flag: '🇳🇿', country: 'New Zealand'),
    Currency(code: 'JPY', decimals: 0, symbol: '¥', name: 'Japanese Yen', flag: '🇯🇵', country: 'Japan', prefersSymbol: true),
    Currency(code: 'CNY', decimals: 2, symbol: 'CN¥', name: 'Chinese Yuan', flag: '🇨🇳', country: 'China'),
    Currency(code: 'HKD', decimals: 2, symbol: r'HK$', name: 'Hong Kong Dollar', flag: '🇭🇰', country: 'Hong Kong'),
    Currency(code: 'SGD', decimals: 2, symbol: r'S$', name: 'Singapore Dollar', flag: '🇸🇬', country: 'Singapore'),
    Currency(code: 'KRW', decimals: 0, symbol: '₩', name: 'South Korean Won', flag: '🇰🇷', country: 'South Korea', prefersSymbol: true),
    Currency(code: 'INR', decimals: 2, symbol: '₹', name: 'Indian Rupee', flag: '🇮🇳', country: 'India', prefersSymbol: true),
    Currency(code: 'PKR', decimals: 2, symbol: 'Rs', name: 'Pakistani Rupee', flag: '🇵🇰', country: 'Pakistan'),
    Currency(code: 'IDR', decimals: 2, symbol: 'Rp', name: 'Indonesian Rupiah', flag: '🇮🇩', country: 'Indonesia'),
    Currency(code: 'MYR', decimals: 2, symbol: 'RM', name: 'Malaysian Ringgit', flag: '🇲🇾', country: 'Malaysia'),
    Currency(code: 'THB', decimals: 2, symbol: '฿', name: 'Thai Baht', flag: '🇹🇭', country: 'Thailand', prefersSymbol: true),
    Currency(code: 'VND', decimals: 0, symbol: '₫', name: 'Vietnamese Dong', flag: '🇻🇳', country: 'Vietnam', prefersSymbol: true),
    Currency(code: 'PHP', decimals: 2, symbol: '₱', name: 'Philippine Peso', flag: '🇵🇭', country: 'Philippines', prefersSymbol: true),
    Currency(code: 'SEK', decimals: 2, symbol: 'kr', name: 'Swedish Krona', flag: '🇸🇪', country: 'Sweden'),
    Currency(code: 'NOK', decimals: 2, symbol: 'kr', name: 'Norwegian Krone', flag: '🇳🇴', country: 'Norway'),
    Currency(code: 'DKK', decimals: 2, symbol: 'kr', name: 'Danish Krone', flag: '🇩🇰', country: 'Denmark'),
    Currency(code: 'ISK', decimals: 0, symbol: 'kr', name: 'Icelandic Króna', flag: '🇮🇸', country: 'Iceland'),
    Currency(code: 'PLN', decimals: 2, symbol: 'zł', name: 'Polish Złoty', flag: '🇵🇱', country: 'Poland'),
    Currency(code: 'CZK', decimals: 2, symbol: 'Kč', name: 'Czech Koruna', flag: '🇨🇿', country: 'Czechia'),
    Currency(code: 'HUF', decimals: 2, symbol: 'Ft', name: 'Hungarian Forint', flag: '🇭🇺', country: 'Hungary'),
    Currency(code: 'RON', decimals: 2, symbol: 'lei', name: 'Romanian Leu', flag: '🇷🇴', country: 'Romania'),
    Currency(code: 'BGN', decimals: 2, symbol: 'лв', name: 'Bulgarian Lev', flag: '🇧🇬', country: 'Bulgaria'),
    Currency(code: 'RSD', decimals: 2, symbol: 'RSD', name: 'Serbian Dinar', flag: '🇷🇸', country: 'Serbia'),
    Currency(code: 'UAH', decimals: 2, symbol: '₴', name: 'Ukrainian Hryvnia', flag: '🇺🇦', country: 'Ukraine', prefersSymbol: true),
    Currency(code: 'RUB', decimals: 2, symbol: '₽', name: 'Russian Ruble', flag: '🇷🇺', country: 'Russia', prefersSymbol: true),
    Currency(code: 'BRL', decimals: 2, symbol: r'R$', name: 'Brazilian Real', flag: '🇧🇷', country: 'Brazil'),
    Currency(code: 'MXN', decimals: 2, symbol: r'MX$', name: 'Mexican Peso', flag: '🇲🇽', country: 'Mexico'),
    Currency(code: 'ARS', decimals: 2, symbol: r'AR$', name: 'Argentine Peso', flag: '🇦🇷', country: 'Argentina'),
    Currency(code: 'CLP', decimals: 0, symbol: r'CL$', name: 'Chilean Peso', flag: '🇨🇱', country: 'Chile'),
    Currency(code: 'COP', decimals: 2, symbol: r'CO$', name: 'Colombian Peso', flag: '🇨🇴', country: 'Colombia'),
    Currency(code: 'PEN', decimals: 2, symbol: 'S/', name: 'Peruvian Sol', flag: '🇵🇪', country: 'Peru'),
    Currency(code: 'ZAR', decimals: 2, symbol: 'R', name: 'South African Rand', flag: '🇿🇦', country: 'South Africa'),
    Currency(code: 'NGN', decimals: 2, symbol: '₦', name: 'Nigerian Naira', flag: '🇳🇬', country: 'Nigeria', prefersSymbol: true),
    Currency(code: 'KES', decimals: 2, symbol: 'KSh', name: 'Kenyan Shilling', flag: '🇰🇪', country: 'Kenya'),
    Currency(code: 'GHS', decimals: 2, symbol: 'GH₵', name: 'Ghanaian Cedi', flag: '🇬🇭', country: 'Ghana'),
    Currency(code: 'XOF', decimals: 0, symbol: 'CFA', name: 'West African CFA Franc', flag: '🇸🇳', country: 'Senegal · Côte d’Ivoire'),
    Currency(code: 'XAF', decimals: 0, symbol: 'FCFA', name: 'Central African CFA Franc', flag: '🇨🇲', country: 'Cameroon · Gabon'),
    Currency(code: 'MRU', decimals: 2, symbol: 'UM', name: 'Mauritanian Ouguiya', flag: '🇲🇷', country: 'Mauritania'),
  ];

  static final Map<String, Currency> _byCode = {
    for (final c in all) c.code: c,
  };

  /// Looks up [code] (case-insensitive). Unknown codes get a 2-decimal
  /// fallback so data from a rate provider never crashes the app.
  static Currency of(String code) =>
      _byCode[code.toUpperCase()] ?? Currency.unknown(code);

  static bool isKnown(String code) => _byCode.containsKey(code.toUpperCase());

  static List<Currency> get pinned => [for (final c in pinnedCodes) of(c)];

  /// Non-pinned currencies, in catalog order.
  static List<Currency> get others => [
    for (final c in all)
      if (!pinnedCodes.contains(c.code)) c,
  ];

  /// Case- and accent-insensitive search over code, name and country.
  static List<Currency> search(String query, {Iterable<Currency>? within}) {
    final q = _fold(query.trim());
    final source = within ?? all;
    if (q.isEmpty) return source.toList();
    return source
        .where(
          (c) =>
              _fold(c.code).contains(q) ||
              _fold(c.name).contains(q) ||
              _fold(c.country).contains(q),
        )
        .toList();
  }

  static String _fold(String s) => s
      .toLowerCase()
      .replaceAll(RegExp('[àáâä]'), 'a')
      .replaceAll(RegExp('[èéêë]'), 'e')
      .replaceAll(RegExp('[ìíîï]'), 'i')
      .replaceAll(RegExp('[òóôöø]'), 'o')
      .replaceAll(RegExp('[ùúûü]'), 'u')
      .replaceAll('ç', 'c')
      .replaceAll('ł', 'l');
}
