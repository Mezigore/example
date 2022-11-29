import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Информация о времени приготовления и весе порций.
class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({
    this.cookingTime,
    this.portion,
    this.fontSize,
    double iconSize,
    Key key,
  })  : _iconSize = iconSize ?? 24,
        super(key: key);

  /// Время приготовления
  final String cookingTime;

  /// Порции
  final String portion;

  /// Размер шрифта прайса, если нужно изменить по умолчанию
  final double fontSize;

  final double _iconSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = fontSize == null
        ? textRegular14Hint
        : textRegular14Hint.copyWith(fontSize: fontSize);

    return Row(
      children: [
        SvgPicture.asset(
          icTime,
          width: _iconSize,
          height: _iconSize,
        ),
        const SizedBox(width: 8),
        Text(
          cookingTime ?? ellipsisText,
          style: textStyle,
        ),
        const SizedBox(width: 20),
        SvgPicture.asset(
          icPortion,
          width: 24,
          height: 24,
        ),
        const SizedBox(width: 8),
        Text(
          portion ?? ellipsisText,
          style: textStyle,
        ),
      ],
    );
  }
}
