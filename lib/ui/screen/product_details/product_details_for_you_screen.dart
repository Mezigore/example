import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/domain/catalog/menu/properties_menu_item.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';
import 'package:uzhindoma/ui/widget/product/product_label.dart';
import 'package:uzhindoma/ui/widget/product/product_main_label.dart';

/// Подробная информация о продукте
class ProductDetailsForYouScreen extends StatelessWidget {
  const ProductDetailsForYouScreen({
    Key key,
    @required this.menuItem,
  })  : assert(menuItem != null),
        super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _ProductImageWidget(
            url: menuItem.detailImg,
            labels: menuItem.properties.labels,
          ),
          _ProductInfoDetailsWidget(
            menuItem: menuItem,
          ),
        ],
      ),
    );
  }
}

class _ProductImageWidget extends StatelessWidget {
  const _ProductImageWidget({
    Key key,
    @required this.url,
    this.labels,
  }) : super(key: key);

  final String url;
  final List<MenuItemLabel> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ProductImageWidget(
            urlImage: url,
          ),
          Positioned(
            bottom: 8,
            left: 20,
            child: _LabelList(
              list: labels,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductInfoDetailsWidget extends StatelessWidget {
  const _ProductInfoDetailsWidget({
    Key key,
    @required this.menuItem,
  }) : super(key: key);

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          if (menuItem.properties.mainLabel != null)
            ProductMainLabelWidget(
              imageUrl: menuItem.properties.mainLabel?.imageUrl,
              title: menuItem.properties.mainLabel?.title,
            ),
          if (menuItem.properties.mainLabel != null) const SizedBox(height: 8),
          Text(
            menuItem.name,
            style: textMedium18,
          ),
          const SizedBox(height: 20),
          ProductInfoWidget(
            cookingTime: menuItem.properties?.cookTimeUi,
            portion: menuItem.properties?.portionUi,
            fontSize: 14,
          ),
          const SizedBox(height: 6),
          if (menuItem.properties?.prepareComment != null)
            _WhenToCookWidget(
              prepareComment: menuItem.properties?.prepareComment,
            ),
          // menuItem.properties?.prepareComment == null
          //     ? const _Divider(heightTop: 0, heightBottom: 14)
          //     : const _Divider(heightTop: 24, heightBottom: 14),
          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     menuItem.promoPrice != null
          //         ? ProductTwoPriceWidget(
          //       menuItem: menuItem,
          //     )
          //         : ProductPriceWidget(
          //       price: menuItem.priceUi,
          //       measureUnit: menuItem.measureUnit,
          //     ),
          //     const Spacer(),
          //     MenuItemButtonWidget(
          //       needAccentColor: true,
          //       cartElement: menuItem,
          //     ),
          //   ],
          // ),
          const _Divider(heightTop: 16, heightBottom: 17),
          _BguWidget(properties: menuItem.properties),
          const _Divider(heightTop: 21, heightBottom: 24),
          if (menuItem.properties.willDeliver != null &&
              menuItem.properties.willDeliver.isNotEmpty)
            _InfoWidget(
              title: weWillBringProductDetailsWidgetText,
              info: menuItem.properties.willDeliver,
            ),
          if (menuItem.properties.willDeliver != null &&
              menuItem.properties.willDeliver.isNotEmpty)
            const SizedBox(height: 24),
          if (menuItem.properties.youNeed != null &&
              menuItem.properties.youNeed.isNotEmpty)
            _InfoWidget(
              title: youWillNeedProductDetailsWidgetText,
              info: menuItem.properties.youNeed,
            ),
          const SizedBox(height: 120),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key key,
    this.heightTop,
    this.heightBottom,
  }) : super(key: key);

  final double heightTop;
  final double heightBottom;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: heightTop),
        const Divider(),
        SizedBox(height: heightBottom),
      ],
    );
  }
}

class _BguWidget extends StatelessWidget {
  const _BguWidget({
    Key key,
    this.properties,
  }) : super(key: key);
  final PropertiesMenuItem properties;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _BguInfoWidget(
          value: in100ProductDetailsWidgetText,
          type: productProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: properties.bguCal?.toString(),
          type: kcalProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: properties.bguProtein?.toString(),
          type: proteinProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: properties.bguFat?.toString(),
          type: fatProductDetailsWidgetText,
        ),
        _BguInfoWidget(
          value: properties.bguCarb?.toString(),
          type: carbsProductDetailsWidgetText,
        ),
      ],
    );
  }
}

/// За какое время нужно приготовить продукт
class _WhenToCookWidget extends StatelessWidget {
  const _WhenToCookWidget({
    Key key,
    @required this.prepareComment,
  }) : super(key: key);
  final String prepareComment;

  @override
  Widget build(BuildContext context) {
    return Text(
      prepareComment,
      textAlign: TextAlign.left,
      style: textRegular12Secondary,
    );
  }
}

/// Дополнительная информация о продукте
class _InfoWidget extends StatelessWidget {
  const _InfoWidget({
    Key key,
    @required this.title,
    @required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textMedium16,
        ),
        const SizedBox(height: 8),
        Text(
          (info == null || info.isEmpty) ? ellipsisText : info,
          style: textRegular14,
        ),
      ],
    );
  }
}

/// БЖУ продукта
class _BguInfoWidget extends StatelessWidget {
  const _BguInfoWidget({
    Key key,
    this.value,
    this.type,
  }) : super(key: key);
  final String value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value ?? ellipsisText,
          style: textMedium14Secondary,
        ),
        Text(
          type,
          style: textRegular12Secondary,
        ),
      ],
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

