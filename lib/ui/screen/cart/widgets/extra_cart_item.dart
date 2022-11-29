import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/ui/common/widgets/svg_icon_button.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';

/// Виджет с дополнительным элементом для корзины
class ExtraCartItemWidget extends StatelessWidget {
  const ExtraCartItemWidget({
    Key key,
    @required this.item,
    this.onDeletePress,
  })  : assert(item != null),
        super(key: key);

  /// дополнительный элемент корзины
  final ExtraItem item;

  final VoidCallback onDeletePress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageWidget(imageUrl: item.previewImg),
            const SizedBox(width: 16),
            Expanded(
              child: _InfoProductExtraWidget(
                item: item,
              ),
            ),
            _DeleteButton(
              onTap: onDeletePress,
            ),
          ],
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({Key key, this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SvgIconButton(
      icDelete,
      onTap: onTap,
      iconSize: 24,
      height: 24,
      width: 24,
      iconColor: iconColor,
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
  })  : assert(item != null),
        super(key: key);
  final ExtraItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _TitleExtraProduct(title: item.name),
        const SizedBox(height: 11),
        _ExtraCardPrice(price: item.priceTitle),
      ],
    );
  }
}

class _TitleExtraProduct extends StatelessWidget {
  const _TitleExtraProduct({
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

class _ExtraCardPrice extends StatelessWidget {
  const _ExtraCardPrice({
    Key key,
    @required this.price,
  })  : assert(price != null),
        super(key: key);
  final String price;

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: textMedium18,
    );
  }
}
