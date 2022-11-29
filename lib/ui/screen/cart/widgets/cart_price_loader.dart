import 'package:flutter/widgets.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';

/// Заглушка стоимости заказа
class CartSumLoader extends StatelessWidget {
  const CartSumLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _SkeletonItem(width: 56),
            _SkeletonItem(width: 56),
          ],
        ),
        const SizedBox(height: 21),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _SkeletonItem(width: 140),
            _SkeletonItem(width: 88),
          ],
        ),
        const SizedBox(height: 21),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _SkeletonItem(width: 48),
            _SkeletonItem(width: 64),
          ],
        ),
      ],
    );
  }
}

class _SkeletonItem extends StatelessWidget {
  const _SkeletonItem({
    Key key,
    this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      height: 12,
      width: width,
      isLoading: true,
      radius: 8,
    );
  }
}
