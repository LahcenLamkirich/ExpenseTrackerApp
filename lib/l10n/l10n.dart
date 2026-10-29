import 'package:flossi/l10n/gen/app_localizations.dart';
import 'package:flutter/widgets.dart';

export 'package:flossi/l10n/gen/app_localizations.dart';

extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
