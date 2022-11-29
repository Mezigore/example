import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';

/// Заглушка для карточки корзины
class CartItemPlaceholder extends StatelessWidget {
  const CartItemPlaceholder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        child: Row(
          children: [
            const SkeletonWidget(
              height: 112,
              width: 112,
              isLoading: true,
              radius: 12,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonWidget(
                    height: 12,
                    width: 168,
                    isLoading: true,
                    radius: 16,
                  ),
                  const SizedBox(height: 10),
                  const SkeletonWidget(
                    height: 12,
                    width: 192,
                    isLoading: true,
                    radius: 16,
                  ),
                  const SizedBox(height: 10),
                  const SkeletonWidget(
                    height: 12,
                    width: 136,
                    isLoading: true,
                    radius: 16,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SkeletonWidget(
                        width: 56,
                        height: 28,
                        isLoading: true,
                        radius: 16,
                      ),
                      SkeletonWidget(
                        width: 96,
                        height: 28,
                        isLoading: true,
                        radius: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
