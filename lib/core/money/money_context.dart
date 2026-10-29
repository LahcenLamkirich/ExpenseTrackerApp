import 'package:flossi/core/money/money_formatter.dart';
import 'package:flutter/widgets.dart';

export 'package:flossi/core/money/money_formatter.dart' show MoneyDisplay, MoneyFormatter;

final _formatters = <String, MoneyFormatter>{};

/// Formatter for the active locale, cached per locale tag.
MoneyFormatter moneyFormatterFor(Locale locale) {
  final tag = locale.toLanguageTag();
  return _formatters.putIfAbsent(tag, () => MoneyFormatter(tag));
}

extension MoneyFormatContext on BuildContext {
  MoneyFormatter get money => moneyFormatterFor(Localizations.localeOf(this));
}
