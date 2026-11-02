import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/money/money_input.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_keypad.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/editable_amount_box.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Bottom sheet for changing an amount in a fixed currency. The keypad stays
/// hidden until the amount box is tapped, unless [keypadOpen] is true (the
/// caller's own tap already meant "type an amount"). Returns the entered
/// amount, or null when dismissed.
Future<Money?> showAmountSheet(
  BuildContext context, {
  required Money initial,
  required String title,
  bool keypadOpen = false,
  String? hint,
}) => showModalBottomSheet<Money>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _AmountSheet(initial: initial, title: title, keypadOpen: keypadOpen, hint: hint),
);

class _AmountSheet extends StatefulWidget {
  const _AmountSheet({required this.initial, required this.title, required this.keypadOpen, this.hint});

  final Money initial;
  final String title;
  final bool keypadOpen;

  /// Help text under the amount. Defaults to keypad instructions.
  final String? hint;

  @override
  State<_AmountSheet> createState() => _AmountSheetState();
}

class _AmountSheetState extends State<_AmountSheet> {
  late MoneyInput _input = MoneyInput.fromMoney(widget.initial);
  late bool _keypadOpen = widget.keypadOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Space.margin,
        0,
        Space.margin,
        Space.margin + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.title, textAlign: TextAlign.center, style: context.text.titleMedium),
          const SizedBox(height: Space.md),
          EditableAmountBox(
            active: _keypadOpen,
            alignment: Alignment.center,
            hint: widget.hint ?? (_keypadOpen ? l10n.amountSheetHint : l10n.budgetTapToEdit),
            onTap: () => setState(() => _keypadOpen = !_keypadOpen),
            child: HeroAmount(
              _input.toMoney(),
              animate: false,
              currencyStyle: HeroCurrencyStyle.codeSuffix,
            ),
          ),
          AnimatedSize(
            duration: Motion.medium,
            curve: Motion.standard,
            alignment: Alignment.topCenter,
            child: _keypadOpen
                ? Padding(
                    padding: const EdgeInsets.only(top: Space.lg),
                    child: AmountKeypad(
                      decimalSeparator: context.money.decimalSeparator,
                      allowDecimal: _input.currency.decimals > 0,
                      backspaceLabel: l10n.txKeypadBackspace,
                      decimalLabel: l10n.txKeypadDecimal,
                      onDigit: (d) => setState(() => _input = _input.appendDigit(d)),
                      onDecimal: () => setState(() => _input = _input.appendDecimalSeparator()),
                      onBackspace: () => setState(() => _input = _input.backspace()),
                      onClear: () => setState(() => _input = _input.clear()),
                      onDone: () => setState(() => _keypadOpen = false),
                      doneLabel: l10n.commonDone,
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
          const SizedBox(height: Space.md),
          PrimaryButton(
            label: l10n.commonDone,
            trailingIcon: Icons.check_rounded,
            onPressed: () => Navigator.of(context).pop(_input.toMoney()),
          ),
        ],
      ),
    );
  }
}
