import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Multi-select sheet over arbitrary items. Returns the new selection, or
/// null when dismissed.
Future<Set<String>?> showMultiSelectSheet<T>({
  required BuildContext context,
  required String title,
  required List<T> items,
  required String Function(T) idOf,
  required Widget Function(BuildContext, T) leadingOf,
  required String Function(BuildContext, T) labelOf,
  required Set<String> selected,
}) => showModalBottomSheet<Set<String>>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => DraggableScrollableSheet(
    expand: false,
    initialChildSize: 0.7,
    maxChildSize: 0.95,
    builder: (context, scroll) => _MultiSelect<T>(
      title: title,
      items: items,
      idOf: idOf,
      leadingOf: leadingOf,
      labelOf: labelOf,
      initial: selected,
      scrollController: scroll,
    ),
  ),
);

Future<Set<String>?> showCategoryFilterSheet(
  BuildContext context, {
  required List<CategoryRecord> categories,
  required Set<String> selected,
}) => showMultiSelectSheet<CategoryRecord>(
  context: context,
  title: context.l10n.filterCategories,
  items: categories,
  idOf: (c) => c.id,
  leadingOf: (_, c) => CategoryIcon(glyph: c.glyph, color: c.color, size: 36),
  labelOf: (context, c) => context.l10n.categoryName(c),
  selected: selected,
);

Future<Set<String>?> showCurrencyFilterSheet(
  BuildContext context, {
  required List<Currency> currencies,
  required Set<String> selected,
}) => showMultiSelectSheet<Currency>(
  context: context,
  title: context.l10n.filterCurrencies,
  items: currencies,
  idOf: (c) => c.code,
  leadingOf: (_, c) => CurrencyFlag(currency: c, size: 36),
  labelOf: (_, c) => '${c.code} · ${c.name}',
  selected: selected,
);

class _MultiSelect<T> extends StatefulWidget {
  const _MultiSelect({
    required this.title,
    required this.items,
    required this.idOf,
    required this.leadingOf,
    required this.labelOf,
    required this.initial,
    required this.scrollController,
  });

  final String title;
  final List<T> items;
  final String Function(T) idOf;
  final Widget Function(BuildContext, T) leadingOf;
  final String Function(BuildContext, T) labelOf;
  final Set<String> initial;
  final ScrollController scrollController;

  @override
  State<_MultiSelect<T>> createState() => _MultiSelectState<T>();
}

class _MultiSelectState<T> extends State<_MultiSelect<T>> {
  late final Set<String> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Space.margin),
          child: Row(
            children: [
              Expanded(child: Text(widget.title, style: context.text.titleMedium)),
              TextButton(
                onPressed: _selected.isEmpty ? null : () => setState(_selected.clear),
                child: Text(l10n.commonClear),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: widget.scrollController,
            itemCount: widget.items.length,
            itemBuilder: (context, i) {
              final item = widget.items[i];
              final id = widget.idOf(item);
              return CheckboxListTile(
                value: _selected.contains(id),
                onChanged: (v) => setState(() => v! ? _selected.add(id) : _selected.remove(id)),
                secondary: widget.leadingOf(context, item),
                title: Text(widget.labelOf(context, item)),
                controlAffinity: ListTileControlAffinity.trailing,
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            Space.margin,
            Space.sm,
            Space.margin,
            Space.md + MediaQuery.paddingOf(context).bottom,
          ),
          child: PrimaryButton(
            label: l10n.commonApply,
            trailingIcon: Icons.check_rounded,
            onPressed: () => Navigator.of(context).pop(_selected),
          ),
        ),
      ],
    );
  }
}
