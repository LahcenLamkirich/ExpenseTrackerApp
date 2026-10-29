// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flossi';

  @override
  String get navHome => 'Home';

  @override
  String get navHistory => 'History';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Settings';

  @override
  String get navAdd => 'Add transaction';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonUndo => 'Undo';

  @override
  String get commonBack => 'Back';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonApply => 'Apply';

  @override
  String get commonDone => 'Done';

  @override
  String get commonMore => 'More options';

  @override
  String get commonReset => 'Reset';

  @override
  String get commonRetry => 'Try again';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorBody => 'Your data is safe. Please try again.';

  @override
  String get screenComingSoon => 'Coming soon';

  @override
  String get screenComingSoonBody =>
      'This screen is being built in an upcoming phase.';

  @override
  String onboardingStep(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingLiveRates => 'Live rates';

  @override
  String get onboardingHomeBalance => 'Home balance';

  @override
  String get onboardingConsolidated => 'Everything in one currency';

  @override
  String get onboardingSynced => 'Synced';

  @override
  String get onboardingRateNote => 'Converted at the day’s rate';

  @override
  String get onboardingHeadline =>
      'Money without borders. Tracked with elegance.';

  @override
  String get onboardingSubtitle =>
      'Flossi converts Moroccan Dirham, Euro, US Dollar and 60+ currencies into your single home currency.';

  @override
  String get onboardingFeatureRates => 'Daily exchange rates';

  @override
  String get onboardingFeatureTracking => 'Zero-clutter tracking';

  @override
  String get onboardingFeaturePrivate => 'Private & offline-first';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingFootnote =>
      'No account needed. Your data stays on this device.';

  @override
  String get currencyStepTag => 'Primary ledger';

  @override
  String get currencyStepTitle => 'Choose your home currency';

  @override
  String get currencyStepBody =>
      'All expenses are converted into this currency for your balances and charts. You can change it anytime.';

  @override
  String get currencySearchHint => 'Search currency or country…';

  @override
  String get currencyPinned => 'Pinned';

  @override
  String get currencyAll => 'All currencies';

  @override
  String currencyCount(int count) {
    return '$count available';
  }

  @override
  String get currencyPrimaryBadge => 'Primary';

  @override
  String currencyConfirm(String code) {
    return 'Confirm home currency ($code)';
  }

  @override
  String currencyNoResults(String query) {
    return 'No currency matches “$query”';
  }

  @override
  String get pickCurrencyTitle => 'Choose currency';

  @override
  String get budgetStepTag => 'Mindful pacing';

  @override
  String get budgetStepTitle => 'Set your monthly spending target';

  @override
  String get budgetStepBody =>
      'Flossi keeps you mindful with gentle alerts as you approach your limit in your home currency.';

  @override
  String get budgetMonthlyCap => 'Monthly cap';

  @override
  String get budgetQuickAdjust => 'Quick adjust';

  @override
  String get budgetNone => 'No budget';

  @override
  String get budgetNoneHint => 'Track freely without a monthly limit.';

  @override
  String get budgetDailyPace => 'Daily safe pace';

  @override
  String budgetPerDay(String amount) {
    return '≈ $amount / day';
  }

  @override
  String budgetDays(int count) {
    return '$count days';
  }

  @override
  String get budgetNotifyTitle => 'Notify me at 80% spent';

  @override
  String get budgetNotifyBody => 'A gentle nudge before you overspend';

  @override
  String get budgetAllocation => 'Suggested allocation';

  @override
  String get budgetRule => '50 / 30 / 20 rule';

  @override
  String get budgetNeeds => 'Needs';

  @override
  String get budgetWants => 'Wants';

  @override
  String get budgetSavings => 'Savings';

  @override
  String get budgetComplete => 'Complete setup & enter Flossi';

  @override
  String get budgetSkip => 'Skip for now';

  @override
  String get budgetAdjustLater => 'You can adjust this anytime in Settings';

  @override
  String get budgetEditTitle => 'Monthly budget';

  @override
  String get budgetTapToEdit => 'Tap the amount to type it';

  @override
  String get txAddExpense => 'Add expense';

  @override
  String get txAddIncome => 'Add income';

  @override
  String get txEdit => 'Edit transaction';

  @override
  String get txOutflow => 'Outflow';

  @override
  String get txInflow => 'Inflow';

  @override
  String get txDate => 'Date';

  @override
  String get txToday => 'Today';

  @override
  String get txYesterday => 'Yesterday';

  @override
  String get txPaymentCard => 'Card';

  @override
  String get txPaymentCash => 'Cash';

  @override
  String get txPaymentTransfer => 'Transfer';

  @override
  String get txPaymentOther => 'Other';

  @override
  String get txTitleHint => 'Merchant or title';

  @override
  String get txNoteHint => 'Add a note';

  @override
  String get txCategory => 'Category';

  @override
  String get txSaveExpense => 'Save expense';

  @override
  String get txSaveIncome => 'Save income';

  @override
  String get txSaveChanges => 'Save changes';

  @override
  String get txRateMissing => 'No rate yet · tap to enter';

  @override
  String get txRateManual => 'manual';

  @override
  String get txMoreCurrencies => 'More';

  @override
  String get txDelete => 'Delete transaction';

  @override
  String get txDeleteConfirm => 'Delete this transaction?';

  @override
  String get txSaved => 'Transaction saved';

  @override
  String get txDeleted => 'Transaction deleted';

  @override
  String get txKeypadBackspace => 'Delete last digit';

  @override
  String get txKeypadDecimal => 'Decimal separator';

  @override
  String txConvertedWith(String from, String rate, String to) {
    return 'Converted at 1 $from = $rate $to';
  }

  @override
  String get rateSheetTitle => 'Enter exchange rate';

  @override
  String rateSheetBody(String from, String to) {
    return 'No cached rate for $from → $to yet. Enter today’s rate; it is saved for offline use.';
  }

  @override
  String get rateSheetInvalid => 'Enter a rate greater than 0';

  @override
  String get historySearchHint => 'Search transactions, notes…';

  @override
  String get historyDirect => 'Direct';

  @override
  String historyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
    );
    return '$_temp0';
  }

  @override
  String get historyTotal => 'Total';

  @override
  String get historyEmptyTitle => 'No transactions yet';

  @override
  String get historyEmptyBody => 'Tap + to record your first expense.';

  @override
  String get historyNoMatchesTitle => 'Nothing matches';

  @override
  String get historyNoMatchesBody => 'Try another search or clear the filters.';

  @override
  String historyUnresolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions need a rate',
      one: '1 transaction needs a rate',
    );
    return '$_temp0';
  }

  @override
  String get filterThisMonth => 'This month';

  @override
  String get filterAllTime => 'All time';

  @override
  String get filterDateRange => 'Date range';

  @override
  String get filterCategories => 'All categories';

  @override
  String filterCategoriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count categories',
      one: '1 category',
    );
    return '$_temp0';
  }

  @override
  String get filterCurrencies => 'All currencies';

  @override
  String filterCurrenciesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count currencies',
      one: '1 currency',
    );
    return '$_temp0';
  }

  @override
  String get filterAllTypes => 'All types';

  @override
  String get filterExpenses => 'Expenses';

  @override
  String get filterIncome => 'Income';

  @override
  String get filterClearAll => 'Clear filters';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get categoriesSubtitle => 'Manage & customize your spending';

  @override
  String get categoriesNew => 'New category';

  @override
  String get categoriesCapsSummary => 'Active monthly caps';

  @override
  String categoriesCapUsed(int percent) {
    return '$percent% used';
  }

  @override
  String categoriesOfCap(int percent) {
    return '$percent% of monthly cap';
  }

  @override
  String categoriesSpent(String amount) {
    return '$amount spent';
  }

  @override
  String categoriesReceived(String amount) {
    return '$amount received';
  }

  @override
  String categoriesCap(String amount) {
    return 'Cap: $amount';
  }

  @override
  String get categoriesNoCap => 'No monthly cap';

  @override
  String get categoriesNearCap => 'Near cap';

  @override
  String get categoriesCritical => 'Critical';

  @override
  String get categoriesOverCap => 'Over cap';

  @override
  String get categoriesExpenses => 'Expenses';

  @override
  String get categoriesIncome => 'Income';

  @override
  String get categoriesEmpty => 'No categories here yet.';

  @override
  String get categoryEditorNew => 'New category';

  @override
  String get categoryEditorEdit => 'Edit category';

  @override
  String get categoryEditorName => 'Category name';

  @override
  String get categoryEditorNameHint => 'e.g. Coffee';

  @override
  String get categoryEditorGlyph => 'Select glyph';

  @override
  String get categoryEditorColor => 'Accent palette';

  @override
  String get categoryEditorCap => 'Monthly budget cap';

  @override
  String get categoryEditorNoCap => 'No cap';

  @override
  String get categoryEditorCreate => 'Create category';

  @override
  String get categoryEditorSave => 'Save changes';

  @override
  String get categoryEditorNameRequired => 'Give it a name';

  @override
  String categoryDeleteTitle(String name) {
    return 'Delete “$name”?';
  }

  @override
  String get categoryDeleteBody =>
      'If transactions use it, it is archived instead so your history stays intact.';

  @override
  String get categoryDeleted => 'Category deleted';

  @override
  String get categoryArchived =>
      'Category archived — it is used by past transactions';

  @override
  String get settingsCategories => 'Categories';

  @override
  String get settingsCurrencies => 'Currencies & rates';

  @override
  String get currenciesTitle => 'Exchange rates';

  @override
  String ratesUpdatedAgo(String ago) {
    return 'Mid-market rates updated $ago';
  }

  @override
  String ratesOfflineAgo(String ago) {
    return 'Offline · using rates from $ago';
  }

  @override
  String get ratesNever =>
      'No rates yet. Connect to fetch them, or enter a rate when adding.';

  @override
  String get ratesRefreshing => 'Updating rates…';

  @override
  String get ratesRefresh => 'Refresh rates';

  @override
  String get timeJustNow => 'just now';

  @override
  String timeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count min ago',
      one: '1 min ago',
    );
    return '$_temp0';
  }

  @override
  String timeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String timeDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get currenciesPrimaryBase => 'Primary base';

  @override
  String get currenciesLocked => 'Locked';

  @override
  String get currenciesBaseNote =>
      'Base currency · all transactions and totals are converted here';

  @override
  String get currenciesChangeHint => 'Change it in Settings';

  @override
  String get currenciesTracking => 'Tracking currencies';

  @override
  String currenciesActive(int count) {
    return '$count active';
  }

  @override
  String currenciesBaseUnit(String code) {
    return 'Base: 1 $code';
  }

  @override
  String get currenciesPer100 => '/ 100';

  @override
  String get currenciesNoRate => 'No rate yet';

  @override
  String get currenciesAdd => 'Add new currency';

  @override
  String get currenciesOfflineTitle => 'Rates saved offline';

  @override
  String get currenciesOfflineBody =>
      'Rates are stored on this device for travel and refresh automatically when you are online.';

  @override
  String get currenciesEmpty =>
      'Add the currencies you spend in to see their rates here.';

  @override
  String get dashGreetingMorning => 'Good morning';

  @override
  String get dashGreetingAfternoon => 'Good afternoon';

  @override
  String get dashGreetingEvening => 'Good evening';

  @override
  String dashHomeCurrency(String code) {
    return '$code home';
  }

  @override
  String dashTotalSpent(String month) {
    return 'Total spent this month ($month)';
  }

  @override
  String dashDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days left',
      one: '1 day left',
      zero: 'Last day',
    );
    return '$_temp0';
  }

  @override
  String dashOfBudget(String spent, String budget, int percent) {
    return '$spent / $budget ($percent%)';
  }

  @override
  String dashRemaining(String amount) {
    return '$amount remaining';
  }

  @override
  String dashOverBudget(String amount) {
    return '$amount over budget';
  }

  @override
  String get dashNoBudget => 'No monthly budget set';

  @override
  String get dashSetBudget => 'Set a budget';

  @override
  String dashVsLastMonth(String change) {
    return '$change vs last month';
  }

  @override
  String get dashBudgetDetails => 'Budget details';

  @override
  String dashBudgetAlert(int percent) {
    return 'You have used $percent% of your monthly budget';
  }

  @override
  String get dashByCurrency => 'Original currencies spent';

  @override
  String dashShareOfTotal(int percent) {
    return '$percent% of total';
  }

  @override
  String get dashWeekPace => 'This week’s pace';

  @override
  String dashAvgPerDay(String amount) {
    return 'Avg $amount/day';
  }

  @override
  String get dashRecent => 'Recent activity';

  @override
  String get dashSeeAll => 'See all';

  @override
  String get dashEmptyTitle => 'Your month starts here';

  @override
  String get dashEmptyBody => 'Add your first expense with the + button.';

  @override
  String dashPaid(String amount) {
    return '$amount paid';
  }

  @override
  String get dashNotifications => 'Notifications';

  @override
  String get statsWeek => 'Week';

  @override
  String get statsMonth => 'Month';

  @override
  String get statsYear => 'Year';

  @override
  String get statsCustom => 'Custom';

  @override
  String get statsViewIn => 'View in';

  @override
  String statsTotalSpending(String period) {
    return 'Total spending · $period';
  }

  @override
  String statsVsPrevious(String amount) {
    return 'vs. $amount in the previous period';
  }

  @override
  String get statsCategoryDistribution => 'Category distribution';

  @override
  String get statsTapToInspect => 'Tap to inspect';

  @override
  String get statsPacing => 'Spending over time';

  @override
  String statsPacingSubtitle(String code) {
    return 'Per period, in $code';
  }

  @override
  String statsAvg(String amount) {
    return 'Avg $amount';
  }

  @override
  String statsPeak(String amount) {
    return 'Peak: $amount';
  }

  @override
  String get statsForeignShare => 'Foreign share';

  @override
  String statsForeignBody(String amount) {
    return '$amount spent in other currencies, converted at the rates you recorded.';
  }

  @override
  String get statsTopCategories => 'Top categories';

  @override
  String get statsEmptyTitle => 'No spending in this period';

  @override
  String get statsEmptyBody => 'Change the period or add a transaction.';

  @override
  String statsWeekLabel(int number) {
    return 'W$number';
  }

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsRegionalTheme => 'Regional & theme';

  @override
  String get settingsHomeCurrency => 'Home currency';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceBody => 'Theme styling & contrast';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get settingsBudgeting => 'Budgeting & automation';

  @override
  String get settingsMonthlyCap => 'Monthly spending cap';

  @override
  String get settingsNoCap => 'None';

  @override
  String get settingsBudgetAlert => 'Budget alert at 80%';

  @override
  String get settingsBudgetAlertBody => 'Show a heads-up on Home';

  @override
  String get settingsRatesBody => 'open.er-api.com · refreshed every 12 h';

  @override
  String get settingsCategoriesBody => 'Icons, colours and monthly caps';

  @override
  String get settingsDataSecurity => 'Data & security';

  @override
  String get settingsAppLock => 'Biometric lock';

  @override
  String get settingsAppLockBody => 'Require Face ID / fingerprint on launch';

  @override
  String get settingsAppLockUnavailable => 'Not available on this device';

  @override
  String get settingsExport => 'Export transactions';

  @override
  String get settingsExportBody => 'CSV file for any spreadsheet';

  @override
  String get settingsExportEmpty => 'Nothing to export yet';

  @override
  String get settingsReset => 'Reset all data';

  @override
  String get settingsResetBody =>
      'Deletes every transaction, category and setting';

  @override
  String get settingsResetConfirmTitle => 'Reset Flossi?';

  @override
  String get settingsResetConfirmBody =>
      'This permanently deletes all your data on this device. It can’t be undone.';

  @override
  String get settingsAbout => 'About Flossi';

  @override
  String get settingsVersion => 'App version';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyBody =>
      'No accounts, no trackers. Everything stays on this device.';

  @override
  String get settingsFooter =>
      'Crafted with precision · Casablanca & worldwide';

  @override
  String homeChangeTitle(String code) {
    return 'Switch home currency to $code?';
  }

  @override
  String homeChangeBody(String code) {
    return 'Totals and charts will be shown in $code. Past transactions keep the rate stored when they were recorded; amounts in other currencies are converted with the closest historical rate, or the latest one if none is cached.';
  }

  @override
  String get homeChangeConfirm => 'Switch';

  @override
  String homeChanged(String code) {
    return 'Home currency is now $code';
  }

  @override
  String get lockTitle => 'Flossi is locked';

  @override
  String get lockBody => 'Unlock to see your finances.';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get lockReason => 'Unlock Flossi';

  @override
  String get exportSubject => 'Flossi transactions';

  @override
  String get csvDate => 'Date';

  @override
  String get csvType => 'Type';

  @override
  String get csvTitle => 'Title';

  @override
  String get csvCategory => 'Category';

  @override
  String get csvAmount => 'Amount';

  @override
  String get csvCurrency => 'Currency';

  @override
  String get csvRate => 'Rate';

  @override
  String get csvHomeAmount => 'Home amount';

  @override
  String get csvHomeCurrency => 'Home currency';

  @override
  String get csvPayment => 'Payment';

  @override
  String get csvNote => 'Note';

  @override
  String get categoryDining => 'Dining';

  @override
  String get categoryGroceries => 'Groceries';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBills => 'Bills & Utilities';

  @override
  String get categorySubscriptions => 'Subscriptions';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryHousing => 'Housing';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryOther => 'Other';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryGift => 'Gifts';

  @override
  String get categoryOtherIncome => 'Other income';

  @override
  String get galleryTitle => 'Design system';

  @override
  String get gallerySampleAmount => 'Total spent this month';

  @override
  String get gallerySampleButton => 'Save Expense';

  @override
  String get gallerySampleSecondary => 'Reset';

  @override
  String get gallerySegmentWeek => 'Week';

  @override
  String get gallerySegmentMonth => 'Month';

  @override
  String get gallerySegmentYear => 'Year';
}
