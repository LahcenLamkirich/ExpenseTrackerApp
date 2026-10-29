import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Scales its child to 0.97 while pressed (design: "active state:
/// scale(0.97) with no color darkening"). Uses a [Listener] so it never
/// competes with the child's own gesture detectors.
class PressableScale extends StatefulWidget {
  const PressableScale({required this.child, super.key, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale> {
  bool _pressed = false;

  void _set(bool value) {
    if (!widget.enabled || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (_) => _set(true),
    onPointerUp: (_) => _set(false),
    onPointerCancel: (_) => _set(false),
    child: AnimatedScale(
      scale: _pressed ? Motion.pressScale : 1,
      duration: Motion.fast,
      curve: Motion.standard,
      child: widget.child,
    ),
  );
}

/// Lime pill CTA with ink label and an optional trailing icon (→).
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.trailingIcon = Icons.arrow_forward_rounded,
    this.leadingIcon,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !loading;
    final c = context.colors;
    final button = FilledButton(
      onPressed: enabled ? onPressed : null,
      style: expand ? null : FilledButton.styleFrom(minimumSize: const Size(0, Sizes.buttonHeight)),
      child: AnimatedSwitcher(
        duration: Motion.fast,
        child: loading
            ? SizedBox.square(
                key: const ValueKey('loading'),
                dimension: 22,
                child: CircularProgressIndicator(strokeWidth: 2.5, color: c.onAccent),
              )
            : Row(
                key: const ValueKey('label'),
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: 22),
                    const SizedBox(width: Space.sm),
                  ],
                  Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: Space.sm),
                    Icon(trailingIcon, size: 22),
                  ],
                ],
              ),
      ),
    );
    return PressableScale(enabled: enabled, child: button);
  }
}

/// White pill with a hairline border.
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = destructive
        ? OutlinedButton.styleFrom(
            foregroundColor: c.expense,
            backgroundColor: c.expenseSoft,
            side: BorderSide.none,
          )
        : null;
    return PressableScale(
      enabled: onPressed != null,
      child: icon == null
          ? OutlinedButton(onPressed: onPressed, style: style, child: Text(label))
          : OutlinedButton.icon(
              onPressed: onPressed,
              style: style,
              icon: Icon(icon, size: 20),
              label: Text(label),
            ),
    );
  }
}

/// Round recessed icon button used in headers (back, bell, more).
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    super.key,
    this.size = 48,
    this.background,
    this.foreground,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final double size;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    tooltip: tooltip,
    icon: Icon(icon),
    style: IconButton.styleFrom(
      fixedSize: Size.square(size),
      backgroundColor: background ?? context.colors.recessed,
      foregroundColor: foreground ?? context.colors.ink,
    ),
  );
}
