import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/utils/date_labels.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flossi/features/transactions/domain/transaction_filter.dart';
import 'package:flossi/features/transactions/domain/transaction_record.dart';
import 'package:flossi/features/transactions/presentation/transaction_providers.dart';
import 'package:flossi/features/transactions/presentation/widgets/filter_sheets.dart';
import 'package:flossi/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// History tab (design 05).
class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final view = ref.watch(historyViewProvider);
    final categories = ref.watch(categoriesByIdProvider).value ?? const {};
    final resolver = ref.watch(homeAmountResolverProvider);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TabHeader(label: l10n.navHistory),
            const _SearchField(),
            const SizedBox(height: Space.smd),
            const _FilterBar(),
            Expanded(
              child: switch (view) {
                AsyncData(:final value) when value.count == 0 => _EmptyHistory(filtered: value.isFiltered),
                AsyncData(:final value) => CustomScrollView(
                  slivers: [
                    for (final group in value.groups) ...[
                      SliverToBoxAdapter(child: _DayHeader(group: group)),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                        sliver: SliverList.separated(
                          itemCount: group.items.length,
                          separatorBuilder: (_, _) => const SizedBox(height: Space.sm),
                          itemBuilder: (context, i) {
                            final t = group.items[i];
                            return _SwipeToDelete(
                              transaction: t,
                              child: TransactionTile(
                                transaction: t,
                                category: categories[t.categoryId],
                                resolved: resolver.resolve(t),
                                onTap: () => context.push(Routes.editTransaction(t.id)),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(Space.margin, Space.lg, Space.margin, Space.navClearance),
                      sliver: SliverToBoxAdapter(child: _SummaryPill(view: value)),
                    ),
                  ],
                ),
                AsyncError(:final error) => ErrorState(
                  title: l10n.errorTitle,
                  message: l10n.errorBody,
                  error: error,
                  retryLabel: l10n.commonRetry,
                  onRetry: () => ref.invalidate(historyViewProvider),
                ),
                _ => const Center(child: CircularProgressIndicator()),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends ConsumerStatefulWidget {
  const _SearchField();

  @override
  ConsumerState<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends ConsumerState<_SearchField> {
  late final _controller = TextEditingController(text: ref.read(transactionFilterControllerProvider).query);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: Space.margin),
    child: TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      onChanged: ref.read(transactionFilterControllerProvider.notifier).setQuery,
      decoration: InputDecoration(
        hintText: context.l10n.historySearchHint,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) => _controller.text.isEmpty
              ? const SizedBox.shrink()
              : IconButton(
                  tooltip: context.l10n.commonClear,
                  style: IconButton.styleFrom(backgroundColor: Colors.transparent),
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    _controller.clear();
                    ref.read(transactionFilterControllerProvider.notifier).setQuery('');
                  },
                ),
        ),
      ),
    ),
  );
}

class _FilterBar extends ConsumerWidget {
  const _FilterBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final filter = ref.watch(transactionFilterControllerProvider);
    final controller = ref.read(transactionFilterControllerProvider.notifier);
    final now = ref.watch(clockProvider).now();
    final locale = Localizations.localeOf(context).toLanguageTag();
    final thisMonth = DateSpan.month(now);

    final span = filter.span;
    final String spanLabel;
    if (span == null) {
      spanLabel = l10n.filterAllTime;
    } else if (span == thisMonth) {
      spanLabel = l10n.filterThisMonth;
    } else {
      final f = DateFormat.MMMd(locale);
      spanLabel = '${f.format(span.start)} – ${f.format(span.lastDay)}';
    }

    Future<void> pickSpan() async {
      final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(now.year + 1, 12, 31),
        initialDateRange: span == null ? null : DateTimeRange(start: span.start, end: span.lastDay),
      );
      if (picked != null) controller.setSpan(DateSpan.days(picked.start, picked.end));
    }

    Future<void> pickCategories() async {
      final all = ref.read(categoriesByIdProvider).value?.values.where((c) => !c.isArchived).toList() ?? <CategoryRecord>[];
      final picked = await showCategoryFilterSheet(context, categories: all, selected: filter.categoryIds);
      if (picked != null) controller.setCategories(picked);
    }

    Future<void> pickCurrencies() async {
      final picked = await showCurrencyFilterSheet(
        context,
        currencies: [...CurrencyCatalog.pinned, ...CurrencyCatalog.others],
        selected: filter.currencyCodes,
      );
      if (picked != null) controller.setCurrencies(picked);
    }

    final typeLabel = switch (filter.type) {
      null => l10n.filterAllTypes,
      TransactionType.expense => l10n.filterExpenses,
      TransactionType.income => l10n.filterIncome,
    };

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Space.margin),
        children: [
          _FilterChip(
            icon: Icons.calendar_today_outlined,
            label: spanLabel,
            active: span != null,
            onTap: pickSpan,
            onClear: span == null ? null : () => controller.setSpan(null),
          ),
          _FilterChip(
            label: filter.categoryIds.isEmpty ? l10n.filterCategories : l10n.filterCategoriesCount(filter.categoryIds.length),
            active: filter.categoryIds.isNotEmpty,
            onTap: pickCategories,
          ),
          _FilterChip(
            label: filter.currencyCodes.isEmpty ? l10n.filterCurrencies : l10n.filterCurrenciesCount(filter.currencyCodes.length),
            active: filter.currencyCodes.isNotEmpty,
            onTap: pickCurrencies,
          ),
          _FilterChip(
            label: typeLabel,
            active: filter.type != null,
            onTap: () => controller.setType(switch (filter.type) {
              null => TransactionType.expense,
              TransactionType.expense => TransactionType.income,
              TransactionType.income => null,
            }),
          ),
          if (filter.hasRefinements)
            TextButton(onPressed: controller.clearRefinements, child: Text(l10n.filterClearAll)),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.active, required this.onTap, this.icon, this.onClear});

  final String label;
  final bool active;
  final VoidCallback onTap;
  final IconData? icon;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = active ? c.onSelectedChip : c.ink;
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: Space.sm),
      child: PressableScale(
        child: Material(
          color: active ? c.selectedChip : c.card,
          shape: StadiumBorder(side: BorderSide(color: active ? Colors.transparent : c.hairline)),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: active ? c.accent : c.ink),
                    const SizedBox(width: Space.sm),
                  ],
                  Text(label, style: context.text.titleSmall?.copyWith(color: fg)),
                  const SizedBox(width: Space.xs),
                  if (onClear != null)
                    InkResponse(
                      onTap: onClear,
                      radius: 16,
                      child: Icon(Icons.close_rounded, size: 18, color: fg),
                    )
                  else
                    Icon(Icons.arrow_drop_down_rounded, color: fg),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DayHeader extends ConsumerWidget {
  const _DayHeader({required this.group});

  final DayGroup group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final now = ref.watch(clockProvider).now();
    final locale = Localizations.localeOf(context).toLanguageTag();
    final isToday = dateOnly(group.day) == dateOnly(now);
    final total = context.money.format(group.net, display: MoneyDisplay.code, signed: true);

    return Padding(
      padding: const EdgeInsets.fromLTRB(Space.margin + Space.xs, Space.lg, Space.margin + Space.xs, Space.sm),
      child: Row(
        children: [
          if (isToday) ...[
            Container(width: 8, height: 8, decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle)),
            const SizedBox(width: Space.sm),
          ],
          Expanded(
            child: Text(
              dayHeaderLabel(l10n, locale, group.day, now).toUpperCase(),
              style: AppTypography.labelCaps.copyWith(color: c.ink, fontSize: 13),
            ),
          ),
          Text(
            group.approximate ? '≈ $total' : total,
            style: AppTypography.labelCode.copyWith(color: c.ink, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Swipe toward the trailing edge to delete, with an undo snackbar.
class _SwipeToDelete extends ConsumerWidget {
  const _SwipeToDelete({required this.transaction, required this.child});

  final TransactionRecord transaction;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    return Dismissible(
      key: ValueKey(transaction.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        padding: const EdgeInsetsDirectional.only(end: Space.lg),
        decoration: BoxDecoration(color: c.expense, borderRadius: Radii.cardAll),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete_outline_rounded, color: Colors.white),
            Text(l10n.commonDelete.toUpperCase(), style: AppTypography.labelCode.copyWith(color: Colors.white)),
          ],
        ),
      ),
      // Delete inside confirmDismiss: the list stream drops the row while the
      // dismiss animation runs, so the widget is gone by onDismissed.
      confirmDismiss: (_) async {
        final repo = ref.read(transactionRepositoryProvider);
        final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
        final removed = await repo.delete(transaction.id);
        if (removed == null) return false;
        messenger.showSnackBar(
          SnackBar(
            content: Text(l10n.txDeleted),
            action: SnackBarAction(label: l10n.commonUndo, onPressed: () => repo.save(removed)),
          ),
        );
        return true;
      },
      child: child,
    );
  }
}

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({required this.view});

  final HistoryView view;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    return Column(
      children: [
        if (view.unresolved > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: Space.sm),
            child: TagPill(
              label: l10n.historyUnresolved(view.unresolved),
              icon: Icons.info_outline_rounded,
              background: c.expenseSoft,
              foreground: c.expense,
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: Space.margin, vertical: Space.md),
          decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.pillAll),
          child: Row(
            children: [
              Icon(Icons.receipt_long_outlined, color: c.muted, size: 20),
              const SizedBox(width: Space.sm),
              Expanded(child: Text(l10n.historyCount(view.count), style: context.text.bodyMedium)),
              Text(l10n.historyTotal.toUpperCase(), style: context.text.labelMedium),
              const SizedBox(width: Space.sm),
              Text(
                context.money.format(view.net, display: MoneyDisplay.code, signed: true),
                style: AppTypography.amount.copyWith(color: c.ink),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.filtered});

  final bool filtered;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: Space.navClearance),
      child: EmptyState(
        glyph: filtered ? '🔍' : '🧾',
        title: filtered ? l10n.historyNoMatchesTitle : l10n.historyEmptyTitle,
        message: filtered ? l10n.historyNoMatchesBody : l10n.historyEmptyBody,
      ),
    );
  }
}
