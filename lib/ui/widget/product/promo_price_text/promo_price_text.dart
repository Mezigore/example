import 'package:flutter/material.dart' hide MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/widget/product/promo_price_text/di/promo_price_text_component.dart';
import 'package:uzhindoma/ui/widget/product/promo_price_text/promo_price_text_wm.dart';

/// Промо текст для виджета Две цены на ужинах
class PromoPriceTextWidget extends MwwmWidget<PromoPriceTextComponent> {
  PromoPriceTextWidget({
    @required MenuItem menuItem,
    Key key,
  }) : super(
          widgetModelBuilder: (context) => createPromoPriceTextWidgetModel(
            context,
            menuItem,
          ),
          dependenciesBuilder: (context) => PromoPriceTextComponent(context),
          widgetStateBuilder: () => _PromoPriceTextWidgetState(),
          key: key,
        );
}

class _PromoPriceTextWidgetState
    extends WidgetState<PromoPriceTextWidgetModel> {
  @override
  Widget build(BuildContext context) {
    /// физическая ширина и высота экрана
    final _screenWidth = MediaQuery.of(context).size.width;

    return _screenWidth <= smallDevice
        ? _BuildPromoTextShort(
            price: wm.menuItem.price.toString(),
          )
        : _BuildPromoText(
            price: wm.menuItem.price.toString(),
            countState: wm.countState,
          );
  }
}

/// Короткий промо текст для нормальных экранов
class _BuildPromoText extends StatelessWidget {
  const _BuildPromoText({
    Key key,
    @required this.price,
    @required this.countState,
  }) : super(key: key);

  final String price;
  final StreamedState<int> countState;

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<int>(
        streamedState: countState,
        builder: (context, state) {
          return RichText(
            text: TextSpan(
              text: price,
              style: textMedium14,
              children: [
                TextSpan(
                  text: state == 0
                      ? mainScreenPromoText
                      : mainScreenPromoTextShort,
                  style: textRegular12Secondary,
                ),
              ],
            ),
          );
        });
  }
}

/// Короткий промо текст для маленьких экранов
class _BuildPromoTextShort extends StatelessWidget {
  const _BuildPromoTextShort({
    Key key,
    @required this.price,
  }) : super(key: key);

  final String price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: price,
        style: textMedium14,
        children: [
          TextSpan(
            text: mainScreenPromoTextShort,
            style: textRegular12Secondary,
          ),
        ],
      ),
    );
  }
}
