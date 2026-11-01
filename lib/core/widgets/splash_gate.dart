import 'dart:async';

import 'package:flossi/core/theme/app_theme.dart';
import 'package:flossi/core/theme/app_typography.dart';
import 'package:flossi/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Continues the native splash for two seconds: the same centred tile, with
/// the tagline sliding up at the bottom, then fades away to reveal [child].
class SplashGate extends StatefulWidget {
  const SplashGate({required this.child, super.key, @visibleForTesting this.firstFrame});

  final Widget child;

  /// Replaces the wait for the first drawn frame, which tests never reach.
  final Future<void>? firstFrame;

  @override
  State<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends State<SplashGate> with SingleTickerProviderStateMixin {
  // Tile size of assets/branding/splash_logo.png as the native splash shows it.
  static const _tileSize = 140.0;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2500),
  );
  late final Animation<double> _tagline = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.1, 0.45, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _exit = ReverseAnimation(
    CurvedAnimation(parent: _controller, curve: const Interval(0.85, 1, curve: Curves.easeOut)),
  );
  bool _done = false;

  @override
  void initState() {
    super.initState();
    unawaited(_play());
  }

  // Waits for the first frame to reach the screen: on slow phones it can take
  // seconds to draw, and the animation would otherwise play out unseen. The
  // timeout keeps the splash from hiding the app if that signal never comes.
  Future<void> _play() async {
    await (widget.firstFrame ??
        Future.any([
          WidgetsBinding.instance.waitUntilFirstFrameRasterized,
          Future<void>.delayed(const Duration(seconds: 5)),
        ]));
    if (!mounted) return;
    await _controller.forward();
    if (mounted) setState(() => _done = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (!_done)
          FadeTransition(
            opacity: _exit,
            child: Material(
              color: c.canvas,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: _tileSize,
                    height: _tileSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: c.accent, borderRadius: BorderRadius.circular(_tileSize * 0.3)),
                    child: Text(
                      'f',
                      style: AppTypography.headlineMd.copyWith(
                        color: c.onAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: _tileSize * 0.71,
                        height: 1,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 72,
                    child: FadeTransition(
                      opacity: _tagline,
                      child: SlideTransition(
                        position: Tween(begin: const Offset(0, 0.8), end: Offset.zero).animate(_tagline),
                        child: Text(
                          context.l10n.splashTagline,
                          style: AppTypography.headlineSm.copyWith(color: c.ink, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
