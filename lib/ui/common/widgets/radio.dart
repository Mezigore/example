import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Radio в нужном стиле
class CircleRadio extends StatelessWidget {
  const CircleRadio({Key key, this.isSelected}) : super(key: key);
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 20,
      width: 20,
      duration: const Duration(milliseconds: 60),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: colorAccent, width: 7)
            : Border.all(color: dividerColor, width: 2),
      ),
    );
  }
}
