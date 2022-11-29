import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Виджет лоадер
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    this.color = white,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 26,
      child: LoadingIndicator(
        indicatorType: Indicator.ballPulse,
        color: color,
      ),
    );
  }
}
