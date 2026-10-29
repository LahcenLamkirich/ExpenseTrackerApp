import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/currencies/domain/rate_table.dart';
import 'package:flossi/features/currencies/presentation/rate_providers.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flossi/features/transactions/domain/home_amount_resolver.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flossi/l10n/l10n_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_providers.g.dart';

/// Resolves stored transactions into the current home currency. Rows
/// recorded under a previous home currency are re-converted with cached
/// rates (historical first, then latest); without any rate they stay
/// unresolved and are flagged in the UI.
@Riverpod(keepAlive: true)
HomeAmountResolver homeAmountResolver(Ref ref) {
  final table = ref.watch(rateTableProvider).value ?? RateTable.empty;
  return HomeAmountResolver(ref.watch(homeCurrencyProvider), convert: table.convert);
}

/// History screen filters. Defaults to the current month.
@riverpod
class TransactionFilterController extends _$TransactionFilterController {
  @override
  TransactionFilter build() =>
      TransactionFilter(span: DateSpan.month(ref.read(clockProvider).now()));

  void setQuery(String query) => state = state.copyWith(query: query);
  void setSpan(DateSpan? span) => state = state.copyWith(span: span);
  void setType(TransactionType? type) => state = state.copyWith(type: type);
  void setCategories(Set<String> ids) => state = state.copyWith(categoryIds: ids);
  void setCurrencies(Set<String> codes) => state = state.copyWith(currencyCodes: codes);
  void clearRefinements() =>
      state = state.copyWith(categoryIds: {}, currencyCodes: {}, type: null, query: '');
}

class HistoryView {
  const HistoryView({
    required this.groups,
    required this.count,
    required this.net,
    required this.unresolved,
    required this.isFiltered,
  });

  final List<DayGroup> groups;
  final int count;

  /// Income minus expenses in the home currency.
  final Money net;

  /// Matching transactions that could not be priced in the home currency.
  final int unresolved;

  /// Whether search or refinements (not just the date span) are active.
  final bool isFiltered;
}

@riverpod
Stream<List<TransactionRecord>> transactionsInSpan(Ref ref, DateSpan? span) =>
    ref.watch(transactionRepositoryProvider).watch(from: span?.start, to: span?.end);

/// Filtered, day-grouped history for the History tab.
@riverpod
Future<HistoryView> historyView(Ref ref) async {
  final filter = ref.watch(transactionFilterControllerProvider);
  final resolver = ref.watch(homeAmountResolverProvider);
  final l10n = ref.watch(appLocalizationsProvider);
  final categories = await ref.watch(categoriesByIdProvider.future);
  final all = await ref.watch(transactionsInSpanProvider(filter.span).future);

  String nameOf(String id) {
    final c = categories[id];
    return c == null ? '' : l10n.categoryName(c);
  }

  final matching = all.where((t) => filter.matches(t, nameOf)).toList();
  final groups = groupByDay(matching, resolver);
  return HistoryView(
    groups: groups,
    count: matching.length,
    net: groups.fold(Money.zero(resolver.home), (acc, g) => acc + g.net),
    unresolved: matching.where((t) => resolver.resolve(t) == null).length,
    isFiltered: filter.hasRefinements || filter.query.trim().isNotEmpty,
  );
}

/// This month's totals per category in the home currency (positive values).
@riverpod
Future<Map<String, Money>> monthCategoryTotals(Ref ref) async {
  final now = ref.watch(clockProvider).now();
  final resolver = ref.watch(homeAmountResolverProvider);
  final txs = await ref.watch(transactionsInSpanProvider(DateSpan.month(now)).future);
  final totals = <String, Money>{};
  for (final t in txs) {
    final r = resolver.resolve(t);
    if (r == null) continue;
    totals[t.categoryId] = (totals[t.categoryId] ?? Money.zero(resolver.home)) + r.amount;
  }
  return totals;
}
