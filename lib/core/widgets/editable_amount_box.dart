import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

/// An amount shown as an input field: lime outline, pencil badge and a hint
/// underneath. Tapping it calls [onTap] (usually: show the keypad). While
/// [active] a blinking cursor follows the amount.
class EditableAmountBox extends StatefulWidget {
  const EditableAmountBox({
    required this.child,
    required this.hint,
    required this.onTap,
    super.key,
    this.active = false,
    this.alignment = Alignment.centerLeft,
  });

  /// The amount (and optional currency badge). Must not use flex children:
  /// it is laid out inside a [FittedBox] so large amounts scale down.
  final Widget child;
  final String hint;
  final VoidCallback onTap;
  final bool active;
  final AlignmentGeometry alignment;

  @override
  State<EditableAmountBox> createState() => _EditableAmountBoxState();
}

class _EditableAmountBoxState extends State<EditableAmountBox> with SingleTickerProviderStateMixin {
  late final AnimationController _blink = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  @override
  void initState() {
    super.initState();
    _syncBlink();
  }

  @override
  void didUpdateWidget(EditableAmountBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active) _syncBlink();
  }

  void _syncBlink() {
    if (widget.active) {
      _blink.repeat(reverse: true);
    } else {
      _blink.stop();
    }
  }

  @override
  void dispose() {
    _blink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final centered = widget.alignment == Alignment.center;
    return Semantics(
      button: true,
      hint: widget.hint,
      child: Column(
        crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          PressableScale(
            child: Material(
              color: c.recessed,
              shape: RoundedRectangleBorder(
                borderRadius: Radii.mdAll,
                side: BorderSide(color: c.accent, width: 2),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: widget.onTap,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(Space.md, Space.sm, Space.smd, Space.sm),
                  child: Row(
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: widget.alignment,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.child,
                              const SizedBox(width: 4),
                              // Always laid out so the amount doesn't shift when it appears.
                              FadeTransition(
                                opacity: widget.active ? _blink : const AlwaysStoppedAnimation(0),
                                child: Container(
                                  width: 3,
                                  height: 44,
                                  decoration: BoxDecoration(color: c.accentStrong, borderRadius: Radii.pillAll),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: Space.sm),
                      ExcludeSemantics(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                          child: Icon(widget.active ? Icons.check_rounded : Icons.edit_rounded, size: 22, color: c.onAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Space.sm),
          ExcludeSemantics(
            child: Row(
              mainAxisSize: centered ? MainAxisSize.min : MainAxisSize.max,
              children: [
                Icon(Icons.edit_outlined, size: 14, color: c.muted),
                const SizedBox(width: Space.xs),
                Flexible(child: Text(widget.hint, style: context.text.bodySmall?.copyWith(color: c.muted))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
