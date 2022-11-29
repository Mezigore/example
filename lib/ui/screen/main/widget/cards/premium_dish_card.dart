import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_widget.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/card.dart';
import 'package:uzhindoma/ui/widget/product/product_card_title.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/widget/product/product_label.dart';
import 'package:uzhindoma/ui/widget/product/product_main_label.dart';
import 'package:uzhindoma/ui/widget/product/product_two_price.dart';

/// Карточка с премиумным блюдом
class PremiumDishCard extends StatelessWidget {
  const PremiumDishCard({
    @required this.menuItem,
    Key key,
  }) : super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
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
            _ImageProductWidget(
              imagePath: menuItem.previewImg,
            ),
            _InfoProductWidget(menuItem: menuItem),
          ],
        ),
      ),
    );
  }
}

class _ImageProductWidget extends StatelessWidget {
  const _ImageProductWidget({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  final String imagePath;

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
        child: ClipPath(
          clipper: _ImageCustomClipper(),
          child: ProductImageWidget(
            urlImage: imagePath,
          ),
        ),
      ),
    );
  }
}

/// Клипер обрезает фото с низу овалом
class _ImageCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(
        size.width - size.width / 8,
        size.height - 20,
        size.width / 2,
        size.height - 20,
      )
      ..quadraticBezierTo(
        size.width / 8,
        size.height - 20,
        0,
        size.height,
      )
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _InfoProductWidget extends StatelessWidget {
  const _InfoProductWidget({
    Key key,
    @required this.menuItem,
  })  : assert(menuItem != null),
        super(key: key);

  final MenuItem menuItem;

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
          const SizedBox(height: 20),
          _LabelWidget(
            labels: menuItem.properties.labels,
          ),
          SizedBox(height: menuItem == null ? 12 : 16),
          ProductInfoWidget(
            cookingTime: menuItem.properties?.cookTimeUi,
            portion: menuItem.properties.portionUi,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductTwoPriceWidget(
                menuItem: menuItem,
              ),
              MenuItemButtonWidget(
                needAccentColor: true,
                cartElement: menuItem,
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// Виджет с лейблами для премиум продукта
class _LabelWidget extends StatelessWidget {
  const _LabelWidget({Key key, this.labels}) : super(key: key);

  final List<MenuItemLabel> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.85,
      height: 25,
      child: ListView(
        scrollDirection: Axis.horizontal,
        // mainAxisSize: MainAxisSize.min,
        children: [
          LabelWidget(
            label: premiumPremiumDishCardWidgetText,
            backgroundColor: premiumMainLabelBackgroundColor,
            textColor: white,
            leading: Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: SvgPicture.asset(
                icCrown,
                height: 16,
                width: 16,
              ),
            ),
          ),
          ...labels
              .map(
                (label) => _PremiumLabel(
                  label: label.title,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _PremiumLabel extends StatelessWidget {
  const _PremiumLabel({
    Key key,
    @required this.label,
  })  : assert(label != null),
        super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: LabelWidget(
        label: label,
        backgroundColor: transparent,
        borderColor: premiumLabelBorderColor,
        textColor: textColorPrimary,
      ),
    );
  }
}
