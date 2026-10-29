import 'package:flossi/core/theme/app_dimens.dart';
import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class Segment<T> {
  const Segment({required this.value, required this.label});

  final T value;
  final String label;
}

/// Recessed pill track whose active item glides as an elevated white pill
/// (design: "Segmented timeframes"). Direction-aware for RTL.
class SegmentedPill<T> extends StatelessWidget {
  const SegmentedPill({
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
    this.height = 44,
  });

  final List<Segment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final index = segments.indexWhere((s) => s.value == selected).clamp(0, segments.length - 1);

    return Container(
      height: height,
      padding: const EdgeInsets.all(Space.xs),
      decoration: BoxDecoration(color: c.recessed, borderRadius: Radii.pillAll),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth / segments.length;
          return Stack(
            children: [
              AnimatedPositionedDirectional(
                duration: Motion.medium,
                curve: Motion.emphasized,
                start: width * index,
                top: 0,
                bottom: 0,
                width: width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: c.card,
                    borderRadius: Radii.pillAll,
                    border: Border.all(color: c.hairline),
                  ),
                ),
              ),
              Row(
                children: [
                  for (final (i, s) in segments.indexed)
                    Expanded(
                      child: Semantics(
                        button: true,
                        selected: i == index,
                        child: InkWell(
                          borderRadius: Radii.pillAll,
                          onTap: () => onChanged(s.value),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: Motion.fast,
                              style: AppTypography.bodySm.copyWith(
                                fontSize: 14,
                                color: i == index ? c.ink : c.muted,
                                fontWeight: i == index ? FontWeight.w700 : FontWeight.w600,
                              ),
                              child: Text(s.label, maxLines: 1, overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
