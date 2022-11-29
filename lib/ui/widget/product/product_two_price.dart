import 'package:flutter/material.dart' hide MenuItem;
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/promo_price_text/promo_price_text.dart';

/// Виджет две цены на ужинах (при заказе от 5 блюд).
class ProductTwoPriceWidget extends StatelessWidget {
  const ProductTwoPriceWidget({
    @required this.menuItem,
    @required this.categoryName,
    this.fontSize,
    Key key,
  })  : assert(menuItem != null),/*assert(categoryName != null),*/
        super(key: key);

  /// Блюдо
  final MenuItem menuItem;

  /// Название категории
  final String categoryName;

  /// Размер шрифта прайса, если нужно изменить по умолчанию
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = fontSize == null
        ? textMedium24
        : textMedium24.copyWith(fontSize: fontSize);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: categoryName == 'Ужины' ? menuItem.promoPrice.toString(): menuItem.price.toString(),
            style: textStyle,
            children: [
              TextSpan(
                text: ' /${menuItem.measureUnit}',
                style: textMedium14,
              ),
            ],
          ),
        ),
        if(categoryName == 'Ужины')...[
          PromoPriceTextWidget(menuItem: menuItem),
        ],
      ],
    );
  }
}
