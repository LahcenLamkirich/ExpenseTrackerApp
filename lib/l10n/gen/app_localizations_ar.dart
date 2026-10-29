// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'فلوسي';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navHistory => 'السجل';

  @override
  String get navStats => 'الإحصائيات';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navAdd => 'إضافة معاملة';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonEdit => 'تعديل';

  @override
  String get commonUndo => 'تراجع';

  @override
  String get commonBack => 'رجوع';

  @override
  String get commonClear => 'مسح';

  @override
  String get commonApply => 'تطبيق';

  @override
  String get commonDone => 'تم';

  @override
  String get commonMore => 'خيارات أخرى';

  @override
  String get commonReset => 'إعادة تعيين';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get errorTitle => 'حدث خطأ ما';

  @override
  String get errorBody => 'بياناتك في أمان. يرجى المحاولة مرة أخرى.';

  @override
  String get screenComingSoon => 'قريبًا';

  @override
  String get screenComingSoonBody => 'سيتم بناء هذه الشاشة في مرحلة قادمة.';

  @override
  String onboardingStep(int current, int total) {
    return 'الخطوة $current من $total';
  }

  @override
  String get onboardingSkip => 'تخطٍّ';

  @override
  String get onboardingLiveRates => 'سعر اليوم';

  @override
  String get onboardingHomeBalance => 'الرصيد الرئيسي';

  @override
  String get onboardingConsolidated => 'كل شيء بعملة واحدة';

  @override
  String get onboardingSynced => 'متزامن';

  @override
  String get onboardingRateNote => 'محوَّل بسعر اليوم';

  @override
  String get onboardingHeadline => 'مال بلا حدود. يُتابَع بأناقة.';

  @override
  String get onboardingSubtitle =>
      'يحوّل فلوسي الدرهم المغربي واليورو والدولار الأمريكي وأكثر من 60 عملة إلى عملتك الرئيسية.';

  @override
  String get onboardingFeatureRates => 'أسعار صرف يومية';

  @override
  String get onboardingFeatureTracking => 'تتبّع بلا فوضى';

  @override
  String get onboardingFeaturePrivate => 'خاص ويعمل دون اتصال';

  @override
  String get onboardingGetStarted => 'ابدأ الآن';

  @override
  String get onboardingFootnote =>
      'لا حاجة لحساب. بياناتك تبقى على هذا الجهاز.';

  @override
  String get currencyStepTag => 'السجل الرئيسي';

  @override
  String get currencyStepTitle => 'اختر عملتك الرئيسية';

  @override
  String get currencyStepBody =>
      'تُحوَّل كل المصاريف إلى هذه العملة في الأرصدة والرسوم البيانية. يمكنك تغييرها في أي وقت.';

  @override
  String get currencySearchHint => 'ابحث عن عملة أو بلد…';

  @override
  String get currencyPinned => 'مثبّتة';

  @override
  String get currencyAll => 'كل العملات';

  @override
  String currencyCount(int count) {
    return '$count متاحة';
  }

  @override
  String get currencyPrimaryBadge => 'رئيسية';

  @override
  String currencyConfirm(String code) {
    return 'تأكيد العملة الرئيسية ($code)';
  }

  @override
  String currencyNoResults(String query) {
    return 'لا توجد عملة تطابق «$query»';
  }

  @override
  String get pickCurrencyTitle => 'اختر العملة';

  @override
  String get budgetStepTag => 'إنفاق واعٍ';

  @override
  String get budgetStepTitle => 'حدّد هدف إنفاقك الشهري';

  @override
  String get budgetStepBody =>
      'ينبّهك فلوسي بلطف عند اقترابك من حدّك بعملتك الرئيسية.';

  @override
  String get budgetMonthlyCap => 'الحد الشهري';

  @override
  String get budgetQuickAdjust => 'تعديل سريع';

  @override
  String get budgetNone => 'بدون ميزانية';

  @override
  String get budgetNoneHint => 'تتبّع بحرية دون حد شهري.';

  @override
  String get budgetDailyPace => 'الإنفاق اليومي الآمن';

  @override
  String budgetPerDay(String amount) {
    return '≈ $amount / يوم';
  }

  @override
  String budgetDays(int count) {
    return '$count يومًا';
  }

  @override
  String get budgetNotifyTitle => 'نبّهني عند إنفاق 80٪';

  @override
  String get budgetNotifyBody => 'تذكير لطيف قبل تجاوز الحد';

  @override
  String get budgetAllocation => 'التوزيع المقترح';

  @override
  String get budgetRule => 'قاعدة 50 / 30 / 20';

  @override
  String get budgetNeeds => 'الاحتياجات';

  @override
  String get budgetWants => 'الرغبات';

  @override
  String get budgetSavings => 'الادخار';

  @override
  String get budgetComplete => 'إنهاء الإعداد والدخول إلى فلوسي';

  @override
  String get budgetSkip => 'لاحقًا';

  @override
  String get budgetAdjustLater => 'يمكنك تعديل ذلك في أي وقت من الإعدادات';

  @override
  String get budgetEditTitle => 'الميزانية الشهرية';

  @override
  String get budgetTapToEdit => 'اضغط على المبلغ لكتابته';

  @override
  String get txAddExpense => 'إضافة مصروف';

  @override
  String get txAddIncome => 'إضافة دخل';

  @override
  String get txEdit => 'تعديل المعاملة';

  @override
  String get txOutflow => 'صادر';

  @override
  String get txInflow => 'وارد';

  @override
  String get txDate => 'التاريخ';

  @override
  String get txToday => 'اليوم';

  @override
  String get txYesterday => 'أمس';

  @override
  String get txPaymentCard => 'بطاقة';

  @override
  String get txPaymentCash => 'نقدًا';

  @override
  String get txPaymentTransfer => 'تحويل';

  @override
  String get txPaymentOther => 'أخرى';

  @override
  String get txTitleHint => 'التاجر أو العنوان';

  @override
  String get txNoteHint => 'أضف ملاحظة';

  @override
  String get txCategory => 'الفئة';

  @override
  String get txSaveExpense => 'حفظ المصروف';

  @override
  String get txSaveIncome => 'حفظ الدخل';

  @override
  String get txSaveChanges => 'حفظ التغييرات';

  @override
  String get txRateMissing => 'لا يوجد سعر · اضغط للإدخال';

  @override
  String get txRateManual => 'يدوي';

  @override
  String get txMoreCurrencies => 'المزيد';

  @override
  String get txDelete => 'حذف المعاملة';

  @override
  String get txDeleteConfirm => 'حذف هذه المعاملة؟';

  @override
  String get txSaved => 'تم حفظ المعاملة';

  @override
  String get txDeleted => 'تم حذف المعاملة';

  @override
  String get txKeypadBackspace => 'حذف آخر رقم';

  @override
  String get txKeypadDecimal => 'الفاصلة العشرية';

  @override
  String txConvertedWith(String from, String rate, String to) {
    return 'محوَّل بسعر 1 $from = $rate $to';
  }

  @override
  String get rateSheetTitle => 'أدخل سعر الصرف';

  @override
  String rateSheetBody(String from, String to) {
    return 'لا يوجد سعر محفوظ لـ $from → $to. أدخل سعر اليوم وسيُحفظ للاستخدام دون اتصال.';
  }

  @override
  String get rateSheetInvalid => 'أدخل سعرًا أكبر من 0';

  @override
  String get historySearchHint => 'ابحث في المعاملات والملاحظات…';

  @override
  String get historyDirect => 'مباشر';

  @override
  String historyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count معاملة',
      many: '$count معاملة',
      few: '$count معاملات',
      two: 'معاملتان',
      one: 'معاملة واحدة',
      zero: 'لا معاملات',
    );
    return '$_temp0';
  }

  @override
  String get historyTotal => 'المجموع';

  @override
  String get historyEmptyTitle => 'لا توجد معاملات بعد';

  @override
  String get historyEmptyBody => 'اضغط + لتسجيل أول مصروف.';

  @override
  String get historyNoMatchesTitle => 'لا نتائج';

  @override
  String get historyNoMatchesBody => 'جرّب بحثًا آخر أو امسح عوامل التصفية.';

  @override
  String historyUnresolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count معاملات تحتاج إلى سعر',
      one: 'معاملة واحدة تحتاج إلى سعر',
    );
    return '$_temp0';
  }

  @override
  String get filterThisMonth => 'هذا الشهر';

  @override
  String get filterAllTime => 'كل الفترات';

  @override
  String get filterDateRange => 'الفترة';

  @override
  String get filterCategories => 'كل الفئات';

  @override
  String filterCategoriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count فئة',
      few: '$count فئات',
      two: 'فئتان',
      one: 'فئة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get filterCurrencies => 'كل العملات';

  @override
  String filterCurrenciesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عملة',
      few: '$count عملات',
      two: 'عملتان',
      one: 'عملة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get filterAllTypes => 'كل الأنواع';

  @override
  String get filterExpenses => 'المصاريف';

  @override
  String get filterIncome => 'الدخل';

  @override
  String get filterClearAll => 'مسح عوامل التصفية';

  @override
  String get categoriesTitle => 'الفئات';

  @override
  String get categoriesSubtitle => 'أدِر مصاريفك وخصّصها';

  @override
  String get categoriesNew => 'فئة جديدة';

  @override
  String get categoriesCapsSummary => 'الحدود الشهرية النشطة';

  @override
  String categoriesCapUsed(int percent) {
    return 'مستخدم $percent٪';
  }

  @override
  String categoriesOfCap(int percent) {
    return '$percent٪ من الحد الشهري';
  }

  @override
  String categoriesSpent(String amount) {
    return 'أُنفق $amount';
  }

  @override
  String categoriesReceived(String amount) {
    return 'استُلم $amount';
  }

  @override
  String categoriesCap(String amount) {
    return 'الحد: $amount';
  }

  @override
  String get categoriesNoCap => 'بدون حد شهري';

  @override
  String get categoriesNearCap => 'قريب من الحد';

  @override
  String get categoriesCritical => 'حرج';

  @override
  String get categoriesOverCap => 'تجاوز الحد';

  @override
  String get categoriesExpenses => 'المصاريف';

  @override
  String get categoriesIncome => 'الدخل';

  @override
  String get categoriesEmpty => 'لا توجد فئات هنا بعد.';

  @override
  String get categoryEditorNew => 'فئة جديدة';

  @override
  String get categoryEditorEdit => 'تعديل الفئة';

  @override
  String get categoryEditorName => 'اسم الفئة';

  @override
  String get categoryEditorNameHint => 'مثال: قهوة';

  @override
  String get categoryEditorGlyph => 'اختر رمزًا';

  @override
  String get categoryEditorColor => 'لون مميّز';

  @override
  String get categoryEditorCap => 'الحد الشهري للميزانية';

  @override
  String get categoryEditorNoCap => 'بدون حد';

  @override
  String get categoryEditorCreate => 'إنشاء الفئة';

  @override
  String get categoryEditorSave => 'حفظ التغييرات';

  @override
  String get categoryEditorNameRequired => 'أعطها اسمًا';

  @override
  String categoryDeleteTitle(String name) {
    return 'حذف «$name»؟';
  }

  @override
  String get categoryDeleteBody =>
      'إذا كانت معاملات تستخدمها فستتم أرشفتها بدلًا من ذلك للحفاظ على سجلك.';

  @override
  String get categoryDeleted => 'تم حذف الفئة';

  @override
  String get categoryArchived => 'تمت أرشفة الفئة — مستخدمة في معاملات سابقة';

  @override
  String get settingsCategories => 'الفئات';

  @override
  String get settingsCurrencies => 'العملات وأسعار الصرف';

  @override
  String get currenciesTitle => 'العملات وأسعار الصرف';

  @override
  String ratesUpdatedAgo(String ago) {
    return 'تم تحديث أسعار السوق $ago';
  }

  @override
  String ratesOfflineAgo(String ago) {
    return 'دون اتصال · أسعار من $ago';
  }

  @override
  String get ratesNever =>
      'لا توجد أسعار بعد. اتصل بالإنترنت لجلبها أو أدخل سعرًا عند الإضافة.';

  @override
  String get ratesRefreshing => 'جارٍ تحديث الأسعار…';

  @override
  String get ratesRefresh => 'تحديث الأسعار';

  @override
  String get timeJustNow => 'الآن';

  @override
  String timeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count دقيقة',
      few: 'منذ $count دقائق',
      two: 'منذ دقيقتين',
      one: 'منذ دقيقة',
    );
    return '$_temp0';
  }

  @override
  String timeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count ساعة',
      few: 'منذ $count ساعات',
      two: 'منذ ساعتين',
      one: 'منذ ساعة',
    );
    return '$_temp0';
  }

  @override
  String timeDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'منذ $count يومًا',
      few: 'منذ $count أيام',
      two: 'منذ يومين',
      one: 'منذ يوم',
    );
    return '$_temp0';
  }

  @override
  String get currenciesPrimaryBase => 'العملة الأساسية';

  @override
  String get currenciesLocked => 'مقفلة';

  @override
  String get currenciesBaseNote =>
      'العملة الأساسية · تُحوَّل إليها كل المعاملات والمجاميع';

  @override
  String get currenciesChangeHint => 'يمكن تغييرها من الإعدادات';

  @override
  String get currenciesTracking => 'العملات المتابَعة';

  @override
  String currenciesActive(int count) {
    return '$count نشطة';
  }

  @override
  String currenciesBaseUnit(String code) {
    return 'الأساس: 1 $code';
  }

  @override
  String get currenciesPer100 => '/ 100';

  @override
  String get currenciesNoRate => 'لا يوجد سعر بعد';

  @override
  String get currenciesAdd => 'إضافة عملة';

  @override
  String get currenciesOfflineTitle => 'أسعار محفوظة دون اتصال';

  @override
  String get currenciesOfflineBody =>
      'تُحفظ الأسعار على هذا الجهاز للسفر وتتحدّث تلقائيًا عند الاتصال بالإنترنت.';

  @override
  String get currenciesEmpty => 'أضف العملات التي تنفق بها لرؤية أسعارها هنا.';

  @override
  String get dashGreetingMorning => 'صباح الخير';

  @override
  String get dashGreetingAfternoon => 'مساء الخير';

  @override
  String get dashGreetingEvening => 'مساء الخير';

  @override
  String dashHomeCurrency(String code) {
    return '$code الرئيسية';
  }

  @override
  String dashTotalSpent(String month) {
    return 'إجمالي الإنفاق هذا الشهر ($month)';
  }

  @override
  String dashDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يومًا متبقيًا',
      few: '$count أيام متبقية',
      two: 'يومان متبقيان',
      one: 'يوم متبقٍّ',
      zero: 'آخر يوم',
    );
    return '$_temp0';
  }

  @override
  String dashOfBudget(String spent, String budget, int percent) {
    return '$spent / $budget ($percent٪)';
  }

  @override
  String dashRemaining(String amount) {
    return 'متبقٍّ $amount';
  }

  @override
  String dashOverBudget(String amount) {
    return 'تجاوز الميزانية بـ $amount';
  }

  @override
  String get dashNoBudget => 'لا توجد ميزانية شهرية';

  @override
  String get dashSetBudget => 'حدّد ميزانية';

  @override
  String dashVsLastMonth(String change) {
    return '$change مقارنة بالشهر الماضي';
  }

  @override
  String get dashBudgetDetails => 'تفاصيل الميزانية';

  @override
  String dashBudgetAlert(int percent) {
    return 'استخدمت $percent٪ من ميزانيتك الشهرية';
  }

  @override
  String get dashByCurrency => 'العملات الأصلية';

  @override
  String dashShareOfTotal(int percent) {
    return '$percent٪ من الإجمالي';
  }

  @override
  String get dashWeekPace => 'وتيرة هذا الأسبوع';

  @override
  String dashAvgPerDay(String amount) {
    return 'المتوسط $amount/يوم';
  }

  @override
  String get dashRecent => 'النشاط الأخير';

  @override
  String get dashSeeAll => 'عرض الكل';

  @override
  String get dashEmptyTitle => 'يبدأ شهرك من هنا';

  @override
  String get dashEmptyBody => 'أضف أول مصروف بزر +.';

  @override
  String dashPaid(String amount) {
    return 'دُفع $amount';
  }

  @override
  String get dashNotifications => 'الإشعارات';

  @override
  String get statsWeek => 'أسبوع';

  @override
  String get statsMonth => 'شهر';

  @override
  String get statsYear => 'سنة';

  @override
  String get statsCustom => 'مخصص';

  @override
  String get statsViewIn => 'العرض بـ';

  @override
  String statsTotalSpending(String period) {
    return 'إجمالي الإنفاق · $period';
  }

  @override
  String statsVsPrevious(String amount) {
    return 'مقابل $amount في الفترة السابقة';
  }

  @override
  String get statsCategoryDistribution => 'التوزيع حسب الفئة';

  @override
  String get statsTapToInspect => 'اضغط للتفاصيل';

  @override
  String get statsPacing => 'الإنفاق عبر الوقت';

  @override
  String statsPacingSubtitle(String code) {
    return 'لكل فترة، بـ $code';
  }

  @override
  String statsAvg(String amount) {
    return 'المتوسط $amount';
  }

  @override
  String statsPeak(String amount) {
    return 'الذروة: $amount';
  }

  @override
  String get statsForeignShare => 'حصة العملات الأجنبية';

  @override
  String statsForeignBody(String amount) {
    return 'أُنفق $amount بعملات أخرى، محوّلة بالأسعار المسجّلة.';
  }

  @override
  String get statsTopCategories => 'أهم الفئات';

  @override
  String get statsEmptyTitle => 'لا إنفاق في هذه الفترة';

  @override
  String get statsEmptyBody => 'غيّر الفترة أو أضف معاملة.';

  @override
  String statsWeekLabel(int number) {
    return 'أ$number';
  }

  @override
  String get settingsPreferences => 'التفضيلات';

  @override
  String get settingsRegionalTheme => 'المنطقة والمظهر';

  @override
  String get settingsHomeCurrency => 'العملة الرئيسية';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsAppearanceBody => 'النمط والتباين';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSystem => 'لغة النظام';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get settingsBudgeting => 'الميزانية والأتمتة';

  @override
  String get settingsMonthlyCap => 'الحد الشهري للإنفاق';

  @override
  String get settingsNoCap => 'لا يوجد';

  @override
  String get settingsBudgetAlert => 'تنبيه الميزانية عند 80٪';

  @override
  String get settingsBudgetAlertBody => 'عرض تنبيه في الرئيسية';

  @override
  String get settingsRatesBody => 'open.er-api.com · تحديث كل 12 ساعة';

  @override
  String get settingsCategoriesBody => 'الرموز والألوان والحدود الشهرية';

  @override
  String get settingsDataSecurity => 'البيانات والأمان';

  @override
  String get settingsAppLock => 'القفل البيومتري';

  @override
  String get settingsAppLockBody => 'طلب بصمة الوجه / الإصبع عند الفتح';

  @override
  String get settingsAppLockUnavailable => 'غير متاح على هذا الجهاز';

  @override
  String get settingsExport => 'تصدير المعاملات';

  @override
  String get settingsExportBody => 'ملف CSV لأي جدول بيانات';

  @override
  String get settingsExportEmpty => 'لا يوجد ما يُصدَّر بعد';

  @override
  String get settingsReset => 'إعادة تعيين كل البيانات';

  @override
  String get settingsResetBody => 'يحذف كل المعاملات والفئات والإعدادات';

  @override
  String get settingsResetConfirmTitle => 'إعادة تعيين فلوسي؟';

  @override
  String get settingsResetConfirmBody =>
      'سيتم حذف كل بياناتك على هذا الجهاز نهائيًا. لا يمكن التراجع عن ذلك.';

  @override
  String get settingsAbout => 'حول فلوسي';

  @override
  String get settingsVersion => 'إصدار التطبيق';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsPrivacyBody =>
      'بلا حسابات ولا متتبعات. كل شيء يبقى على هذا الجهاز.';

  @override
  String get settingsFooter => 'صُنع بدقة · الدار البيضاء والعالم';

  @override
  String homeChangeTitle(String code) {
    return 'تغيير العملة الرئيسية إلى $code؟';
  }

  @override
  String homeChangeBody(String code) {
    return 'ستُعرض المجاميع والرسوم بـ $code. تحتفظ المعاملات السابقة بالسعر المسجّل عند إنشائها، وتُحوَّل المبالغ بالعملات الأخرى بأقرب سعر تاريخي أو بآخر سعر متاح.';
  }

  @override
  String get homeChangeConfirm => 'تغيير';

  @override
  String homeChanged(String code) {
    return 'العملة الرئيسية الآن $code';
  }

  @override
  String get lockTitle => 'فلوسي مقفل';

  @override
  String get lockBody => 'افتح القفل لرؤية أموالك.';

  @override
  String get lockUnlock => 'فتح القفل';

  @override
  String get lockReason => 'فتح فلوسي';

  @override
  String get exportSubject => 'معاملات فلوسي';

  @override
  String get csvDate => 'التاريخ';

  @override
  String get csvType => 'النوع';

  @override
  String get csvTitle => 'العنوان';

  @override
  String get csvCategory => 'الفئة';

  @override
  String get csvAmount => 'المبلغ';

  @override
  String get csvCurrency => 'العملة';

  @override
  String get csvRate => 'السعر';

  @override
  String get csvHomeAmount => 'المبلغ بالعملة الرئيسية';

  @override
  String get csvHomeCurrency => 'العملة الرئيسية';

  @override
  String get csvPayment => 'الدفع';

  @override
  String get csvNote => 'ملاحظة';

  @override
  String get categoryDining => 'مطاعم';

  @override
  String get categoryGroceries => 'بقالة';

  @override
  String get categoryTransport => 'تنقّل';

  @override
  String get categoryTravel => 'سفر';

  @override
  String get categoryShopping => 'تسوّق';

  @override
  String get categoryBills => 'فواتير';

  @override
  String get categorySubscriptions => 'اشتراكات';

  @override
  String get categoryHealth => 'صحة';

  @override
  String get categoryEntertainment => 'ترفيه';

  @override
  String get categoryHousing => 'سكن';

  @override
  String get categoryEducation => 'تعليم';

  @override
  String get categoryOther => 'أخرى';

  @override
  String get categorySalary => 'راتب';

  @override
  String get categoryFreelance => 'عمل حر';

  @override
  String get categoryGift => 'هدايا';

  @override
  String get categoryOtherIncome => 'دخل آخر';

  @override
  String get galleryTitle => 'نظام التصميم';

  @override
  String get gallerySampleAmount => 'إجمالي الإنفاق هذا الشهر';

  @override
  String get gallerySampleButton => 'حفظ المصروف';

  @override
  String get gallerySampleSecondary => 'إعادة تعيين';

  @override
  String get gallerySegmentWeek => 'أسبوع';

  @override
  String get gallerySegmentMonth => 'شهر';

  @override
  String get gallerySegmentYear => 'سنة';
}
