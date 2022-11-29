import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/base/history_item.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/util/const.dart';

/// Карточка завершенного заказа
class CompletedOrderWidget extends StatelessWidget {
  const CompletedOrderWidget({
    Key key,
    @required this.order,
    this.onRateTap,
  })  : assert(order != null),
        super(key: key);

  /// Нажатие на кнопку оценить
  final VoidCallback onRateTap;

  /// Заказ
  final OrderFromHistory order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.orderNumberTitle, style: textMedium16),
              Text(order.orderDateTitle, style: textRegular12Secondary),
            ],
          ),
          const SizedBox(height: 16),
          _Images(
            items: [
              if (order.itemsFromHistory != null) ...order.itemsFromHistory,
              if (order.extraItemsFromHistory != null)
                ...order.extraItemsFromHistory,
            ],
          ),
          if (!order.isRated && (order.canBeRated ?? false))
            Container(
              margin: const EdgeInsets.only(top: 24),
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRateTap,
                child: const Text(orderRateBtn),
              ),
            ),
        ],
      ),
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({
    Key key,
    @required this.items,
  })  : assert(items != null),
        super(key: key);
  final List<HistoryItem> items;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < smallPhoneWidth;
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmall ? 4 : 5,
        mainAxisSpacing: 7,
        crossAxisSpacing: 8,
      ),
      children: items.map((item) => _DishPicture(item: item)).toList(),
    );
  }
}

class _DishPicture extends StatelessWidget {
  const _DishPicture({Key key, this.item}) : super(key: key);

  final HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: item.isRated ? 0.5 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ProductImageWidget(urlImage: item.img),
          ),
        ),
        if (item.isRated)
          Positioned(
            bottom: -6,
            left: -6,
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                item.itemRating.toString(),
                style: textMedium12Hint,
              ),
            ),
          )
      ],
    );
  }
}
