import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/card.dart';
import 'package:uzhindoma/ui/widget/product/product_card_title.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/widget/product/product_label.dart';
import 'package:uzhindoma/ui/widget/product/product_main_label.dart';
import 'package:uzhindoma/ui/widget/product/product_two_price.dart';

/// Карточка основного блюда
class CommonDishCard extends StatelessWidget {
  const CommonDishCard({
    @required this.menuItem,
    @required this.categoryName,
    Key key,
  }) : super(key: key);

  final MenuItem menuItem;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final labels = menuItem.properties?.labels;

    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 8.0,
        left: 20.0,
        right: 20.0,
      ),
      child: CardWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _ImageWidget(imageUrl: menuItem.previewImg),
                if (labels != null)
                  Positioned(
                    bottom: 8,
                    left: 16,
                    child: _LabelList(
                      list: labels,
                    ),
                  )
              ],
            ),
            _InfoProductWidget(menuItem: menuItem,categoryName: categoryName),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 222,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: ProductImageWidget(
          urlImage: imageUrl,
        ),
      ),
    );
  }
}

class _InfoProductWidget extends StatelessWidget {
  const _InfoProductWidget({
    Key key,
    @required this.menuItem,
    @required this.categoryName,
  })  : assert(menuItem != null),
        assert(categoryName != null),
        super(key: key);

  final MenuItem menuItem;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          if (menuItem.properties?.mainLabel != null)
            Column(
              children: [
                ProductMainLabelWidget(
                  imageUrl: menuItem.properties.mainLabel.imageUrl,
                  title: menuItem.properties.mainLabel.title,
                ),
                const SizedBox(height: 6),
              ],
            ),
          ProductCardTitle(title: menuItem.name),
          SizedBox(height: menuItem == null ? 12 : 16),
          ProductInfoWidget(
            cookingTime: menuItem.properties?.cookTimeUi,
            portion: menuItem.properties?.portionUi,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductTwoPriceWidget(
                menuItem: menuItem,
                  categoryName:categoryName,
              ),
              MenuItemButtonWidget(
                cartElement: menuItem,
                needAccentColor: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _LabelList extends StatelessWidget {
  const _LabelList({
    Key key,
    @required this.list,
  })  : assert(list != null),
        super(key: key);

  final List<MenuItemLabel> list;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: list
          .map(
            (label) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: LabelWidget.common(item: label),
            ),
          )
          .toList(),
    );
  }
}
