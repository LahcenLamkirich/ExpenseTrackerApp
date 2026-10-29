import 'dart:async';

import 'package:flossi/core/database/app_database.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/providers/core_providers.dart';
import 'package:flossi/core/router/routes.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_sheet.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/core/widgets/currency_chip.dart';
import 'package:flossi/core/widgets/headers.dart';
import 'package:flossi/core/widgets/segmented_pill.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flossi/features/settings/data/csv_exporter.dart';
import 'package:flossi/features/settings/presentation/app_lock.dart';
import 'package:flossi/features/settings/presentation/home_currency_flow.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/features/transactions/data/transaction_repository.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

const appVersion = '1.0.0';

/// Settings (design 10, without the account-related parts).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    final home = ref.watch(homeCurrencyProvider);
    final lockSupported = ref.watch(appLockSupportedProvider).value ?? false;
    final budget = settings.monthlyBudgetMinor == null ? null : Money(settings.monthlyBudgetMinor!, home);

    final languageLabel = switch (settings.localeCode) {
      'en' => l10n.languageEnglish,
      'fr' => l10n.languageFrench,
      'ar' => l10n.languageArabic,
      _ => l10n.settingsLanguageSystem,
    };

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, Space.navClearance),
          children: [
            TabHeader(label: l10n.navSettings),
            _Group(
              title: l10n.settingsPreferences,
              trailing: l10n.settingsRegionalTheme,
              children: [
                _Tile(
                  leading: Text(home.flag, style: const TextStyle(fontSize: 22)),
                  title: l10n.settingsHomeCurrency,
                  subtitle: '${home.name} (${home.code})',
                  trailing: CurrencyCodeBadge(currency: home),
                  onTap: () => changeHomeCurrency(context, ref),
                ),
                _Tile(
                  icon: Icons.palette_outlined,
                  title: l10n.settingsAppearance,
                  subtitle: l10n.settingsAppearanceBody,
                  below: SegmentedPill<ThemeMode>(
                    selected: settings.themeMode,
                    onChanged: controller.setThemeMode,
                    segments: [
                      Segment(value: ThemeMode.light, label: l10n.settingsThemeLight),
                      Segment(value: ThemeMode.dark, label: l10n.settingsThemeDark),
                      Segment(value: ThemeMode.system, label: l10n.settingsThemeSystem),
                    ],
                  ),
                ),
                _Tile(
                  icon: Icons.translate_rounded,
                  title: l10n.settingsLanguage,
                  subtitle: '${l10n.languageEnglish}, ${l10n.languageFrench}, ${l10n.languageArabic}',
                  value: languageLabel,
                  onTap: () => _pickLanguage(context, ref, settings.localeCode),
                ),
              ],
            ),
            _Group(
              title: l10n.settingsBudgeting,
              children: [
                _Tile(
                  icon: Icons.speed_rounded,
                  iconBackground: c.accent.withValues(alpha: 0.4),
                  title: l10n.settingsMonthlyCap,
                  value: budget == null
                      ? l10n.settingsNoCap
                      : context.money.format(budget, display: MoneyDisplay.code, trimZeroFraction: true),
                  onTap: () async {
                    final picked = await showAmountSheet(
                      context,
                      initial: budget ?? Money.zero(home),
                      title: l10n.budgetEditTitle,
                    );
                    if (picked != null) await controller.setMonthlyBudget(picked.isZero ? null : picked.minor);
                  },
                ),
                _Tile(
                  icon: Icons.notifications_active_outlined,
                  title: l10n.settingsBudgetAlert,
                  subtitle: l10n.settingsBudgetAlertBody,
                  trailing: Switch(
                    value: settings.budgetAlertEnabled,
                    onChanged: (v) => controller.setBudgetAlert(enabled: v),
                  ),
                ),
                _Tile(
                  icon: Icons.category_outlined,
                  title: l10n.settingsCategories,
                  subtitle: l10n.settingsCategoriesBody,
                  onTap: () => context.push(Routes.categories),
                ),
              ],
            ),
            _Group(
              title: l10n.settingsDataSecurity,
              children: [
                _Tile(
                  icon: Icons.fingerprint_rounded,
                  title: l10n.settingsAppLock,
                  subtitle: lockSupported ? l10n.settingsAppLockBody : l10n.settingsAppLockUnavailable,
                  trailing: Switch(
                    value: settings.appLockEnabled && lockSupported,
                    onChanged: lockSupported
                        ? (v) => ref.read(appLockProvider.notifier).setEnabled(enabled: v, reason: l10n.lockReason)
                        : null,
                  ),
                ),
                _Tile(
                  icon: Icons.download_rounded,
                  title: l10n.settingsExport,
                  subtitle: l10n.settingsExportBody,
                  trailing: const TagPill(label: 'CSV'),
                  onTap: () => _export(context, ref),
                ),
                _Tile(
                  icon: Icons.delete_forever_outlined,
                  iconColor: c.expense,
                  iconBackground: c.expenseSoft,
                  title: l10n.settingsReset,
                  subtitle: l10n.settingsResetBody,
                  onTap: () => _reset(context, ref),
                ),
              ],
            ),
            _Group(
              title: l10n.settingsAbout,
              children: [
                _Tile(
                  icon: Icons.info_outline_rounded,
                  title: l10n.settingsVersion,
                  subtitle: '${l10n.appTitle} $appVersion',
                ),
                _Tile(
                  icon: Icons.shield_outlined,
                  title: l10n.settingsPrivacy,
                  subtitle: l10n.settingsPrivacyBody,
                ),
                if (kDebugMode)
                  _Tile(
                    icon: Icons.design_services_outlined,
                    title: l10n.galleryTitle,
                    onTap: () => context.push(Routes.gallery),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(Space.lg),
              child: Text(
                l10n.settingsFooter,
                textAlign: TextAlign.center,
                style: context.text.bodySmall?.copyWith(letterSpacing: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref, String? current) async {
    final l10n = context.l10n;
    final options = <(String?, String)>[
      (null, l10n.settingsLanguageSystem),
      ('en', l10n.languageEnglish),
      ('fr', l10n.languageFrench),
      ('ar', l10n.languageArabic),
    ];
    final picked = await showModalBottomSheet<(String?,)>(
      context: context,
      builder: (context) => SafeArea(
        child: RadioGroup<String?>(
          groupValue: current,
          onChanged: (v) => Navigator.pop(context, (v,)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.settingsLanguage, style: context.text.titleMedium),
              const SizedBox(height: Space.sm),
              for (final (code, label) in options)
                RadioListTile<String?>(value: code, title: Text(label)),
            ],
          ),
        ),
      ),
    );
    if (picked != null) await ref.read(settingsControllerProvider.notifier).setLocale(picked.$1);
  }

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final transactions = await ref.read(transactionRepositoryProvider).watch().first;
    if (transactions.isEmpty) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.settingsExportEmpty)));
      return;
    }
    final categories = await ref.read(categoriesByIdProvider.future);
    final content = buildTransactionsCsv(transactions: transactions, categories: categories, l10n: l10n);
    final stamp = DateFormat('yyyyMMdd').format(ref.read(clockProvider).now());
    final name = 'flossi-transactions-$stamp.csv';
    await SharePlus.instance.share(
      ShareParams(
        subject: l10n.exportSubject,
        files: [XFile.fromData(Uint8List.fromList(csvBytes(content)), mimeType: 'text/csv', name: name)],
        fileNameOverrides: [name],
      ),
    );
  }

  Future<void> _reset(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final c = context.colors;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsResetConfirmTitle),
        content: Text(l10n.settingsResetConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: c.expense),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.settingsReset),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(appDatabaseProvider).wipe();
    ref.invalidate(onboardingControllerProvider);
    // Clearing settings sends the router back to onboarding.
    await ref.read(settingsControllerProvider.notifier).reset();
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.title, required this.children, this.trailing});

  final String title;
  final String? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(Space.margin, Space.md, Space.margin, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionLabel(
          title,
          trailing: trailing == null
              ? null
              : Text(trailing!.toUpperCase(), style: context.text.labelMedium?.copyWith(color: context.colors.accentStrong)),
        ),
        AppCard(
          radius: Radii.lg,
          padding: const EdgeInsets.symmetric(vertical: Space.xs),
          child: Column(
            children: [
              for (final (i, child) in children.indexed) ...[
                if (i > 0) const Divider(indent: Space.md, endIndent: Space.md),
                child,
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    this.icon,
    this.leading,
    this.iconColor,
    this.iconBackground,
    this.subtitle,
    this.value,
    this.trailing,
    this.below,
    this.onTap,
  });

  final String title;
  final IconData? icon;
  final Widget? leading;
  final Color? iconColor;
  final Color? iconBackground;
  final String? subtitle;
  final String? value;
  final Widget? trailing;
  final Widget? below;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.md, vertical: Space.smd),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: iconBackground ?? c.recessed, shape: BoxShape.circle),
                  child: leading ?? Icon(icon, size: 22, color: iconColor ?? c.ink),
                ),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.text.titleMedium),
                      if (subtitle != null) Text(subtitle!, style: context.text.bodySmall),
                    ],
                  ),
                ),
                if (value != null) ...[
                  const SizedBox(width: Space.sm),
                  Text(value!, style: context.text.titleSmall),
                ],
                if (trailing != null) ...[const SizedBox(width: Space.sm), trailing!],
                if (onTap != null && trailing == null) Icon(Icons.chevron_right_rounded, color: c.muted),
              ],
            ),
            if (below != null) ...[const SizedBox(height: Space.smd), below!],
          ],
        ),
      ),
    );
  }
}
