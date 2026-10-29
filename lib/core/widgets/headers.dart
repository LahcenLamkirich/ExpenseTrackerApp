import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Tab-screen header: Flossi wordmark at the start, uppercase screen label
/// and optional actions at the end (designs 03/05/06/10).
class TabHeader extends StatelessWidget {
  const TabHeader({required this.label, super.key, this.actions = const []});

  final String label;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(Space.margin, Space.md, Space.margin, Space.sm),
    child: Row(
      children: [
        FlossiLogo(name: context.l10n.appTitle),
        const SizedBox(width: Space.md),
        Expanded(
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: context.text.labelMedium,
          ),
        ),
        for (final a in actions) ...[const SizedBox(width: Space.sm), a],
      ],
    ),
  );
}

/// Modal/pushed-screen header: round back button, centred title, optional
/// trailing action (designs 04/08/09).
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    required this.title,
    super.key,
    this.onBack,
    this.trailing,
    this.backIcon = Icons.arrow_back_rounded,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final IconData backIcon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.margin, Space.sm),
    child: Row(
      children: [
        CircleIconButton(
          // arrow_back icons mirror automatically in RTL.
          icon: backIcon,
          tooltip: context.l10n.commonBack,
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(width: Space.md),
        Expanded(
          child: Semantics(
            header: true,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(width: Space.md),
        SizedBox(width: Sizes.minTap, child: trailing),
      ],
    ),
  );
}
