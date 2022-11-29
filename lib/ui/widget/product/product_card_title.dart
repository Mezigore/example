import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/const.dart';

/// титл виджет для карточек
class ProductCardTitle extends StatelessWidget {
  const ProductCardTitle({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: _getPadding(context)),
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textMedium16,
      ),
    );
  }

  double _getPadding(BuildContext context) {
    if (MediaQuery.of(context).size.width < smallPhoneWidth) {
      return 0.0;
    } else {
      return 16.0;
    }
  }
}
