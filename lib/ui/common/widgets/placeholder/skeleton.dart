import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Виджет-скелетон
///
/// [isLoading] - имеет состояние загрузки (шиммер)
class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({
    Key key,
    bool isLoading,
    this.width,
    double height,
    Color background,
    Color shimmerColor,
    double radius,
    this.borderRadius,
  })  : height = height ?? 14.0,
        radius = radius ?? 16.0,
        background = background ?? skeletonColor,
        shimmerColor = shimmerColor ?? white,
        isLoading = isLoading ?? false,
        super(key: key);

  final bool isLoading;

  final double width;
  final double height;
  final Color background;
  final Color shimmerColor;
  final double radius;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: background,
            highlightColor: shimmerColor,
            child: _buildBody(),
          )
        : _buildBody();
  }

  Widget _buildBody() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
      ),
    );
  }
}
