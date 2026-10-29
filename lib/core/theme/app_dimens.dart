import 'package:flutter/animation.dart';
import 'package:flutter/painting.dart';

/// Spacing scale (design: 4 / 8 / 16 / 24 / 32, 20 screen margin).
abstract final class Space {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double smd = 12;
  static const double md = 16;
  static const double margin = 20;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Bottom padding that keeps content clear of the floating nav bar.
  static const double navClearance = 120;
}

abstract final class Radii {
  static const double sm = 8;
  static const double md = 16;
  static const double card = 24;
  static const double lg = 32;
  static const double xl = 48;
  static const double pill = 999;

  static const smAll = BorderRadius.all(Radius.circular(sm));
  static const mdAll = BorderRadius.all(Radius.circular(md));
  static const cardAll = BorderRadius.all(Radius.circular(card));
  static const lgAll = BorderRadius.all(Radius.circular(lg));
  static const pillAll = BorderRadius.all(Radius.circular(pill));
}

/// Motion tokens: short, calm, and consistent.
abstract final class Motion {
  static const fast = Duration(milliseconds: 150);
  static const medium = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 450);
  static const counter = Duration(milliseconds: 650);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;
  static const pressScale = 0.97;
}

abstract final class Sizes {
  static const double buttonHeight = 56;
  static const double rowHeight = 64;
  static const double categoryIcon = 44;
  static const double navBarHeight = 72;
  static const double fab = 60;
  static const double minTap = 48;
}
