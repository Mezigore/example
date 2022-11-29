import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Аналог IconButton только с Svg картинкой
class SvgIconButton extends StatelessWidget {
  const SvgIconButton(
    this.assetName, {
    @required this.onTap,
    Key key,
    this.iconSize,
    this.iconColor,
    double width = 44,
    double height = 44,
  })  : width = width ?? 44,
        height = height ?? 44,
        super(key: key);

  /// Пусть к картинге в svg формате
  final String assetName;

  /// Ширина кнопки
  final double width;

  /// Высота кнопки
  final double height;

  /// Действие выполняется при нажатии
  final VoidCallback onTap;

  /// Размер иконки
  final double iconSize;

  /// Цвет иконки
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Center(
            child: SvgPicture.asset(
              assetName,
              color: iconColor,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
