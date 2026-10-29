import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/money/money_input.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_keypad.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Bottom sheet with the custom keypad for typing an amount in a fixed
/// currency. Returns the entered amount, or null when dismissed.
Future<Money?> showAmountSheet(
  BuildContext context, {
  required Money initial,
  required String title,
}) => showModalBottomSheet<Money>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _AmountSheet(initial: initial, title: title),
);

class _AmountSheet extends StatefulWidget {
  const _AmountSheet({required this.initial, required this.title});

  final Money initial;
  final String title;

  @override
  State<_AmountSheet> createState() => _AmountSheetState();
}

class _AmountSheetState extends State<_AmountSheet> {
  late MoneyInput _input = MoneyInput.fromMoney(widget.initial);

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
          Center(
            child: HeroAmount(
              _input.toMoney(),
              animate: false,
              currencyStyle: HeroCurrencyStyle.codeSuffix,
            ),
          ),
          const SizedBox(height: Space.lg),
          AmountKeypad(
            decimalSeparator: context.money.decimalSeparator,
            allowDecimal: _input.currency.decimals > 0,
            backspaceLabel: l10n.txKeypadBackspace,
            decimalLabel: l10n.txKeypadDecimal,
            onDigit: (d) => setState(() => _input = _input.appendDigit(d)),
            onDecimal: () => setState(() => _input = _input.appendDecimalSeparator()),
            onBackspace: () => setState(() => _input = _input.backspace()),
            onClear: () => setState(() => _input = _input.clear()),
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
