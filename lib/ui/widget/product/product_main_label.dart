import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Основной лейбл.
class ProductMainLabelWidget extends StatelessWidget {
  const ProductMainLabelWidget({
    @required this.imageUrl,
    @required this.title,
    Key key,
  })  : assert(imageUrl != null),
        assert(title != null),
        super(key: key);

  /// Адресс картинки
  final String imageUrl;

  /// Текст лейбла
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          imageUrl,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 6),
        Text(
          title.toUpperCase(),
          style: textMedium9,
        ),
      ],
    );
  }
}
