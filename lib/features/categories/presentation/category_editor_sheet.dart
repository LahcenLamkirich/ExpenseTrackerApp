import 'package:flossi/core/domain/enums.dart';
import 'package:flossi/core/money/money.dart';
import 'package:flossi/core/money/money_context.dart';
import 'package:flossi/core/theme/app_colors.dart';
import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/amount_sheet.dart';
import 'package:flossi/core/widgets/amount_text.dart';
import 'package:flossi/core/widgets/app_card.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flossi/core/widgets/category_icon.dart';
import 'package:flossi/core/widgets/common.dart';
import 'package:flossi/features/categories/data/category_repository.dart';
import 'package:flossi/features/categories/domain/category_record.dart';
import 'package:flossi/features/categories/presentation/category_l10n.dart';
import 'package:flossi/features/onboarding/domain/budget_presets.dart';
import 'package:flossi/features/settings/presentation/settings_controller.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Curated glyphs for the picker (design 09 "Select glyph").
const categoryGlyphs = [
  '☕', '🍜', '🍕', '🍔', '🍸', '🛒', '🥑', '🚕', '🚇', '⛽', '✈️', '🏨',
  '🛍️', '👕', '💡', '📱', '💻', '🎬', '🎮', '🎵', '📚', '🏠', '🛠️', '🩺',
  '💊', '🏋️', '🐾', '👶', '🎁', '💼', '💰', '📈', '🧾', '📦',
];

/// Create (when [category] is null) or edit a category.
Future<void> showCategoryEditor(
  BuildContext context, {
  required CategoryKind kind,
  CategoryRecord? category,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (_) => _CategoryEditor(kind: kind, category: category),
);

class _CategoryEditor extends ConsumerStatefulWidget {
  const _CategoryEditor({required this.kind, this.category});

  final CategoryKind kind;
  final CategoryRecord? category;

  @override
  ConsumerState<_CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends ConsumerState<_CategoryEditor> {
  late final TextEditingController _name;
  bool _nameReady = false;
  late String _glyph;
  late int _color;
  int? _capMinor;
  bool _showNameError = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    final c = widget.category;
    _glyph = c?.glyph ?? categoryGlyphs.first;
    _color = c?.colorValue ?? Palette.categoryAccents[1].toARGB32();
    _capMinor = c?.monthlyCapMinor;
    _showNameError = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final c = widget.category;
    final initialName = c == null ? '' : context.l10n.categoryName(c);
    // Needs l10n, so it is created here (runs once before the first build).
    if (!_nameReady) {
      _name = TextEditingController(text: initialName);
      _nameReady = true;
    }
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      setState(() => _showNameError = true);
      return;
    }
    setState(() => _saving = true);
    final repo = ref.read(categoryRepositoryProvider);
    final existing = widget.category;
    if (existing == null) {
      await repo.create(
        name: name,
        glyph: _glyph,
        colorValue: _color,
        kind: widget.kind,
        monthlyCapMinor: _capMinor,
      );
    } else {
      final renamed = name != context.l10n.categoryName(existing);
      await repo.update(
        existing.copyWith(
          // Built-ins keep their localized name unless the user renamed them.
          name: renamed || existing.nameKey == null ? name : existing.name,
          glyph: _glyph,
          colorValue: _color,
          monthlyCapMinor: _capMinor,
        ),
      );
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final home = ref.watch(homeCurrencyProvider);
    final step = BudgetPresets.of(home).increments.first;
    final cap = _capMinor == null ? null : Money(_capMinor!, home);
    final previewName = _name.text.trim().isEmpty ? l10n.categoryEditorNameHint : _name.text.trim();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(Space.margin, 0, Space.margin, Space.margin + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CategoryIcon(glyph: _glyph, color: Color(_color), size: 52),
                const SizedBox(width: Space.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.category == null ? l10n.categoryEditorNew : l10n.categoryEditorEdit).toUpperCase(),
                        style: context.text.labelMedium,
                      ),
                      Text(previewName, style: context.text.headlineSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Space.lg),
            SectionLabel(l10n.categoryEditorName),
            TextField(
              controller: _name,
              autofocus: widget.category == null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() => _showNameError = false),
              decoration: InputDecoration(
                hintText: l10n.categoryEditorNameHint,
                suffixIcon: const Icon(Icons.edit_outlined),
                errorText: _showNameError ? l10n.categoryEditorNameRequired : null,
              ),
            ),
            const SizedBox(height: Space.lg),
            SectionLabel(l10n.categoryEditorGlyph),
            RecessedBox(
              padding: const EdgeInsets.all(Space.sm),
              child: Wrap(
                spacing: Space.xs,
                runSpacing: Space.xs,
                children: [
                  for (final g in categoryGlyphs)
                    Semantics(
                      selected: g == _glyph,
                      button: true,
                      child: InkWell(
                        borderRadius: Radii.pillAll,
                        onTap: () => setState(() => _glyph = g),
                        child: AnimatedContainer(
                          duration: Motion.fast,
                          width: 46,
                          height: 46,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: g == _glyph ? c.card : Colors.transparent,
                            shape: BoxShape.circle,
                            border: g == _glyph ? Border.all(color: c.hairline) : null,
                          ),
                          child: Text(g, style: const TextStyle(fontSize: 22)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Space.lg),
            SectionLabel(l10n.categoryEditorColor),
            RecessedBox(
              padding: const EdgeInsets.all(Space.smd),
              child: Wrap(
                spacing: Space.smd,
                runSpacing: Space.smd,
                children: [
                  for (final color in Palette.categoryAccents)
                    Semantics(
                      selected: color.toARGB32() == _color,
                      button: true,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => setState(() => _color = color.toARGB32()),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                          child: color.toARGB32() == _color
                              ? const Icon(Icons.check_rounded, color: Palette.ink)
                              : null,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Space.lg),
            RecessedBox(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final picked = await showAmountSheet(
                          context,
                          initial: cap ?? Money.zero(home),
                          title: l10n.categoryEditorCap,
                        );
                        if (picked != null) setState(() => _capMinor = picked.isZero ? null : picked.minor);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.categoryEditorCap.toUpperCase(), style: context.text.labelMedium),
                          const SizedBox(height: Space.xs),
                          if (cap == null)
                            Text(l10n.categoryEditorNoCap, style: context.text.headlineSmall?.copyWith(color: c.muted))
                          else
                            AmountText(
                              cap,
                              display: MoneyDisplay.code,
                              style: context.text.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                            ),
                        ],
                      ),
                    ),
                  ),
                  _StepButton(
                    icon: Icons.remove_rounded,
                    tooltip: l10n.categoryEditorNoCap,
                    onTap: cap == null
                        ? null
                        : () => setState(() {
                            final next = cap - step;
                            _capMinor = next.isPositive ? next.minor : null;
                          }),
                  ),
                  const SizedBox(width: Space.sm),
                  _StepButton(
                    icon: Icons.add_rounded,
                    tooltip: l10n.categoryEditorCap,
                    onTap: () => setState(() => _capMinor = ((cap ?? Money.zero(home)) + step).minor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Space.lg),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PrimaryButton(
                    label: widget.category == null ? l10n.categoryEditorCreate : l10n.categoryEditorSave,
                    leadingIcon: Icons.check_circle_outline_rounded,
                    trailingIcon: null,
                    loading: _saving,
                    onPressed: _save,
                  ),
                ),
                const SizedBox(width: Space.smd),
                Expanded(
                  child: SecondaryButton(
                    label: l10n.commonReset,
                    onPressed: () => setState(() {
                      _reset();
                      _name.text = widget.category == null ? '' : l10n.categoryName(widget.category!);
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.tooltip, required this.onTap});

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    onPressed: onTap,
    icon: Icon(icon),
    style: IconButton.styleFrom(
      backgroundColor: context.colors.card,
      fixedSize: const Size.square(44),
    ),
  );
}

/// Confirms and deletes (or archives) [category], reporting the outcome.
Future<void> confirmDeleteCategory(BuildContext context, WidgetRef ref, CategoryRecord category) async {
  final l10n = context.l10n;
  final messenger = ScaffoldMessenger.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.categoryDeleteTitle(l10n.categoryName(category))),
      content: Text(l10n.categoryDeleteBody),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.commonCancel)),
        TextButton(onPressed: () => Navigator.pop(context, true), child: Text(l10n.commonDelete)),
      ],
    ),
  );
  if (confirmed != true) return;
  final result = await ref.read(categoryRepositoryProvider).delete(category.id);
  messenger.showSnackBar(
    SnackBar(content: Text(result == CategoryDeletion.archived ? l10n.categoryArchived : l10n.categoryDeleted)),
  );
}
