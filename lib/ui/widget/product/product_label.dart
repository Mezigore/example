import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Виджет отображения лейбла
class LabelWidget extends StatelessWidget {
  const LabelWidget({
    Key key,
    @required this.label,
    @required this.backgroundColor,
    @required this.textColor,
    this.borderColor,
    this.leading,
  })  : assert(label != null),
        assert(backgroundColor != null),
        assert(textColor != null),
        super(key: key);

  LabelWidget.common({
    Key key,
    @required MenuItemLabel item,
  })  : assert(item != null),
        label = item.title,
        backgroundColor = item.labelColor,
        borderColor = null,
        textColor = item.textColor,
        leading = null,
        super(key: key);

  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: borderColor ?? transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            if (leading != null) leading,
            SizedBox(
              height: 16.0,
              child: Center(
                child: Text(
                  label.toUpperCase(),
                  style: textMedium9.copyWith(
                    color: textColor,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
