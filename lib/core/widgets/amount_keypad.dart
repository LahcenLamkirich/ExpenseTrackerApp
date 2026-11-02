import 'dart:async';

import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom numeric keypad (design 04): 3×4 grid of soft pill keys inside a
/// card. Long-press on backspace clears the amount.
class AmountKeypad extends StatelessWidget {
  const AmountKeypad({
    required this.onDigit,
    required this.onDecimal,
    required this.onBackspace,
    required this.decimalSeparator,
    required this.backspaceLabel,
    required this.decimalLabel,
    super.key,
    this.onClear,
    this.onDone,
    this.doneLabel = '',
    this.allowDecimal = true,
    this.keyHeight = 52,
  });

  final ValueChanged<int> onDigit;
  final VoidCallback onDecimal;
  final VoidCallback onBackspace;
  final VoidCallback? onClear;

  /// When set, a "Done" link is shown above the keys; it should close the keypad.
  final VoidCallback? onDone;
  final String doneLabel;
  final String decimalSeparator;
  final String backspaceLabel;
  final String decimalLabel;
  final bool allowDecimal;
  final double keyHeight;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget digit(int d) => _Key(
      height: keyHeight,
      onTap: () => onDigit(d),
      semanticLabel: '$d',
      child: Text('$d'),
    );

    final rows = <List<Widget>>[
      [digit(1), digit(2), digit(3)],
      [digit(4), digit(5), digit(6)],
      [digit(7), digit(8), digit(9)],
      [
        if (allowDecimal)
          _Key(
            height: keyHeight,
            onTap: onDecimal,
            semanticLabel: decimalLabel,
            child: Text(decimalSeparator),
          )
        else
          const SizedBox.shrink(),
        digit(0),
        _Key(
          height: keyHeight,
          onTap: onBackspace,
          onLongPress: onClear,
          semanticLabel: backspaceLabel,
          child: Icon(Icons.backspace_outlined, color: c.ink, size: 24),
        ),
      ],
    ];

    return Container(
      padding: const EdgeInsets.all(Space.md),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: Radii.lgAll,
        border: Border.all(color: c.hairline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onDone != null)
            // Toolbar like the system keypad: a "Done" link at the top right.
            Padding(
              padding: const EdgeInsets.only(bottom: Space.sm),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: onDone,
                  style: TextButton.styleFrom(
                    // Same lime as the app's main buttons.
                    backgroundColor: c.accent,
                    foregroundColor: c.onAccent,
                    shape: const StadiumBorder(),
                    textStyle: context.text.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    minimumSize: const Size(64, 40),
                    padding: const EdgeInsets.symmetric(horizontal: Space.md),
                  ),
                  child: Text(doneLabel),
                ),
              ),
            ),
          for (final (i, row) in rows.indexed) ...[
            if (i > 0) const SizedBox(height: Space.smd),
            Row(
              children: [
                for (final (j, key) in row.indexed) ...[
                  if (j > 0) const SizedBox(width: Space.smd),
                  Expanded(child: key),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key({
    required this.child,
    required this.onTap,
    required this.semanticLabel,
    required this.height,
    this.onLongPress,
  });

  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String semanticLabel;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: PressableScale(
        child: Material(
          color: c.canvas,
          borderRadius: Radii.pillAll,
          child: InkWell(
            borderRadius: Radii.pillAll,
            onTap: () {
              unawaited(HapticFeedback.selectionClick());
              onTap();
            },
            onLongPress: onLongPress == null
                ? null
                : () {
                    unawaited(HapticFeedback.mediumImpact());
                    onLongPress!();
                  },
            child: SizedBox(
              height: height,
              child: Center(
                child: DefaultTextStyle.merge(
                  style: AppTypography.headlineMd.copyWith(color: c.ink, fontWeight: FontWeight.w500),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
