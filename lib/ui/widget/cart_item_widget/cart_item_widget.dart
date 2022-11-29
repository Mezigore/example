import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/common/loading_widget.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';

/// Виджет для отображения одного блюда в корзине
class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    Key key,
    @required this.item,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    bool isLoading,
  })  : assert(item != null),
        isLoading = isLoading ?? false,
        super(key: key);

  /// Блюдо
  final CartItem item;

  /// Отступы карточки
  final EdgeInsets padding;

  /// Нажатие на карточку
  final VoidCallback onTap;

  /// Идет ли загрузка
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: 160,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ImageWidget(imageUrl: item.previewImg),
                        const SizedBox(width: 16),
                        _InfoProductExtraWidget(
                          item: item,
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: dividerLightColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProductImageWidget(
          urlImage: imageUrl,
          boxFit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class _InfoProductExtraWidget extends StatelessWidget {
  const _InfoProductExtraWidget({
    Key key,
    @required this.item,
    this.isLoading = false,
  })  : assert(item != null),
        super(key: key);
  final CartItem item;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TitleProduct(title: item.name),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? LoadingWidget(
                        color: Theme.of(context).accentColor,
                      )
                    : _CartItemPrice(
                        price: item.priceTitle,
                        discountPrice: item.discountPriceTitle,
                      ),
                MenuItemButtonWidget(
                  cartElement: item,
                  needDeleteDialog: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleProduct extends StatelessWidget {
  const _TitleProduct({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: textRegular14,
    );
  }
}

class _CartItemPrice extends StatelessWidget {
  const _CartItemPrice({
    Key key,
    @required this.price,
    this.discountPrice,
  })  : assert(price != null),
        super(key: key);

  final String price;
  final String discountPrice;

  bool get _hasDiscount => discountPrice != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _hasDiscount ? discountPrice : price,
          style: textMedium18,
        ),
        if (_hasDiscount)
          Text(
            price,
            style: textRegular14Hint.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}
