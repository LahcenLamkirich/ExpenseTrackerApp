import 'package:flossi/core/money/currency.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_widgets.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Onboarding step 2 (design 02a): choose the home currency.
class CurrencyStepScreen extends ConsumerStatefulWidget {
  const CurrencyStepScreen({super.key});

  @override
  ConsumerState<CurrencyStepScreen> createState() => _CurrencyStepScreenState();
}

class _CurrencyStepScreenState extends ConsumerState<CurrencyStepScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final selected = ref.watch(onboardingControllerProvider.select((s) => s.currency));
    final controller = ref.read(onboardingControllerProvider.notifier);
    final searching = _query.trim().isNotEmpty;
    final results = CurrencyCatalog.search(_query, within: searching ? null : CurrencyCatalog.others);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.margin, 0),
              child: Row(
                children: [
                  CircleIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: l10n.commonBack,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(width: Space.sm),
                  const Expanded(child: Center(child: StepPill(step: 2, total: 3))),
                  const SizedBox(width: Space.sm),
                  const SizedBox(width: Sizes.minTap),
                ],
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(Space.margin, Space.lg, Space.margin, 0),
                    sliver: SliverList.list(
                      children: [
                        OnboardingIntro(
                          tag: OnboardingTag(label: l10n.currencyStepTag, icon: Icons.currency_exchange_rounded),
                          title: l10n.currencyStepTitle,
                          body: l10n.currencyStepBody,
                        ),
                        const SizedBox(height: Space.lg),
                        TextField(
                          onChanged: (q) => setState(() => _query = q),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: l10n.currencySearchHint,
                            prefixIcon: const Icon(Icons.search_rounded),
                          ),
                        ),
                        const SizedBox(height: Space.lg),
                        if (!searching) ...[
                          SectionLabel(l10n.currencyPinned),
                          for (final cur in CurrencyCatalog.pinned) ...[
                            CurrencyChoiceCard(
                              currency: cur,
                              selected: cur == selected,
                              onTap: () => controller.selectCurrency(cur),
                            ),
                            const SizedBox(height: Space.smd),
                          ],
                          const SizedBox(height: Space.md),
                          SectionLabel(
                            l10n.currencyAll,
                            trailing: Text(
                              l10n.currencyCount(results.length).toUpperCase(),
                              style: context.text.labelMedium,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(Space.margin, 0, Space.margin, Space.lg),
                    sliver: SliverToBoxAdapter(
                      child: results.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(Space.xl),
                              child: Text(
                                l10n.currencyNoResults(_query.trim()),
                                textAlign: TextAlign.center,
                                style: context.text.bodyMedium?.copyWith(color: c.muted),
                              ),
                            )
                          : AppCard(
                              padding: EdgeInsets.zero,
                              child: Column(
                                children: [
                                  for (final (i, cur) in results.indexed) ...[
                                    if (i > 0) const Divider(indent: Space.md, endIndent: Space.md),
                                    CurrencyListRow(
                                      currency: cur,
                                      selected: cur == selected,
                                      onTap: () => controller.selectCurrency(cur),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Space.margin, Space.sm, Space.margin, Space.md),
              child: PrimaryButton(
                label: l10n.currencyConfirm(selected.code),
                onPressed: () => context.push(Routes.onboardingBudget),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
