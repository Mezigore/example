import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/widget/product/product_price.dart';

/// Карточка дополнительного блюда
class ExtraDishCard extends StatelessWidget {
  const ExtraDishCard({
    @required this.menuItem,
    Key key,
  })  : assert(menuItem != null),
        super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              _ImageWidget(
                imageUrl: menuItem.previewImg,
                mainLabel: menuItem.properties?.mainLabel?.imageUrl,
              ),
              const SizedBox(width: 12),
              _InfoProductExtraWidget(
                menuItem: menuItem,
              ),
            ],
          ),
        ),
        const Divider(
          color: dividerLightColor,
          thickness: 1,
          height: 1,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key key,
    @required this.imageUrl,
    this.mainLabel,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;
  final String mainLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: ProductImageWidget(
              urlImage: imageUrl,
              boxFit: BoxFit.fitHeight,
            ),
          ),
          if (mainLabel != null)
            Positioned(
              top: 8,
              left: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Container(
                    color: white,
                    alignment: Alignment.center,
                    child: Image.network(
                      mainLabel,
                      colorBlendMode: BlendMode.srcATop,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const SizedBox.shrink(),
                      errorBuilder: (context, _, __) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InfoProductExtraWidget extends StatelessWidget {
  const _InfoProductExtraWidget({
    Key key,
    @required this.menuItem,
  })  : assert(menuItem != null),
        super(key: key);
  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleExtraProduct(title: menuItem.name),
          const SizedBox(height: 12),
          ProductInfoWidget(
            cookingTime: menuItem.properties.cookTimeUi,
            portion: menuItem.properties.portionUi,
            fontSize: 12,
            iconSize: 16,
          ),
          const SizedBox(height: 14),
          _ExtraCardPrice(menuItem: menuItem),
        ],
      ),
    );
  }
}

class _ExtraCardPrice extends StatelessWidget {
  const _ExtraCardPrice({
    Key key,
    @required this.menuItem,
  })  : assert(menuItem != null),
        super(key: key);
  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductPriceWidget(
          price: menuItem.priceUi,
          measureUnit: menuItem.measureUnit,
          fontSize: 18,
        ),
        MenuItemButtonWidget(
          cartElement: menuItem,
        ),
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
