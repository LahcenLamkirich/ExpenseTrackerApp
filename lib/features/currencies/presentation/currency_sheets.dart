import 'package:decimal/decimal.dart';
import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_widgets.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Searchable currency picker (pinned first). Returns the chosen currency.
Future<Currency?> showCurrencyPicker(BuildContext context, {Currency? selected}) =>
    showModalBottomSheet<Currency>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, controller) => _CurrencyPicker(selected: selected, scrollController: controller),
      ),
    );

class _CurrencyPicker extends StatefulWidget {
  const _CurrencyPicker({required this.selected, required this.scrollController});

  final Currency? selected;
  final ScrollController scrollController;

  @override
  State<_CurrencyPicker> createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<_CurrencyPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final results = CurrencyCatalog.search(
      _query,
      within: [...CurrencyCatalog.pinned, ...CurrencyCatalog.others],
    );
    return Column(
      children: [
        Text(l10n.pickCurrencyTitle, style: context.text.titleMedium),
        Padding(
          padding: const EdgeInsets.fromLTRB(Space.margin, Space.md, Space.margin, Space.sm),
          child: TextField(
            onChanged: (q) => setState(() => _query = q),
            decoration: InputDecoration(
              hintText: l10n.currencySearchHint,
              prefixIcon: const Icon(Icons.search_rounded),
            ),
          ),
        ),
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Text(
                    l10n.currencyNoResults(_query.trim()),
                    style: context.text.bodyMedium?.copyWith(color: context.colors.muted),
                  ),
                )
              : ListView.separated(
                  controller: widget.scrollController,
                  itemCount: results.length,
                  separatorBuilder: (_, _) => const Divider(indent: Space.margin, endIndent: Space.margin),
                  itemBuilder: (context, i) => CurrencyListRow(
                    currency: results[i],
                    selected: results[i] == widget.selected,
                    onTap: () => Navigator.of(context).pop(results[i]),
                  ),
                ),
        ),
      ],
    );
  }
}

/// Asks for `1 from = ? to`. Returns the rate, or null when dismissed.
Future<Decimal?> showManualRateSheet(
  BuildContext context, {
  required Currency from,
  required Currency to,
}) => showModalBottomSheet<Decimal>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _ManualRateSheet(from: from, to: to),
);

class _ManualRateSheet extends StatefulWidget {
  const _ManualRateSheet({required this.from, required this.to});

  final Currency from;
  final Currency to;

  @override
  State<_ManualRateSheet> createState() => _ManualRateSheetState();
}

class _ManualRateSheetState extends State<_ManualRateSheet> {
  final _controller = TextEditingController();
  bool _invalid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Accepts either `.` or the locale's separator; ignores spaces.
  Decimal? _parse(String raw, String decimalSeparator) {
    var s = raw.trim().replaceAll(RegExp(r'[\s  ]'), '');
    if (decimalSeparator != '.') s = s.replaceAll(decimalSeparator, '.');
    s = s.replaceAll(',', '.');
    final value = Decimal.tryParse(s);
    return value == null || value <= Decimal.zero ? null : value;
  }

  void _submit() {
    final rate = _parse(_controller.text, context.money.decimalSeparator);
    if (rate == null) {
      setState(() => _invalid = true);
      return;
    }
    Navigator.of(context).pop(rate);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.margin,
        0,
        Space.margin,
        Space.margin + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.rateSheetTitle, style: context.text.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: Space.sm),
          Text(
            l10n.rateSheetBody(widget.from.code, widget.to.code),
            textAlign: TextAlign.center,
            style: context.text.bodyMedium?.copyWith(color: context.colors.muted),
          ),
          const SizedBox(height: Space.lg),
          Row(
            children: [
              Text('1 ${widget.from.code} =', style: context.text.titleMedium),
              const SizedBox(width: Space.smd),
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  onChanged: (_) {
                    if (_invalid) setState(() => _invalid = false);
                  },
                  decoration: InputDecoration(
                    suffixText: widget.to.code,
                    errorText: _invalid ? l10n.rateSheetInvalid : null,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Space.lg),
          PrimaryButton(label: l10n.commonSave, trailingIcon: Icons.check_rounded, onPressed: _submit),
        ],
      ),
    );
  }
}
