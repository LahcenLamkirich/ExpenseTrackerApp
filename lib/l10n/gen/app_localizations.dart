import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// App name shown in the header and task switcher.
  ///
  /// In en, this message translates to:
  /// **'Flossi'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navStats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get navStats;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Accessibility label of the centre + button.
  ///
  /// In en, this message translates to:
  /// **'Add transaction'**
  String get navAdd;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @commonBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get commonApply;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonMore.
  ///
  /// In en, this message translates to:
  /// **'More options'**
  String get commonMore;

  /// No description provided for @commonReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get commonRetry;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorBody.
  ///
  /// In en, this message translates to:
  /// **'Your data is safe. Please try again.'**
  String get errorBody;

  /// No description provided for @screenComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get screenComingSoon;

  /// No description provided for @screenComingSoonBody.
  ///
  /// In en, this message translates to:
  /// **'This screen is being built in an upcoming phase.'**
  String get screenComingSoonBody;

  /// No description provided for @onboardingStep.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String onboardingStep(int current, int total);

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingLiveRates.
  ///
  /// In en, this message translates to:
  /// **'Live rates'**
  String get onboardingLiveRates;

  /// No description provided for @onboardingHomeBalance.
  ///
  /// In en, this message translates to:
  /// **'Home balance'**
  String get onboardingHomeBalance;

  /// No description provided for @onboardingConsolidated.
  ///
  /// In en, this message translates to:
  /// **'Everything in one currency'**
  String get onboardingConsolidated;

  /// No description provided for @onboardingSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get onboardingSynced;

  /// No description provided for @onboardingRateNote.
  ///
  /// In en, this message translates to:
  /// **'Converted at the day’s rate'**
  String get onboardingRateNote;

  /// No description provided for @onboardingHeadline.
  ///
  /// In en, this message translates to:
  /// **'Money without borders. Tracked with elegance.'**
  String get onboardingHeadline;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Flossi converts Moroccan Dirham, Euro, US Dollar and 60+ currencies into your single home currency.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingFeatureRates.
  ///
  /// In en, this message translates to:
  /// **'Daily exchange rates'**
  String get onboardingFeatureRates;

  /// No description provided for @onboardingFeatureTracking.
  ///
  /// In en, this message translates to:
  /// **'Zero-clutter tracking'**
  String get onboardingFeatureTracking;

  /// No description provided for @onboardingFeaturePrivate.
  ///
  /// In en, this message translates to:
  /// **'Private & offline-first'**
  String get onboardingFeaturePrivate;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingFootnote.
  ///
  /// In en, this message translates to:
  /// **'No account needed. Your data stays on this device.'**
  String get onboardingFootnote;

  /// No description provided for @currencyStepTag.
  ///
  /// In en, this message translates to:
  /// **'Primary ledger'**
  String get currencyStepTag;

  /// No description provided for @currencyStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your home currency'**
  String get currencyStepTitle;

  /// No description provided for @currencyStepBody.
  ///
  /// In en, this message translates to:
  /// **'All expenses are converted into this currency for your balances and charts. You can change it anytime.'**
  String get currencyStepBody;

  /// No description provided for @currencySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search currency or country…'**
  String get currencySearchHint;

  /// No description provided for @currencyPinned.
  ///
  /// In en, this message translates to:
  /// **'Pinned'**
  String get currencyPinned;

  /// No description provided for @currencyAll.
  ///
  /// In en, this message translates to:
  /// **'All currencies'**
  String get currencyAll;

  /// No description provided for @currencyCount.
  ///
  /// In en, this message translates to:
  /// **'{count} available'**
  String currencyCount(int count);

  /// No description provided for @currencyPrimaryBadge.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get currencyPrimaryBadge;

  /// No description provided for @currencyConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm home currency ({code})'**
  String currencyConfirm(String code);

  /// No description provided for @currencyNoResults.
  ///
  /// In en, this message translates to:
  /// **'No currency matches “{query}”'**
  String currencyNoResults(String query);

  /// No description provided for @pickCurrencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose currency'**
  String get pickCurrencyTitle;

  /// No description provided for @budgetStepTag.
  ///
  /// In en, this message translates to:
  /// **'Mindful pacing'**
  String get budgetStepTag;

  /// No description provided for @budgetStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your monthly spending target'**
  String get budgetStepTitle;

  /// No description provided for @budgetStepBody.
  ///
  /// In en, this message translates to:
  /// **'Flossi keeps you mindful with gentle alerts as you approach your limit in your home currency.'**
  String get budgetStepBody;

  /// No description provided for @budgetMonthlyCap.
  ///
  /// In en, this message translates to:
  /// **'Monthly cap'**
  String get budgetMonthlyCap;

  /// No description provided for @budgetQuickAdjust.
  ///
  /// In en, this message translates to:
  /// **'Quick adjust'**
  String get budgetQuickAdjust;

  /// No description provided for @budgetNone.
  ///
  /// In en, this message translates to:
  /// **'No budget'**
  String get budgetNone;

  /// No description provided for @budgetNoneHint.
  ///
  /// In en, this message translates to:
  /// **'Track freely without a monthly limit.'**
  String get budgetNoneHint;

  /// No description provided for @budgetDailyPace.
  ///
  /// In en, this message translates to:
  /// **'Daily safe pace'**
  String get budgetDailyPace;

  /// No description provided for @budgetPerDay.
  ///
  /// In en, this message translates to:
  /// **'≈ {amount} / day'**
  String budgetPerDay(String amount);

  /// No description provided for @budgetDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String budgetDays(int count);

  /// No description provided for @budgetNotifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Notify me at 80% spent'**
  String get budgetNotifyTitle;

  /// No description provided for @budgetNotifyBody.
  ///
  /// In en, this message translates to:
  /// **'A gentle nudge before you overspend'**
  String get budgetNotifyBody;

  /// No description provided for @budgetAllocation.
  ///
  /// In en, this message translates to:
  /// **'Suggested allocation'**
  String get budgetAllocation;

  /// No description provided for @budgetRule.
  ///
  /// In en, this message translates to:
  /// **'50 / 30 / 20 rule'**
  String get budgetRule;

  /// No description provided for @budgetNeeds.
  ///
  /// In en, this message translates to:
  /// **'Needs'**
  String get budgetNeeds;

  /// No description provided for @budgetWants.
  ///
  /// In en, this message translates to:
  /// **'Wants'**
  String get budgetWants;

  /// No description provided for @budgetSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get budgetSavings;

  /// No description provided for @budgetComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete setup & enter Flossi'**
  String get budgetComplete;

  /// No description provided for @budgetSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get budgetSkip;

  /// No description provided for @budgetAdjustLater.
  ///
  /// In en, this message translates to:
  /// **'You can adjust this anytime in Settings'**
  String get budgetAdjustLater;

  /// No description provided for @budgetEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly budget'**
  String get budgetEditTitle;

  /// No description provided for @budgetTapToEdit.
  ///
  /// In en, this message translates to:
  /// **'Tap the amount to type it'**
  String get budgetTapToEdit;

  /// No description provided for @txAddExpense.
  ///
  /// In en, this message translates to:
  /// **'Add expense'**
  String get txAddExpense;

  /// No description provided for @txAddIncome.
  ///
  /// In en, this message translates to:
  /// **'Add income'**
  String get txAddIncome;

  /// No description provided for @txEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit transaction'**
  String get txEdit;

  /// No description provided for @txOutflow.
  ///
  /// In en, this message translates to:
  /// **'Outflow'**
  String get txOutflow;

  /// No description provided for @txInflow.
  ///
  /// In en, this message translates to:
  /// **'Inflow'**
  String get txInflow;

  /// No description provided for @txDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get txDate;

  /// No description provided for @txToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get txToday;

  /// No description provided for @txYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get txYesterday;

  /// No description provided for @txPaymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get txPaymentCard;

  /// No description provided for @txPaymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get txPaymentCash;

  /// No description provided for @txPaymentTransfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get txPaymentTransfer;

  /// No description provided for @txPaymentOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get txPaymentOther;

  /// No description provided for @txTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Merchant or title'**
  String get txTitleHint;

  /// No description provided for @txNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add a note'**
  String get txNoteHint;

  /// No description provided for @txCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get txCategory;

  /// No description provided for @txSaveExpense.
  ///
  /// In en, this message translates to:
  /// **'Save expense'**
  String get txSaveExpense;

  /// No description provided for @txSaveIncome.
  ///
  /// In en, this message translates to:
  /// **'Save income'**
  String get txSaveIncome;

  /// No description provided for @txSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get txSaveChanges;

  /// No description provided for @txRateMissing.
  ///
  /// In en, this message translates to:
  /// **'No rate yet · tap to enter'**
  String get txRateMissing;

  /// No description provided for @txRateManual.
  ///
  /// In en, this message translates to:
  /// **'manual'**
  String get txRateManual;

  /// No description provided for @txMoreCurrencies.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get txMoreCurrencies;

  /// No description provided for @txDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete transaction'**
  String get txDelete;

  /// No description provided for @txDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this transaction?'**
  String get txDeleteConfirm;

  /// No description provided for @txSaved.
  ///
  /// In en, this message translates to:
  /// **'Transaction saved'**
  String get txSaved;

  /// No description provided for @txDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted'**
  String get txDeleted;

  /// No description provided for @txKeypadBackspace.
  ///
  /// In en, this message translates to:
  /// **'Delete last digit'**
  String get txKeypadBackspace;

  /// No description provided for @txKeypadDecimal.
  ///
  /// In en, this message translates to:
  /// **'Decimal separator'**
  String get txKeypadDecimal;

  /// No description provided for @txConvertedWith.
  ///
  /// In en, this message translates to:
  /// **'Converted at 1 {from} = {rate} {to}'**
  String txConvertedWith(String from, String rate, String to);

  /// No description provided for @rateSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter exchange rate'**
  String get rateSheetTitle;

  /// No description provided for @rateSheetBody.
  ///
  /// In en, this message translates to:
  /// **'No cached rate for {from} → {to} yet. Enter today’s rate; it is saved for offline use.'**
  String rateSheetBody(String from, String to);

  /// No description provided for @rateSheetInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a rate greater than 0'**
  String get rateSheetInvalid;

  /// No description provided for @historySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search transactions, notes…'**
  String get historySearchHint;

  /// No description provided for @historyDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get historyDirect;

  /// No description provided for @historyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction} other{{count} transactions}}'**
  String historyCount(int count);

  /// No description provided for @historyTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get historyTotal;

  /// No description provided for @historyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tap + to record your first expense.'**
  String get historyEmptyBody;

  /// No description provided for @historyNoMatchesTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches'**
  String get historyNoMatchesTitle;

  /// No description provided for @historyNoMatchesBody.
  ///
  /// In en, this message translates to:
  /// **'Try another search or clear the filters.'**
  String get historyNoMatchesBody;

  /// No description provided for @historyUnresolved.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transaction needs a rate} other{{count} transactions need a rate}}'**
  String historyUnresolved(int count);

  /// No description provided for @filterThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get filterThisMonth;

  /// No description provided for @filterAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get filterAllTime;

  /// No description provided for @filterDateRange.
  ///
  /// In en, this message translates to:
  /// **'Date range'**
  String get filterDateRange;

  /// No description provided for @filterCategories.
  ///
  /// In en, this message translates to:
  /// **'All categories'**
  String get filterCategories;

  /// No description provided for @filterCategoriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 category} other{{count} categories}}'**
  String filterCategoriesCount(int count);

  /// No description provided for @filterCurrencies.
  ///
  /// In en, this message translates to:
  /// **'All currencies'**
  String get filterCurrencies;

  /// No description provided for @filterCurrenciesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 currency} other{{count} currencies}}'**
  String filterCurrenciesCount(int count);

  /// No description provided for @filterAllTypes.
  ///
  /// In en, this message translates to:
  /// **'All types'**
  String get filterAllTypes;

  /// No description provided for @filterExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get filterExpenses;

  /// No description provided for @filterIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get filterIncome;

  /// No description provided for @filterClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get filterClearAll;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @categoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage & customize your spending'**
  String get categoriesSubtitle;

  /// No description provided for @categoriesNew.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get categoriesNew;

  /// No description provided for @categoriesCapsSummary.
  ///
  /// In en, this message translates to:
  /// **'Active monthly caps'**
  String get categoriesCapsSummary;

  /// No description provided for @categoriesCapUsed.
  ///
  /// In en, this message translates to:
  /// **'{percent}% used'**
  String categoriesCapUsed(int percent);

  /// No description provided for @categoriesOfCap.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of monthly cap'**
  String categoriesOfCap(int percent);

  /// No description provided for @categoriesSpent.
  ///
  /// In en, this message translates to:
  /// **'{amount} spent'**
  String categoriesSpent(String amount);

  /// No description provided for @categoriesReceived.
  ///
  /// In en, this message translates to:
  /// **'{amount} received'**
  String categoriesReceived(String amount);

  /// No description provided for @categoriesCap.
  ///
  /// In en, this message translates to:
  /// **'Cap: {amount}'**
  String categoriesCap(String amount);

  /// No description provided for @categoriesNoCap.
  ///
  /// In en, this message translates to:
  /// **'No monthly cap'**
  String get categoriesNoCap;

  /// No description provided for @categoriesNearCap.
  ///
  /// In en, this message translates to:
  /// **'Near cap'**
  String get categoriesNearCap;

  /// No description provided for @categoriesCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get categoriesCritical;

  /// No description provided for @categoriesOverCap.
  ///
  /// In en, this message translates to:
  /// **'Over cap'**
  String get categoriesOverCap;

  /// No description provided for @categoriesExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get categoriesExpenses;

  /// No description provided for @categoriesIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get categoriesIncome;

  /// No description provided for @categoriesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No categories here yet.'**
  String get categoriesEmpty;

  /// No description provided for @categoryEditorNew.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get categoryEditorNew;

  /// No description provided for @categoryEditorEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit category'**
  String get categoryEditorEdit;

  /// No description provided for @categoryEditorName.
  ///
  /// In en, this message translates to:
  /// **'Category name'**
  String get categoryEditorName;

  /// No description provided for @categoryEditorNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Coffee'**
  String get categoryEditorNameHint;

  /// No description provided for @categoryEditorGlyph.
  ///
  /// In en, this message translates to:
  /// **'Select glyph'**
  String get categoryEditorGlyph;

  /// No description provided for @categoryEditorColor.
  ///
  /// In en, this message translates to:
  /// **'Accent palette'**
  String get categoryEditorColor;

  /// No description provided for @categoryEditorCap.
  ///
  /// In en, this message translates to:
  /// **'Monthly budget cap'**
  String get categoryEditorCap;

  /// No description provided for @categoryEditorNoCap.
  ///
  /// In en, this message translates to:
  /// **'No cap'**
  String get categoryEditorNoCap;

  /// No description provided for @categoryEditorCreate.
  ///
  /// In en, this message translates to:
  /// **'Create category'**
  String get categoryEditorCreate;

  /// No description provided for @categoryEditorSave.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get categoryEditorSave;

  /// No description provided for @categoryEditorNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Give it a name'**
  String get categoryEditorNameRequired;

  /// No description provided for @categoryDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete “{name}”?'**
  String categoryDeleteTitle(String name);

  /// No description provided for @categoryDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'If transactions use it, it is archived instead so your history stays intact.'**
  String get categoryDeleteBody;

  /// No description provided for @categoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Category deleted'**
  String get categoryDeleted;

  /// No description provided for @categoryArchived.
  ///
  /// In en, this message translates to:
  /// **'Category archived — it is used by past transactions'**
  String get categoryArchived;

  /// No description provided for @settingsCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get settingsCategories;

  /// No description provided for @settingsCurrencies.
  ///
  /// In en, this message translates to:
  /// **'Currencies & rates'**
  String get settingsCurrencies;

  /// No description provided for @currenciesTitle.
  ///
  /// In en, this message translates to:
  /// **'Exchange rates'**
  String get currenciesTitle;

  /// No description provided for @ratesUpdatedAgo.
  ///
  /// In en, this message translates to:
  /// **'Mid-market rates updated {ago}'**
  String ratesUpdatedAgo(String ago);

  /// No description provided for @ratesOfflineAgo.
  ///
  /// In en, this message translates to:
  /// **'Offline · using rates from {ago}'**
  String ratesOfflineAgo(String ago);

  /// No description provided for @ratesNever.
  ///
  /// In en, this message translates to:
  /// **'No rates yet. Connect to fetch them, or enter a rate when adding.'**
  String get ratesNever;

  /// No description provided for @ratesRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Updating rates…'**
  String get ratesRefreshing;

  /// No description provided for @ratesRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh rates'**
  String get ratesRefresh;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 min ago} other{{count} min ago}}'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String timeDaysAgo(int count);

  /// No description provided for @currenciesPrimaryBase.
  ///
  /// In en, this message translates to:
  /// **'Primary base'**
  String get currenciesPrimaryBase;

  /// No description provided for @currenciesLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get currenciesLocked;

  /// No description provided for @currenciesBaseNote.
  ///
  /// In en, this message translates to:
  /// **'Base currency · all transactions and totals are converted here'**
  String get currenciesBaseNote;

  /// No description provided for @currenciesChangeHint.
  ///
  /// In en, this message translates to:
  /// **'Change it in Settings'**
  String get currenciesChangeHint;

  /// No description provided for @currenciesTracking.
  ///
  /// In en, this message translates to:
  /// **'Tracking currencies'**
  String get currenciesTracking;

  /// No description provided for @currenciesActive.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String currenciesActive(int count);

  /// No description provided for @currenciesBaseUnit.
  ///
  /// In en, this message translates to:
  /// **'Base: 1 {code}'**
  String currenciesBaseUnit(String code);

  /// No description provided for @currenciesPer100.
  ///
  /// In en, this message translates to:
  /// **'/ 100'**
  String get currenciesPer100;

  /// No description provided for @currenciesNoRate.
  ///
  /// In en, this message translates to:
  /// **'No rate yet'**
  String get currenciesNoRate;

  /// No description provided for @currenciesAdd.
  ///
  /// In en, this message translates to:
  /// **'Add new currency'**
  String get currenciesAdd;

  /// No description provided for @currenciesOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Rates saved offline'**
  String get currenciesOfflineTitle;

  /// No description provided for @currenciesOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Rates are stored on this device for travel and refresh automatically when you are online.'**
  String get currenciesOfflineBody;

  /// No description provided for @currenciesEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add the currencies you spend in to see their rates here.'**
  String get currenciesEmpty;

  /// No description provided for @dashGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get dashGreetingMorning;

  /// No description provided for @dashGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get dashGreetingAfternoon;

  /// No description provided for @dashGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get dashGreetingEvening;

  /// No description provided for @dashHomeCurrency.
  ///
  /// In en, this message translates to:
  /// **'{code} home'**
  String dashHomeCurrency(String code);

  /// No description provided for @dashTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total spent this month ({month})'**
  String dashTotalSpent(String month);

  /// No description provided for @dashDaysLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Last day} =1{1 day left} other{{count} days left}}'**
  String dashDaysLeft(int count);

  /// No description provided for @dashOfBudget.
  ///
  /// In en, this message translates to:
  /// **'{spent} / {budget} ({percent}%)'**
  String dashOfBudget(String spent, String budget, int percent);

  /// No description provided for @dashRemaining.
  ///
  /// In en, this message translates to:
  /// **'{amount} remaining'**
  String dashRemaining(String amount);

  /// No description provided for @dashOverBudget.
  ///
  /// In en, this message translates to:
  /// **'{amount} over budget'**
  String dashOverBudget(String amount);

  /// No description provided for @dashNoBudget.
  ///
  /// In en, this message translates to:
  /// **'No monthly budget set'**
  String get dashNoBudget;

  /// No description provided for @dashSetBudget.
  ///
  /// In en, this message translates to:
  /// **'Set a budget'**
  String get dashSetBudget;

  /// No description provided for @dashVsLastMonth.
  ///
  /// In en, this message translates to:
  /// **'{change} vs last month'**
  String dashVsLastMonth(String change);

  /// No description provided for @dashBudgetDetails.
  ///
  /// In en, this message translates to:
  /// **'Budget details'**
  String get dashBudgetDetails;

  /// No description provided for @dashBudgetAlert.
  ///
  /// In en, this message translates to:
  /// **'You have used {percent}% of your monthly budget'**
  String dashBudgetAlert(int percent);

  /// No description provided for @dashByCurrency.
  ///
  /// In en, this message translates to:
  /// **'Original currencies spent'**
  String get dashByCurrency;

  /// No description provided for @dashShareOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of total'**
  String dashShareOfTotal(int percent);

  /// No description provided for @dashWeekPace.
  ///
  /// In en, this message translates to:
  /// **'This week’s pace'**
  String get dashWeekPace;

  /// No description provided for @dashAvgPerDay.
  ///
  /// In en, this message translates to:
  /// **'Avg {amount}/day'**
  String dashAvgPerDay(String amount);

  /// No description provided for @dashRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get dashRecent;

  /// No description provided for @dashSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get dashSeeAll;

  /// No description provided for @dashEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your month starts here'**
  String get dashEmptyTitle;

  /// No description provided for @dashEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first expense with the + button.'**
  String get dashEmptyBody;

  /// No description provided for @dashPaid.
  ///
  /// In en, this message translates to:
  /// **'{amount} paid'**
  String dashPaid(String amount);

  /// No description provided for @dashNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get dashNotifications;

  /// No description provided for @statsWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get statsWeek;

  /// No description provided for @statsMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get statsMonth;

  /// No description provided for @statsYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get statsYear;

  /// No description provided for @statsCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get statsCustom;

  /// No description provided for @statsViewIn.
  ///
  /// In en, this message translates to:
  /// **'View in'**
  String get statsViewIn;

  /// No description provided for @statsTotalSpending.
  ///
  /// In en, this message translates to:
  /// **'Total spending · {period}'**
  String statsTotalSpending(String period);

  /// No description provided for @statsVsPrevious.
  ///
  /// In en, this message translates to:
  /// **'vs. {amount} in the previous period'**
  String statsVsPrevious(String amount);

  /// No description provided for @statsCategoryDistribution.
  ///
  /// In en, this message translates to:
  /// **'Category distribution'**
  String get statsCategoryDistribution;

  /// No description provided for @statsTapToInspect.
  ///
  /// In en, this message translates to:
  /// **'Tap to inspect'**
  String get statsTapToInspect;

  /// No description provided for @statsPacing.
  ///
  /// In en, this message translates to:
  /// **'Spending over time'**
  String get statsPacing;

  /// No description provided for @statsPacingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Per period, in {code}'**
  String statsPacingSubtitle(String code);

  /// No description provided for @statsAvg.
  ///
  /// In en, this message translates to:
  /// **'Avg {amount}'**
  String statsAvg(String amount);

  /// No description provided for @statsPeak.
  ///
  /// In en, this message translates to:
  /// **'Peak: {amount}'**
  String statsPeak(String amount);

  /// No description provided for @statsForeignShare.
  ///
  /// In en, this message translates to:
  /// **'Foreign share'**
  String get statsForeignShare;

  /// No description provided for @statsForeignBody.
  ///
  /// In en, this message translates to:
  /// **'{amount} spent in other currencies, converted at the rates you recorded.'**
  String statsForeignBody(String amount);

  /// No description provided for @statsTopCategories.
  ///
  /// In en, this message translates to:
  /// **'Top categories'**
  String get statsTopCategories;

  /// No description provided for @statsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No spending in this period'**
  String get statsEmptyTitle;

  /// No description provided for @statsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Change the period or add a transaction.'**
  String get statsEmptyBody;

  /// No description provided for @statsWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'W{number}'**
  String statsWeekLabel(int number);

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsRegionalTheme.
  ///
  /// In en, this message translates to:
  /// **'Regional & theme'**
  String get settingsRegionalTheme;

  /// No description provided for @settingsHomeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Home currency'**
  String get settingsHomeCurrency;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsAppearanceBody.
  ///
  /// In en, this message translates to:
  /// **'Theme styling & contrast'**
  String get settingsAppearanceBody;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @settingsBudgeting.
  ///
  /// In en, this message translates to:
  /// **'Budgeting & automation'**
  String get settingsBudgeting;

  /// No description provided for @settingsMonthlyCap.
  ///
  /// In en, this message translates to:
  /// **'Monthly spending cap'**
  String get settingsMonthlyCap;

  /// No description provided for @settingsNoCap.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get settingsNoCap;

  /// No description provided for @settingsBudgetAlert.
  ///
  /// In en, this message translates to:
  /// **'Budget alert at 80%'**
  String get settingsBudgetAlert;

  /// No description provided for @settingsBudgetAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Show a heads-up on Home'**
  String get settingsBudgetAlertBody;

  /// No description provided for @settingsRatesBody.
  ///
  /// In en, this message translates to:
  /// **'open.er-api.com · refreshed every 12 h'**
  String get settingsRatesBody;

  /// No description provided for @settingsCategoriesBody.
  ///
  /// In en, this message translates to:
  /// **'Icons, colours and monthly caps'**
  String get settingsCategoriesBody;

  /// No description provided for @settingsDataSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data & security'**
  String get settingsDataSecurity;

  /// No description provided for @settingsAppLock.
  ///
  /// In en, this message translates to:
  /// **'Biometric lock'**
  String get settingsAppLock;

  /// No description provided for @settingsAppLockBody.
  ///
  /// In en, this message translates to:
  /// **'Require Face ID / fingerprint on launch'**
  String get settingsAppLockBody;

  /// No description provided for @settingsAppLockUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Not available on this device'**
  String get settingsAppLockUnavailable;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export transactions'**
  String get settingsExport;

  /// No description provided for @settingsExportBody.
  ///
  /// In en, this message translates to:
  /// **'CSV file for any spreadsheet'**
  String get settingsExportBody;

  /// No description provided for @settingsExportEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing to export yet'**
  String get settingsExportEmpty;

  /// No description provided for @settingsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset all data'**
  String get settingsReset;

  /// No description provided for @settingsResetBody.
  ///
  /// In en, this message translates to:
  /// **'Deletes every transaction, category and setting'**
  String get settingsResetBody;

  /// No description provided for @settingsResetConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Flossi?'**
  String get settingsResetConfirmTitle;

  /// No description provided for @settingsResetConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes all your data on this device. It can’t be undone.'**
  String get settingsResetConfirmBody;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About Flossi'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'App version'**
  String get settingsVersion;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'No accounts, no trackers. Everything stays on this device.'**
  String get settingsPrivacyBody;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Crafted with precision · Casablanca & worldwide'**
  String get settingsFooter;

  /// No description provided for @homeChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Switch home currency to {code}?'**
  String homeChangeTitle(String code);

  /// No description provided for @homeChangeBody.
  ///
  /// In en, this message translates to:
  /// **'Totals and charts will be shown in {code}. Past transactions keep the rate stored when they were recorded; amounts in other currencies are converted with the closest historical rate, or the latest one if none is cached.'**
  String homeChangeBody(String code);

  /// No description provided for @homeChangeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get homeChangeConfirm;

  /// No description provided for @homeChanged.
  ///
  /// In en, this message translates to:
  /// **'Home currency is now {code}'**
  String homeChanged(String code);

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'Flossi is locked'**
  String get lockTitle;

  /// No description provided for @lockBody.
  ///
  /// In en, this message translates to:
  /// **'Unlock to see your finances.'**
  String get lockBody;

  /// No description provided for @lockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockUnlock;

  /// No description provided for @lockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Flossi'**
  String get lockReason;

  /// No description provided for @exportSubject.
  ///
  /// In en, this message translates to:
  /// **'Flossi transactions'**
  String get exportSubject;

  /// No description provided for @csvDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get csvDate;

  /// No description provided for @csvType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get csvType;

  /// No description provided for @csvTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get csvTitle;

  /// No description provided for @csvCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get csvCategory;

  /// No description provided for @csvAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get csvAmount;

  /// No description provided for @csvCurrency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get csvCurrency;

  /// No description provided for @csvRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get csvRate;

  /// No description provided for @csvHomeAmount.
  ///
  /// In en, this message translates to:
  /// **'Home amount'**
  String get csvHomeAmount;

  /// No description provided for @csvHomeCurrency.
  ///
  /// In en, this message translates to:
  /// **'Home currency'**
  String get csvHomeCurrency;

  /// No description provided for @csvPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get csvPayment;

  /// No description provided for @csvNote.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get csvNote;

  /// No description provided for @categoryDining.
  ///
  /// In en, this message translates to:
  /// **'Dining'**
  String get categoryDining;

  /// No description provided for @categoryGroceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get categoryGroceries;

  /// No description provided for @categoryTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get categoryTransport;

  /// No description provided for @categoryTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryBills.
  ///
  /// In en, this message translates to:
  /// **'Bills & Utilities'**
  String get categoryBills;

  /// No description provided for @categorySubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get categorySubscriptions;

  /// No description provided for @categoryHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get categoryHealth;

  /// No description provided for @categoryEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get categoryEntertainment;

  /// No description provided for @categoryHousing.
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get categoryHousing;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @categorySalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get categorySalary;

  /// No description provided for @categoryFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get categoryFreelance;

  /// No description provided for @categoryGift.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get categoryGift;

  /// No description provided for @categoryOtherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other income'**
  String get categoryOtherIncome;

  /// No description provided for @galleryTitle.
  ///
  /// In en, this message translates to:
  /// **'Design system'**
  String get galleryTitle;

  /// No description provided for @gallerySampleAmount.
  ///
  /// In en, this message translates to:
  /// **'Total spent this month'**
  String get gallerySampleAmount;

  /// No description provided for @gallerySampleButton.
  ///
  /// In en, this message translates to:
  /// **'Save Expense'**
  String get gallerySampleButton;

  /// No description provided for @gallerySampleSecondary.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get gallerySampleSecondary;

  /// No description provided for @gallerySegmentWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get gallerySegmentWeek;

  /// No description provided for @gallerySegmentMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get gallerySegmentMonth;

  /// No description provided for @gallerySegmentYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get gallerySegmentYear;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
