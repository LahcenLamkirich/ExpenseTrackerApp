import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/utils/date_labels.dart';
import 'package:flossi/core/widgets/amount_keypad.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/currencies/data/tracked_currency_repository.dart';
import 'package:flossi/features/currencies/presentation/currency_sheets.dart';
import 'package:flossi/features/transactions/presentation/transaction_editor_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Add / Edit transaction (design 04).
class TransactionEditorScreen extends ConsumerWidget {
  const TransactionEditorScreen({super.key, this.transactionId});

  final String? transactionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(transactionEditorProvider(transactionId));
    return Scaffold(
      body: SafeArea(
        child: switch (async) {
          AsyncData(:final value) => _EditorBody(transactionId: transactionId, state: value),
          AsyncError(:final error) => ErrorState(
            title: context.l10n.errorTitle,
            message: context.l10n.errorBody,
            error: error,
            retryLabel: context.l10n.commonRetry,
            onRetry: () => ref.invalidate(transactionEditorProvider(transactionId)),
          ),
          _ => const Center(child: CircularProgressIndicator()),
        },
      ),
    );
  }
}

class _EditorBody extends ConsumerStatefulWidget {
  const _EditorBody({required this.transactionId, required this.state});

  final String? transactionId;
  final TransactionEditorState state;

  @override
  ConsumerState<_EditorBody> createState() => _EditorBodyState();
}

class _EditorBodyState extends ConsumerState<_EditorBody> {
  late final _title = TextEditingController(text: widget.state.title);
  late final _note = TextEditingController(text: widget.state.note);

  TransactionEditor get _controller => ref.read(transactionEditorProvider(widget.transactionId).notifier);

  @override
  void dispose() {
    _title.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final saved = await _controller.save();
    if (saved == null || !mounted) return;
    messenger.showSnackBar(SnackBar(content: Text(context.l10n.txSaved)));
    navigator.pop();
  }

  Future<void> _delete() async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.txDeleteConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonDelete)),
        ],
      ),
    );
    if (confirmed != true) return;
    await _controller.delete();
    messenger.showSnackBar(SnackBar(content: Text(l10n.txDeleted)));
    navigator.pop();
  }

  Future<void> _pickDate(DateTime current) async {
    final now = ref.read(clockProvider).now();
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1, 12, 31),
    );
    if (picked != null) _controller.setDay(picked);
  }

  Future<void> _enterRate(TransactionEditorState s) async {
    final rate = await showManualRateSheet(context, from: s.currency, to: s.home);
    if (rate != null) await _controller.saveManualRate(rate);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = ref.watch(transactionEditorProvider(widget.transactionId)).requireValue;
    final isExpense = s.type == TransactionType.expense;
    final title = s.isEditing ? l10n.txEdit : (isExpense ? l10n.txAddExpense : l10n.txAddIncome);

    return Column(
      children: [
        ScreenHeader(
          title: title,
          backIcon: Icons.close_rounded,
          trailing: s.isEditing
              ? CircleIconButton(icon: Icons.delete_outline_rounded, tooltip: l10n.txDelete, onPressed: _delete)
              : null,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: Space.md),
            children: [
              _CurrencyStrip(
                selected: s.currency,
                onSelected: _controller.setCurrency,
              ),
              const SizedBox(height: Space.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                child: _AmountCard(state: s, onTypeChanged: _controller.setType, onEnterRate: () => _enterRate(s)),
              ),
              const SizedBox(height: Space.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                child: Row(
                  children: [
                    Expanded(
                      child: _DateTile(date: s.date, onTap: () => _pickDate(s.date)),
                    ),
                    const SizedBox(width: Space.smd),
                    Expanded(
                      child: SegmentedPill<PaymentMethod>(
                        height: 64,
                        selected: s.paymentMethod,
                        onChanged: _controller.setPaymentMethod,
                        segments: [
                          Segment(value: PaymentMethod.card, label: l10n.txPaymentCard),
                          Segment(value: PaymentMethod.cash, label: l10n.txPaymentCash),
                          Segment(value: PaymentMethod.transfer, label: l10n.txPaymentTransfer),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Space.smd),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Space.margin),
                child: Column(
                  children: [
                    TextField(
                      controller: _title,
                      onChanged: _controller.setTitle,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: l10n.txTitleHint,
                        prefixIcon: const Icon(Icons.storefront_outlined),
                      ),
                    ),
                    const SizedBox(height: Space.sm),
                    TextField(
                      controller: _note,
                      onChanged: _controller.setNote,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: l10n.txNoteHint,
                        prefixIcon: const Icon(Icons.edit_note_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Space.md),
              _CategoryPicker(
                kind: isExpense ? CategoryKind.expense : CategoryKind.income,
                selectedId: s.categoryId,
                onSelected: _controller.setCategory,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(Space.margin, 0, Space.margin, Space.sm),
          child: Column(
            children: [
              AmountKeypad(
                // Short screens keep room for the form above the keypad.
                keyHeight: MediaQuery.sizeOf(context).height < 760 ? 38 : 46,
                decimalSeparator: context.money.decimalSeparator,
                allowDecimal: s.currency.decimals > 0,
                backspaceLabel: l10n.txKeypadBackspace,
                decimalLabel: l10n.txKeypadDecimal,
                onDigit: _controller.appendDigit,
                onDecimal: _controller.appendDecimal,
                onBackspace: _controller.backspace,
                onClear: _controller.clearAmount,
              ),
              const SizedBox(height: Space.smd),
              PrimaryButton(
                label: s.isEditing ? l10n.txSaveChanges : (isExpense ? l10n.txSaveExpense : l10n.txSaveIncome),
                loading: s.saving,
                onPressed: s.canSave ? _save : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CurrencyStrip extends ConsumerWidget {
  const _CurrencyStrip({required this.selected, required this.onSelected});

  final Currency selected;
  final ValueChanged<Currency> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracked = ref.watch(trackedCurrenciesProvider).value ?? CurrencyCatalog.pinned;
    final currencies = [if (!tracked.contains(selected)) selected, ...tracked];
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Space.margin),
        itemCount: currencies.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: Space.sm),
        itemBuilder: (context, i) {
          if (i == currencies.length) {
            return ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 18),
              label: Text(context.l10n.txMoreCurrencies),
              onPressed: () async {
                final picked = await showCurrencyPicker(context, selected: selected);
                if (picked != null) {
                  await ref.read(trackedCurrencyRepositoryProvider).ensure([picked.code]);
                  onSelected(picked);
                }
              },
            );
          }
          final cur = currencies[i];
          return CurrencyChip(currency: cur, selected: cur == selected, onTap: () => onSelected(cur));
        },
      ),
    );
  }
}

class _AmountCard extends StatelessWidget {
  const _AmountCard({required this.state, required this.onTypeChanged, required this.onEnterRate});

  final TransactionEditorState state;
  final ValueChanged<TransactionType> onTypeChanged;
  final VoidCallback onEnterRate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final s = state;
    return AppCard(
      radius: Radii.lg,
      padding: const EdgeInsets.fromLTRB(Space.margin, Space.md, Space.margin, Space.margin),
      child: Column(
        children: [
          SizedBox(
            width: 230,
            child: SegmentedPill<TransactionType>(
              height: 38,
              selected: s.type,
              onChanged: onTypeChanged,
              segments: [
                Segment(value: TransactionType.expense, label: l10n.txOutflow.toUpperCase()),
                Segment(value: TransactionType.income, label: l10n.txInflow.toUpperCase()),
              ],
            ),
          ),
          const SizedBox(height: Space.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: HeroAmount(
              s.amount,
              animate: false,
              currencyStyle: HeroCurrencyStyle.prefixSymbol,
              style: AppTypography.heroXl.copyWith(color: s.amount.isZero ? c.muted : null),
            ),
          ),
          if (s.needsConversion) ...[
            const SizedBox(height: Space.smd),
            _ConversionPill(state: s, onEnterRate: onEnterRate),
          ],
        ],
      ),
    );
  }
}

class _ConversionPill extends StatelessWidget {
  const _ConversionPill({required this.state, required this.onEnterRate});

  final TransactionEditorState state;
  final VoidCallback onEnterRate;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final fmt = context.money;
    final s = state;

    final Widget content;
    switch (s.rateStatus) {
      case RateStatus.loading:
        content = const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2));
      case RateStatus.missing:
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.edit_outlined, size: 16, color: c.expense),
            const SizedBox(width: Space.sm),
            Text(l10n.txRateMissing, style: context.text.bodySmall?.copyWith(color: c.expense)),
          ],
        );
      case RateStatus.ready:
        final quote = s.rate!;
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.swap_horiz_rounded, size: 18, color: c.income),
            const SizedBox(width: Space.sm),
            Flexible(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '≈ ${fmt.format(s.converted!, display: MoneyDisplay.code)}  ',
                      style: context.text.titleSmall,
                    ),
                    TextSpan(
                      text: '(${fmt.formatRate(quote.rate)}${quote.isManual ? ' · ${l10n.txRateManual}' : ''})',
                      style: context.text.bodySmall,
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
    }

    return Material(
      color: c.recessed,
      borderRadius: Radii.pillAll,
      child: InkWell(
        borderRadius: Radii.pillAll,
        // A tap always allows overriding the rate with a manual one.
        onTap: onEnterRate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.sm),
          child: AnimatedSize(duration: Motion.fast, child: content),
        ),
      ),
    );
  }
}

class _DateTile extends ConsumerWidget {
  const _DateTile({required this.date, required this.onTap});

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = ref.watch(clockProvider).now();
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: Space.smd, vertical: Space.sm),
      radius: Radii.md,
      onTap: onTap,
      child: SizedBox(
        height: 46,
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: c.recessed, shape: BoxShape.circle),
              child: Icon(Icons.calendar_today_outlined, size: 18, color: c.accentStrong),
            ),
            const SizedBox(width: Space.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.txDate, style: context.text.bodySmall),
                  Text(
                    relativeDayLabel(l10n, locale, date, now),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.text.titleSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryPicker extends ConsumerWidget {
  const _CategoryPicker({required this.kind, required this.selectedId, required this.onSelected});

  final CategoryKind kind;
  final String? selectedId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final categories = ref.watch(activeCategoriesProvider(kind)).value ?? const <CategoryRecord>[];
    final selected = categories.where((cat) => cat.id == selectedId).firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.margin),
          child: Row(
            children: [
              Text(l10n.txCategory, style: context.text.titleSmall?.copyWith(color: c.muted)),
              const Spacer(),
              if (selected != null)
                Text(l10n.categoryName(selected), style: context.text.titleSmall?.copyWith(color: c.accentStrong)),
            ],
          ),
        ),
        const SizedBox(height: Space.sm),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Space.margin),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: Space.sm),
            itemBuilder: (context, i) {
              final cat = categories[i];
              final isSelected = cat.id == selectedId;
              return Semantics(
                selected: isSelected,
                button: true,
                child: PressableScale(
                  child: AnimatedContainer(
                    duration: Motion.medium,
                    width: 92,
                    decoration: BoxDecoration(
                      color: c.card,
                      borderRadius: Radii.mdAll,
                      border: Border.all(color: isSelected ? c.accent : c.hairline, width: isSelected ? 2.5 : 1),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: Radii.mdAll,
                        onTap: () => onSelected(cat.id),
                        child: Padding(
                          padding: const EdgeInsets.all(Space.sm),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CategoryIcon(glyph: cat.glyph, color: cat.color),
                              const SizedBox(height: Space.sm),
                              Text(
                                l10n.categoryName(cat),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.text.bodySmall?.copyWith(
                                  color: isSelected ? c.ink : c.muted,
                                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
