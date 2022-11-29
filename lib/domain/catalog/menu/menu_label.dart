import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';

/// Свойства главного (праздничного) лейбла блюда.
/// [title] - текст лейбла.
/// [imageUrl] - ссылка на иконку.
class MenuItemMainLabel {
  MenuItemMainLabel(
    this.title,
    this.imageUrl,
  )   : assert(title != null),
        assert(imageUrl != null);

  final String title;
  final String imageUrl;
}

/// Свойства лейбла блюда.
/// [title] - текст лейбла.
/// [_labelColor] - цвет в формате HEX с прозрачностью.
/// [_textColor] - цвет в формате HEX с прозрачностью.
class MenuItemLabel {
  MenuItemLabel(
    this.title,
    this._labelColor,
    this._textColor,
  )   : assert(title != null),
        assert(_labelColor != null),
        assert(_textColor != null);

  final String title;
  final String _labelColor;
  final String _textColor;

  /// Цвет текста
  Color get textColor {
    final value = int.tryParse(_textColor);
    return value != null ? Color(value) : textColorPrimary;
  }

  /// Цвет лейбла
  Color get labelColor {
    final value = int.tryParse(_labelColor);
    return value != null ? Color(value) : white;
  }
}
