import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/exchange_rate.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';

/// How the currency is shown next to a formatted amount.
enum MoneyDisplay {
  /// Symbol for currencies with an unambiguous one (`€12.50`), ISO code
  /// suffix otherwise (`1,250.00 MAD`).
  auto,

  /// Always the symbol, placed per locale.
  symbol,

  /// Always the ISO code as a suffix.
  code,

  /// Number only.
  none,
}

/// A formatted amount split into pieces, for hero layouts that style the
/// integer, fraction and currency differently.
@immutable
class MoneyParts {
  const MoneyParts({
    required this.sign,
    required this.integer,
    required this.decimalSeparator,
    required this.fraction,
    required this.currency,
    required this.currencyFirst,
  });

  /// `-`, `+` or empty.
  final String sign;
  final String integer;
  final String decimalSeparator;

  /// Empty for zero-decimal currencies.
  final String fraction;

  /// Symbol or code; empty for [MoneyDisplay.none].
  final String currency;

  /// Whether [currency] goes before the number in this locale.
  final bool currencyFirst;

  String get number =>
      fraction.isEmpty ? '$sign$integer' : '$sign$integer$decimalSeparator$fraction';
}

/// Locale-aware money formatting built on intl, without ever converting
/// amounts to `double`: the integer part goes through [NumberFormat] as an
/// exact `int` and the fraction digits are appended from minor units.
class MoneyFormatter {
  MoneyFormatter(String locale)
    : locale = Intl.canonicalizedLocale(locale),
      _grouping = NumberFormat.decimalPattern(locale),
      _symbols = NumberFormat.decimalPattern(locale).symbols {
    final probe = NumberFormat.currency(
      locale: locale,
      symbol: _probe,
      decimalDigits: 0,
    ).format(1);
    _symbolFirst = probe.indexOf(_probe) < probe.indexOf(_localizeDigits('1'));
    _symbolSpaced = probe.replaceAll(RegExp('[‎‏؜]'), '').contains(
      RegExp(_symbolFirst ? '$_probe\\s' : '\\s$_probe'),
    );
  }

  static const _probe = '¤';
  static const _nbsp = ' ';

  final String locale;
  final NumberFormat _grouping;
  final NumberSymbols _symbols;
  late final bool _symbolFirst;
  late final bool _symbolSpaced;

  String get decimalSeparator => _symbols.DECIMAL_SEP;
  String get minusSign => _symbols.MINUS_SIGN;
  String get plusSign => _symbols.PLUS_SIGN;

  /// Formats [money], e.g. `€12.50`, `12,50 €`, `1 250,00 MAD`.
  ///
  /// - [signed]: prefix `+` for positive amounts (negative always get `-`).
  /// - [absolute]: drop the sign entirely (lists that colour by type).
  /// - [trimZeroFraction]: `1,250 MAD` instead of `1,250.00 MAD`.
  String format(
    Money money, {
    MoneyDisplay display = MoneyDisplay.auto,
    bool signed = false,
    bool absolute = false,
    bool trimZeroFraction = false,
  }) {
    final p = parts(
      money,
      display: display,
      signed: signed,
      absolute: absolute,
      trimZeroFraction: trimZeroFraction,
    );
    if (p.currency.isEmpty) return p.number;
    final unsigned = p.fraction.isEmpty
        ? p.integer
        : '${p.integer}${p.decimalSeparator}${p.fraction}';
    if (p.currencyFirst) {
      final gap = _symbolSpaced ? _nbsp : '';
      return '${p.sign}${p.currency}$gap$unsigned';
    }
    return '${p.sign}$unsigned$_nbsp${p.currency}';
  }

  /// Number without currency, e.g. `12,480.50`.
  String formatNumber(
    Money money, {
    bool signed = false,
    bool absolute = false,
    bool trimZeroFraction = false,
  }) => format(
    money,
    display: MoneyDisplay.none,
    signed: signed,
    absolute: absolute,
    trimZeroFraction: trimZeroFraction,
  );

  MoneyParts parts(
    Money money, {
    MoneyDisplay display = MoneyDisplay.auto,
    bool signed = false,
    bool absolute = false,
    bool trimZeroFraction = false,
  }) {
    final decimals = money.currency.decimals;
    final abs = money.minor.abs();
    var divisor = 1;
    for (var i = 0; i < decimals; i++) {
      divisor *= 10;
    }
    final integer = _grouping.format(abs ~/ divisor);
    var fraction = decimals == 0
        ? ''
        : _localizeDigits((abs % divisor).toString().padLeft(decimals, '0'));
    if (trimZeroFraction && abs % divisor == 0) fraction = '';

    final sign = absolute || money.minor == 0
        ? ''
        : money.isNegative
        ? minusSign
        : signed
        ? plusSign
        : '';

    final useSymbol = switch (display) {
      MoneyDisplay.auto => money.currency.prefersSymbol,
      MoneyDisplay.symbol => true,
      MoneyDisplay.code || MoneyDisplay.none => false,
    };
    final currency = switch (display) {
      MoneyDisplay.none => '',
      _ => useSymbol ? money.currency.symbol : money.currency.code,
    };

    return MoneyParts(
      sign: sign,
      integer: integer,
      decimalSeparator: decimalSeparator,
      fraction: fraction,
      currency: currency,
      currencyFirst: useSymbol && _symbolFirst,
    );
  }

  /// Short form for chart axes and tight chips, e.g. `12.5K`.
  ///
  /// Uses a double internally; display-only, never fed back into math.
  String formatCompact(Money money) => NumberFormat.compact(
    locale: locale,
  ).format(money.toDecimal().toDouble());

  /// Formats a rate value with 2–4 fraction digits, e.g. `10.84`.
  String formatRateValue(Decimal rate, {int maxDecimals = 4}) {
    var rounded = rate.round(scale: maxDecimals).toStringAsFixed(maxDecimals);
    // Keep at least two fraction digits, drop the remaining trailing zeros.
    while (rounded.endsWith('0') &&
        rounded.split('.')[1].length > 2) {
      rounded = rounded.substring(0, rounded.length - 1);
    }
    final [intPart, fracPart] = rounded.split('.');
    return '${_grouping.format(int.parse(intPart))}'
        '$decimalSeparator${_localizeDigits(fracPart)}';
  }

  /// `1 EUR = 10.84 MAD`.
  String formatRate(ExchangeRate rate) =>
      '${_localizeDigits('1')} ${rate.from.code} = '
      '${formatRateValue(rate.rate)} ${rate.to.code}';

  String _localizeDigits(String asciiDigits) {
    final zero = _symbols.ZERO_DIGIT.codeUnitAt(0);
    if (zero == 0x30) return asciiDigits;
    return String.fromCharCodes(
      asciiDigits.codeUnits.map(
        (c) => c >= 0x30 && c <= 0x39 ? zero + (c - 0x30) : c,
      ),
    );
  }
}
