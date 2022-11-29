import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Лоадер карточки нового заказа
class NewOrderLoader extends StatelessWidget {
  const NewOrderLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonWidget(
            height: 112,
            width: double.infinity,
            isLoading: true,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 36),
                Row(
                  children: const [
                    _SkeletonR16(width: 120, height: 20),
                    SizedBox(width: 13),
                    _SkeletonR16(width: 92, height: 20),
                    Spacer(),
                    _SkeletonR16(width: 20, height: 20),
                  ],
                ),
                const SizedBox(height: 13),
                const _SkeletonR16(width: 80),
                const SizedBox(height: 29),
                const _TableRow(),
                const SizedBox(height: 22),
                const _TableRow(width: 160),
                const SizedBox(height: 22),
                const _TableRow(),
                const SizedBox(height: 53),
                const SkeletonWidget(
                  radius: 12,
                  width: double.infinity,
                  height: 48,
                  isLoading: true,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    Key key,
    this.width = 110,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SkeletonR16(width: 80),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SkeletonR16(width: width),
            const SizedBox(height: 8),
            const _SkeletonR16(width: 40),
          ],
        ),
      ],
    );
  }
}

class _SkeletonR16 extends StatelessWidget {
  const _SkeletonR16({
    Key key,
    this.height = 12,
    this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      radius: 16,
      height: height,
      width: width,
      isLoading: true,
    );
  }
}
