import 'package:flutter/material.dart';

/// Граница без подъема текста вверх
class NoJumpOutLineBorder extends OutlineInputBorder {
  const NoJumpOutLineBorder({
    BorderSide borderSide = const BorderSide(),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    double gapPadding = 0,
  })  : assert(borderRadius != null),
        assert(gapPadding != null && gapPadding >= 0.0),
        super(
          borderSide: borderSide,
          borderRadius: borderRadius,
          gapPadding: gapPadding,
        );

  @override
  bool get isOutline => false;

  @override
  double get gapPadding => 0;

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    super.paint(
      canvas,
      rect,
      gapStart: gapStart,
      textDirection: textDirection,
    );
  }
}
