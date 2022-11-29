import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет цены продукта.
class ProductPriceWidget extends StatelessWidget {
  const ProductPriceWidget({
    this.price,
    this.measureUnit,
    this.fontSize,
    Key key,
  }) : super(key: key);

  /// Цена
  final String price;

  /// Порции
  final String measureUnit;

  /// Размер шрифта прайса, если нужно изменить по умолчанию
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = fontSize == null
        ? textMedium24
        : textMedium24.copyWith(fontSize: fontSize);

    return RichText(
      text: TextSpan(
        text: '$price\n',
        style: textStyle,
        children: [
          TextSpan(
            text: measureUnit,
            style: textRegular12Secondary,
          ),
        ],
      ),
    );
  }
}
