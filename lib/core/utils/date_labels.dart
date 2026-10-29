import 'package:flossi/l10n/l10n.dart';
import 'package:intl/intl.dart';

DateTime dateOnly(DateTime t) => DateTime(t.year, t.month, t.day);

/// `Today`, `Yesterday` or a short localized date (`Wed, 22 Oct`).
String relativeDayLabel(AppLocalizations l10n, String locale, DateTime day, DateTime now) {
  final d = dateOnly(day);
  final today = dateOnly(now);
  if (d == today) return l10n.txToday;
  if (d == DateTime(today.year, today.month, today.day - 1)) return l10n.txYesterday;
  final pattern = d.year == today.year ? DateFormat.MMMEd(locale) : DateFormat.yMMMEd(locale);
  return pattern.format(d);
}

/// Day header for grouped lists: `TODAY, 24 OCT`, `MONDAY, 22 OCT`.
String dayHeaderLabel(AppLocalizations l10n, String locale, DateTime day, DateTime now) {
  final d = dateOnly(day);
  final today = dateOnly(now);
  final dayMonth = d.year == today.year ? DateFormat.MMMd(locale).format(d) : DateFormat.yMMMd(locale).format(d);
  final String prefix;
  if (d == today) {
    prefix = l10n.txToday;
  } else if (d == DateTime(today.year, today.month, today.day - 1)) {
    prefix = l10n.txYesterday;
  } else {
    prefix = DateFormat.EEEE(locale).format(d);
  }
  return '$prefix, $dayMonth';
}

/// Number of days in the month containing [t].
int daysInMonth(DateTime t) => DateTime(t.year, t.month + 1, 0).day;

/// `just now`, `4 min ago`, `3 hours ago`, `2 days ago`.
String timeAgo(AppLocalizations l10n, DateTime then, DateTime now) {
  final d = now.difference(then);
  if (d.inMinutes < 1) return l10n.timeJustNow;
  if (d.inHours < 1) return l10n.timeMinutesAgo(d.inMinutes);
  if (d.inDays < 1) return l10n.timeHoursAgo(d.inHours);
  return l10n.timeDaysAgo(d.inDays);
}
