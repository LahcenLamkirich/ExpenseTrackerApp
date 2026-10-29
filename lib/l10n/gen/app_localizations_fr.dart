// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Flossi';

  @override
  String get navHome => 'Accueil';

  @override
  String get navHistory => 'Historique';

  @override
  String get navStats => 'Stats';

  @override
  String get navSettings => 'Réglages';

  @override
  String get navAdd => 'Ajouter une transaction';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonEdit => 'Modifier';

  @override
  String get commonUndo => 'Annuler';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonApply => 'Appliquer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonMore => 'Plus d’options';

  @override
  String get commonReset => 'Réinitialiser';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get errorTitle => 'Un problème est survenu';

  @override
  String get errorBody => 'Vos données sont en sécurité. Veuillez réessayer.';

  @override
  String get screenComingSoon => 'Bientôt disponible';

  @override
  String get screenComingSoonBody =>
      'Cet écran sera construit dans une prochaine phase.';

  @override
  String onboardingStep(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingLiveRates => 'Taux du jour';

  @override
  String get onboardingHomeBalance => 'Solde principal';

  @override
  String get onboardingConsolidated => 'Tout dans une seule devise';

  @override
  String get onboardingSynced => 'Synchronisé';

  @override
  String get onboardingRateNote => 'Converti au taux du jour';

  @override
  String get onboardingHeadline =>
      'L’argent sans frontières. Suivi avec élégance.';

  @override
  String get onboardingSubtitle =>
      'Flossi convertit le dirham marocain, l’euro, le dollar américain et plus de 60 devises dans votre devise principale.';

  @override
  String get onboardingFeatureRates => 'Taux de change quotidiens';

  @override
  String get onboardingFeatureTracking => 'Suivi sans encombrement';

  @override
  String get onboardingFeaturePrivate => 'Privé et hors ligne';

  @override
  String get onboardingGetStarted => 'Commencer';

  @override
  String get onboardingFootnote =>
      'Aucun compte requis. Vos données restent sur cet appareil.';

  @override
  String get currencyStepTag => 'Registre principal';

  @override
  String get currencyStepTitle => 'Choisissez votre devise principale';

  @override
  String get currencyStepBody =>
      'Toutes les dépenses sont converties dans cette devise pour vos soldes et graphiques. Vous pouvez la changer à tout moment.';

  @override
  String get currencySearchHint => 'Rechercher une devise ou un pays…';

  @override
  String get currencyPinned => 'Épinglées';

  @override
  String get currencyAll => 'Toutes les devises';

  @override
  String currencyCount(int count) {
    return '$count disponibles';
  }

  @override
  String get currencyPrimaryBadge => 'Principale';

  @override
  String currencyConfirm(String code) {
    return 'Confirmer la devise ($code)';
  }

  @override
  String currencyNoResults(String query) {
    return 'Aucune devise ne correspond à « $query »';
  }

  @override
  String get pickCurrencyTitle => 'Choisir une devise';

  @override
  String get budgetStepTag => 'Rythme serein';

  @override
  String get budgetStepTitle => 'Fixez votre objectif de dépenses mensuel';

  @override
  String get budgetStepBody =>
      'Flossi vous alerte en douceur à l’approche de votre limite, dans votre devise principale.';

  @override
  String get budgetMonthlyCap => 'Plafond mensuel';

  @override
  String get budgetQuickAdjust => 'Ajustement rapide';

  @override
  String get budgetNone => 'Sans budget';

  @override
  String get budgetNoneHint => 'Suivez vos dépenses sans limite mensuelle.';

  @override
  String get budgetDailyPace => 'Rythme quotidien conseillé';

  @override
  String budgetPerDay(String amount) {
    return '≈ $amount / jour';
  }

  @override
  String budgetDays(int count) {
    return '$count jours';
  }

  @override
  String get budgetNotifyTitle => 'M’alerter à 80 % dépensés';

  @override
  String get budgetNotifyBody => 'Un petit rappel avant de trop dépenser';

  @override
  String get budgetAllocation => 'Répartition suggérée';

  @override
  String get budgetRule => 'Règle 50 / 30 / 20';

  @override
  String get budgetNeeds => 'Besoins';

  @override
  String get budgetWants => 'Envies';

  @override
  String get budgetSavings => 'Épargne';

  @override
  String get budgetComplete => 'Terminer et entrer dans Flossi';

  @override
  String get budgetSkip => 'Plus tard';

  @override
  String get budgetAdjustLater => 'Modifiable à tout moment dans les Réglages';

  @override
  String get budgetEditTitle => 'Budget mensuel';

  @override
  String get budgetTapToEdit => 'Touchez le montant pour le saisir';

  @override
  String get txAddExpense => 'Nouvelle dépense';

  @override
  String get txAddIncome => 'Nouveau revenu';

  @override
  String get txEdit => 'Modifier la transaction';

  @override
  String get txOutflow => 'Sortie';

  @override
  String get txInflow => 'Entrée';

  @override
  String get txDate => 'Date';

  @override
  String get txToday => 'Aujourd’hui';

  @override
  String get txYesterday => 'Hier';

  @override
  String get txPaymentCard => 'Carte';

  @override
  String get txPaymentCash => 'Espèces';

  @override
  String get txPaymentTransfer => 'Virement';

  @override
  String get txPaymentOther => 'Autre';

  @override
  String get txTitleHint => 'Commerçant ou titre';

  @override
  String get txNoteHint => 'Ajouter une note';

  @override
  String get txCategory => 'Catégorie';

  @override
  String get txSaveExpense => 'Enregistrer la dépense';

  @override
  String get txSaveIncome => 'Enregistrer le revenu';

  @override
  String get txSaveChanges => 'Enregistrer';

  @override
  String get txRateMissing => 'Pas de taux · touchez pour saisir';

  @override
  String get txRateManual => 'manuel';

  @override
  String get txMoreCurrencies => 'Plus';

  @override
  String get txDelete => 'Supprimer la transaction';

  @override
  String get txDeleteConfirm => 'Supprimer cette transaction ?';

  @override
  String get txSaved => 'Transaction enregistrée';

  @override
  String get txDeleted => 'Transaction supprimée';

  @override
  String get txKeypadBackspace => 'Effacer le dernier chiffre';

  @override
  String get txKeypadDecimal => 'Séparateur décimal';

  @override
  String txConvertedWith(String from, String rate, String to) {
    return 'Converti à 1 $from = $rate $to';
  }

  @override
  String get rateSheetTitle => 'Saisir le taux de change';

  @override
  String rateSheetBody(String from, String to) {
    return 'Aucun taux en cache pour $from → $to. Saisissez le taux du jour ; il sera conservé hors ligne.';
  }

  @override
  String get rateSheetInvalid => 'Saisissez un taux supérieur à 0';

  @override
  String get historySearchHint => 'Rechercher transactions, notes…';

  @override
  String get historyDirect => 'Direct';

  @override
  String historyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions',
      one: '1 transaction',
      zero: '0 transaction',
    );
    return '$_temp0';
  }

  @override
  String get historyTotal => 'Total';

  @override
  String get historyEmptyTitle => 'Aucune transaction';

  @override
  String get historyEmptyBody =>
      'Touchez + pour enregistrer votre première dépense.';

  @override
  String get historyNoMatchesTitle => 'Aucun résultat';

  @override
  String get historyNoMatchesBody =>
      'Essayez une autre recherche ou effacez les filtres.';

  @override
  String historyUnresolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transactions sans taux',
      one: '1 transaction sans taux',
    );
    return '$_temp0';
  }

  @override
  String get filterThisMonth => 'Ce mois-ci';

  @override
  String get filterAllTime => 'Toute la période';

  @override
  String get filterDateRange => 'Période';

  @override
  String get filterCategories => 'Toutes catégories';

  @override
  String filterCategoriesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count catégories',
      one: '1 catégorie',
    );
    return '$_temp0';
  }

  @override
  String get filterCurrencies => 'Toutes devises';

  @override
  String filterCurrenciesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count devises',
      one: '1 devise',
    );
    return '$_temp0';
  }

  @override
  String get filterAllTypes => 'Tous types';

  @override
  String get filterExpenses => 'Dépenses';

  @override
  String get filterIncome => 'Revenus';

  @override
  String get filterClearAll => 'Effacer les filtres';

  @override
  String get categoriesTitle => 'Catégories';

  @override
  String get categoriesSubtitle => 'Gérez et personnalisez vos dépenses';

  @override
  String get categoriesNew => 'Nouvelle catégorie';

  @override
  String get categoriesCapsSummary => 'Plafonds mensuels actifs';

  @override
  String categoriesCapUsed(int percent) {
    return '$percent % utilisés';
  }

  @override
  String categoriesOfCap(int percent) {
    return '$percent % du plafond mensuel';
  }

  @override
  String categoriesSpent(String amount) {
    return '$amount dépensés';
  }

  @override
  String categoriesReceived(String amount) {
    return '$amount reçus';
  }

  @override
  String categoriesCap(String amount) {
    return 'Plafond : $amount';
  }

  @override
  String get categoriesNoCap => 'Sans plafond mensuel';

  @override
  String get categoriesNearCap => 'Proche du plafond';

  @override
  String get categoriesCritical => 'Critique';

  @override
  String get categoriesOverCap => 'Plafond dépassé';

  @override
  String get categoriesExpenses => 'Dépenses';

  @override
  String get categoriesIncome => 'Revenus';

  @override
  String get categoriesEmpty => 'Aucune catégorie pour l’instant.';

  @override
  String get categoryEditorNew => 'Nouvelle catégorie';

  @override
  String get categoryEditorEdit => 'Modifier la catégorie';

  @override
  String get categoryEditorName => 'Nom de la catégorie';

  @override
  String get categoryEditorNameHint => 'ex. Café';

  @override
  String get categoryEditorGlyph => 'Choisir un symbole';

  @override
  String get categoryEditorColor => 'Couleur d’accent';

  @override
  String get categoryEditorCap => 'Plafond mensuel';

  @override
  String get categoryEditorNoCap => 'Sans plafond';

  @override
  String get categoryEditorCreate => 'Créer la catégorie';

  @override
  String get categoryEditorSave => 'Enregistrer';

  @override
  String get categoryEditorNameRequired => 'Donnez-lui un nom';

  @override
  String categoryDeleteTitle(String name) {
    return 'Supprimer « $name » ?';
  }

  @override
  String get categoryDeleteBody =>
      'Si des transactions l’utilisent, elle sera archivée pour préserver votre historique.';

  @override
  String get categoryDeleted => 'Catégorie supprimée';

  @override
  String get categoryArchived =>
      'Catégorie archivée — utilisée par des transactions';

  @override
  String get settingsCategories => 'Catégories';

  @override
  String get settingsCurrencies => 'Devises et taux';

  @override
  String get currenciesTitle => 'Devises et taux de change';

  @override
  String ratesUpdatedAgo(String ago) {
    return 'Taux interbancaires mis à jour $ago';
  }

  @override
  String ratesOfflineAgo(String ago) {
    return 'Hors ligne · taux d’$ago';
  }

  @override
  String get ratesNever =>
      'Aucun taux pour l’instant. Connectez-vous pour les récupérer, ou saisissez un taux lors de l’ajout.';

  @override
  String get ratesRefreshing => 'Mise à jour des taux…';

  @override
  String get ratesRefresh => 'Actualiser les taux';

  @override
  String get timeJustNow => 'à l’instant';

  @override
  String timeMinutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count min',
      one: 'il y a 1 min',
    );
    return '$_temp0';
  }

  @override
  String timeHoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count heures',
      one: 'il y a 1 heure',
    );
    return '$_temp0';
  }

  @override
  String timeDaysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'il y a $count jours',
      one: 'il y a 1 jour',
    );
    return '$_temp0';
  }

  @override
  String get currenciesPrimaryBase => 'Devise de base';

  @override
  String get currenciesLocked => 'Verrouillée';

  @override
  String get currenciesBaseNote =>
      'Devise de base · toutes les transactions et totaux y sont convertis';

  @override
  String get currenciesChangeHint => 'Modifiable dans les Réglages';

  @override
  String get currenciesTracking => 'Devises suivies';

  @override
  String currenciesActive(int count) {
    return '$count actives';
  }

  @override
  String currenciesBaseUnit(String code) {
    return 'Base : 1 $code';
  }

  @override
  String get currenciesPer100 => '/ 100';

  @override
  String get currenciesNoRate => 'Pas encore de taux';

  @override
  String get currenciesAdd => 'Ajouter une devise';

  @override
  String get currenciesOfflineTitle => 'Taux disponibles hors ligne';

  @override
  String get currenciesOfflineBody =>
      'Les taux sont conservés sur cet appareil pour vos voyages et s’actualisent dès que vous êtes en ligne.';

  @override
  String get currenciesEmpty =>
      'Ajoutez les devises que vous utilisez pour voir leurs taux ici.';

  @override
  String get dashGreetingMorning => 'Bonjour';

  @override
  String get dashGreetingAfternoon => 'Bon après-midi';

  @override
  String get dashGreetingEvening => 'Bonsoir';

  @override
  String dashHomeCurrency(String code) {
    return '$code principale';
  }

  @override
  String dashTotalSpent(String month) {
    return 'Total dépensé ce mois-ci ($month)';
  }

  @override
  String dashDaysLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours restants',
      one: '1 jour restant',
      zero: 'Dernier jour',
    );
    return '$_temp0';
  }

  @override
  String dashOfBudget(String spent, String budget, int percent) {
    return '$spent / $budget ($percent %)';
  }

  @override
  String dashRemaining(String amount) {
    return '$amount restants';
  }

  @override
  String dashOverBudget(String amount) {
    return '$amount au-delà du budget';
  }

  @override
  String get dashNoBudget => 'Aucun budget mensuel';

  @override
  String get dashSetBudget => 'Définir un budget';

  @override
  String dashVsLastMonth(String change) {
    return '$change par rapport au mois dernier';
  }

  @override
  String get dashBudgetDetails => 'Détails du budget';

  @override
  String dashBudgetAlert(int percent) {
    return 'Vous avez utilisé $percent % de votre budget mensuel';
  }

  @override
  String get dashByCurrency => 'Devises d’origine';

  @override
  String dashShareOfTotal(int percent) {
    return '$percent % du total';
  }

  @override
  String get dashWeekPace => 'Rythme de la semaine';

  @override
  String dashAvgPerDay(String amount) {
    return 'Moy. $amount/jour';
  }

  @override
  String get dashRecent => 'Activité récente';

  @override
  String get dashSeeAll => 'Tout voir';

  @override
  String get dashEmptyTitle => 'Votre mois commence ici';

  @override
  String get dashEmptyBody =>
      'Ajoutez votre première dépense avec le bouton +.';

  @override
  String dashPaid(String amount) {
    return '$amount payés';
  }

  @override
  String get dashNotifications => 'Notifications';

  @override
  String get statsWeek => 'Semaine';

  @override
  String get statsMonth => 'Mois';

  @override
  String get statsYear => 'Année';

  @override
  String get statsCustom => 'Perso';

  @override
  String get statsViewIn => 'Voir en';

  @override
  String statsTotalSpending(String period) {
    return 'Dépenses totales · $period';
  }

  @override
  String statsVsPrevious(String amount) {
    return 'contre $amount sur la période précédente';
  }

  @override
  String get statsCategoryDistribution => 'Répartition par catégorie';

  @override
  String get statsTapToInspect => 'Touchez pour détailler';

  @override
  String get statsPacing => 'Dépenses dans le temps';

  @override
  String statsPacingSubtitle(String code) {
    return 'Par période, en $code';
  }

  @override
  String statsAvg(String amount) {
    return 'Moy. $amount';
  }

  @override
  String statsPeak(String amount) {
    return 'Pic : $amount';
  }

  @override
  String get statsForeignShare => 'Part étrangère';

  @override
  String statsForeignBody(String amount) {
    return '$amount dépensés dans d’autres devises, convertis aux taux enregistrés.';
  }

  @override
  String get statsTopCategories => 'Principales catégories';

  @override
  String get statsEmptyTitle => 'Aucune dépense sur cette période';

  @override
  String get statsEmptyBody => 'Changez de période ou ajoutez une transaction.';

  @override
  String statsWeekLabel(int number) {
    return 'S$number';
  }

  @override
  String get settingsPreferences => 'Préférences';

  @override
  String get settingsRegionalTheme => 'Région et thème';

  @override
  String get settingsHomeCurrency => 'Devise principale';

  @override
  String get settingsAppearance => 'Apparence';

  @override
  String get settingsAppearanceBody => 'Thème et contraste';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Langue du système';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageArabic => 'العربية';

  @override
  String get settingsBudgeting => 'Budget et automatisation';

  @override
  String get settingsMonthlyCap => 'Plafond de dépenses mensuel';

  @override
  String get settingsNoCap => 'Aucun';

  @override
  String get settingsBudgetAlert => 'Alerte budget à 80 %';

  @override
  String get settingsBudgetAlertBody =>
      'Afficher un avertissement sur l’accueil';

  @override
  String get settingsRatesBody => 'open.er-api.com · actualisé toutes les 12 h';

  @override
  String get settingsCategoriesBody => 'Icônes, couleurs et plafonds mensuels';

  @override
  String get settingsDataSecurity => 'Données et sécurité';

  @override
  String get settingsAppLock => 'Verrouillage biométrique';

  @override
  String get settingsAppLockBody => 'Face ID / empreinte au lancement';

  @override
  String get settingsAppLockUnavailable => 'Indisponible sur cet appareil';

  @override
  String get settingsExport => 'Exporter les transactions';

  @override
  String get settingsExportBody => 'Fichier CSV pour tout tableur';

  @override
  String get settingsExportEmpty => 'Rien à exporter pour l’instant';

  @override
  String get settingsReset => 'Réinitialiser les données';

  @override
  String get settingsResetBody =>
      'Supprime transactions, catégories et réglages';

  @override
  String get settingsResetConfirmTitle => 'Réinitialiser Flossi ?';

  @override
  String get settingsResetConfirmBody =>
      'Toutes vos données sur cet appareil seront définitivement supprimées. Cette action est irréversible.';

  @override
  String get settingsAbout => 'À propos de Flossi';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPrivacy => 'Confidentialité';

  @override
  String get settingsPrivacyBody =>
      'Aucun compte, aucun traceur. Tout reste sur cet appareil.';

  @override
  String get settingsFooter => 'Conçu avec précision · Casablanca et partout';

  @override
  String homeChangeTitle(String code) {
    return 'Passer la devise principale en $code ?';
  }

  @override
  String homeChangeBody(String code) {
    return 'Les totaux et graphiques seront affichés en $code. Les transactions passées gardent le taux enregistré à leur création ; les montants dans d’autres devises sont convertis au taux historique le plus proche, ou au dernier taux disponible.';
  }

  @override
  String get homeChangeConfirm => 'Changer';

  @override
  String homeChanged(String code) {
    return 'La devise principale est maintenant $code';
  }

  @override
  String get lockTitle => 'Flossi est verrouillé';

  @override
  String get lockBody => 'Déverrouillez pour voir vos finances.';

  @override
  String get lockUnlock => 'Déverrouiller';

  @override
  String get lockReason => 'Déverrouiller Flossi';

  @override
  String get exportSubject => 'Transactions Flossi';

  @override
  String get csvDate => 'Date';

  @override
  String get csvType => 'Type';

  @override
  String get csvTitle => 'Titre';

  @override
  String get csvCategory => 'Catégorie';

  @override
  String get csvAmount => 'Montant';

  @override
  String get csvCurrency => 'Devise';

  @override
  String get csvRate => 'Taux';

  @override
  String get csvHomeAmount => 'Montant principal';

  @override
  String get csvHomeCurrency => 'Devise principale';

  @override
  String get csvPayment => 'Paiement';

  @override
  String get csvNote => 'Note';

  @override
  String get categoryDining => 'Restaurants';

  @override
  String get categoryGroceries => 'Courses';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryTravel => 'Voyages';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryBills => 'Factures';

  @override
  String get categorySubscriptions => 'Abonnements';

  @override
  String get categoryHealth => 'Santé';

  @override
  String get categoryEntertainment => 'Loisirs';

  @override
  String get categoryHousing => 'Logement';

  @override
  String get categoryEducation => 'Éducation';

  @override
  String get categoryOther => 'Autre';

  @override
  String get categorySalary => 'Salaire';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryGift => 'Cadeaux';

  @override
  String get categoryOtherIncome => 'Autres revenus';

  @override
  String get galleryTitle => 'Design system';

  @override
  String get gallerySampleAmount => 'Total dépensé ce mois-ci';

  @override
  String get gallerySampleButton => 'Enregistrer la dépense';

  @override
  String get gallerySampleSecondary => 'Réinitialiser';

  @override
  String get gallerySegmentWeek => 'Semaine';

  @override
  String get gallerySegmentMonth => 'Mois';

  @override
  String get gallerySegmentYear => 'Année';
}
