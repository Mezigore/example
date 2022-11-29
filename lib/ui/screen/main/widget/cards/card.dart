import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Карточка с тенью.
class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.child,
    double borderRadius,
  })  : borderRadius = borderRadius ?? 16,
        super(key: key);

  final Widget child;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: shadowColor,
            blurRadius: 20.0,
            offset: Offset(0.0, 8.0),
          ),
        ],
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
