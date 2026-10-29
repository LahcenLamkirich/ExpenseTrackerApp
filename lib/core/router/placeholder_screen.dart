import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Temporary screen for routes whose feature lands in a later phase.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({required this.title, super.key, this.actions = const []});

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.md, Space.margin, 0),
              child: Row(
                children: [
                  FlossiLogo(name: l10n.appTitle),
                  const SizedBox(width: Space.md),
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: EmptyState(
                title: l10n.screenComingSoon,
                message: l10n.screenComingSoonBody,
                glyph: '🛠️',
                action: actions.isEmpty ? null : Column(children: actions),
              ),
            ),
            const SizedBox(height: Space.navClearance),
          ],
        ),
      ),
    );
  }
}
