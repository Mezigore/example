import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/screen/cart/cart_screen.dart';

/// Экран загрузки для [CartScreen]
class CartPlaceholder extends StatelessWidget {
  const CartPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 32),
          SkeletonWidget(
            width: 128,
            height: 28,
            isLoading: true,
          ),
          SizedBox(height: 11),
          SkeletonWidget(
            width: 168,
            height: 12,
            isLoading: true,
          ),
          SizedBox(height: 14),
          _CardPlaceholder(),
          _CardPlaceholder(),
          _CardPlaceholder(),
          Divider(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CardPlaceholder extends StatelessWidget {
  const _CardPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SkeletonWidget(
              width: 112,
              height: 112,
              isLoading: true,
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonWidget(
                  width: 168,
                  height: 12,
                  isLoading: true,
                ),
                const SizedBox(height: 10),
                const SkeletonWidget(
                  width: 192,
                  height: 12,
                  isLoading: true,
                ),
                const SizedBox(height: 10),
                const SkeletonWidget(
                  width: 136,
                  height: 12,
                  isLoading: true,
                ),
                const SizedBox(height: 22),
                Row(
                  children: const [
                    SkeletonWidget(
                      width: 56,
                      height: 28,
                      isLoading: true,
                    ),
                    SizedBox(width: 39),
                    SkeletonWidget(
                      width: 112,
                      height: 28,
                      isLoading: true,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
