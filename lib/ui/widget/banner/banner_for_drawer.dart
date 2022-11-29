import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/util/const.dart';

/// Баннер для Drawer
class BannerForTheDrawerWidget extends StatelessWidget {
  const BannerForTheDrawerWidget({
    String title,
    String textBanner,
    IconData iconData,
    Key key,
  })  : _iconData = iconData,
        _title = title,
        _textBanner = textBanner,
        super(key: key);

  /// Иконка
  final IconData _iconData;

  /// Заголовок баннера
  final String _title;

  /// Текст баннера
  final String _textBanner;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: bannerPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          if (_iconData != null) Icon(_iconData),
          //todo без макета, проверить отступ
          if (_iconData != null) const SizedBox(width: 8),
          Flexible(
            child: _TextBannerWidget(
              title: _title,
              textBanner: _textBanner,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}

class _TextBannerWidget extends StatelessWidget {
  const _TextBannerWidget({
    Key key,
    this.title,
    this.textBanner,
  }) : super(key: key);

  final String title;
  final String textBanner;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title ?? emptyString,
          style: textMedium14,
        ),
        const SizedBox(height: 4),
        Text(
          textBanner ?? emptyString,
          style: textRegular14Hint,
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}
