/// Route paths, kept in one place so navigation calls never use literals.
abstract final class Routes {
  static const onboarding = '/onboarding';
  static const onboardingCurrency = '/onboarding/currency';
  static const onboardingBudget = '/onboarding/budget';
  static const home = '/home';
  static const history = '/history';
  static const stats = '/stats';
  static const settings = '/settings';
  static const addTransaction = '/transaction/new';
  static const editTransactionPattern = '/transaction/:id';
  static const categories = '/categories';
  static const currencies = '/currencies';
  static const gallery = '/dev/gallery';

  static String editTransaction(String id) => '/transaction/$id';
}
