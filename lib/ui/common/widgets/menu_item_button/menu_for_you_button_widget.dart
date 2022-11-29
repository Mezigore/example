import 'dart:async';
import 'dart:math';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/di/menu_for_you_item_button_component.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_for_you_item_button_wm.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Кнопка добавления порций
class MenuForYouButtonWidget extends MwwmWidget<MenuForYouItemButtonComponent> {
  MenuForYouButtonWidget({
    Key key,
    List<CartElement> cartElements,
    CategoryItem category,
    bool needAccentColor = false,
    bool needDeleteDialog = false,
  }) : super(
          widgetModelBuilder: (context) =>
              createMenuForYouItemButtonWidgetModel(
            context,
            cartElements,
            category,
            needAccentColor: needAccentColor,
            needDeleteDialog: needDeleteDialog,
          ),
          dependenciesBuilder: (context) =>
              MenuForYouItemButtonComponent(context),
          widgetStateBuilder: () => _MenuForYouItemButtonWidgetState(),
          key: key,
        );
}

class _MenuForYouItemButtonWidgetState
    extends WidgetState<MenuForYouItemButtonWidgetModel>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Color> colorTween;
  Animation<double> sizerTween;
  Animation<Color> iconColorTween;
  Animation<double> iconRotateTween;
  Animation<double> opacityTween;
  StreamSubscription _animationEventListener;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: slowAnimation,
    );

    _setupAnim();
  }

  void _setupAnim() {
    /// анимацию делим на 2 части
    final curvedBegin = CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.5),
    );

    final curvedEnd = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1),
    );

    colorTween = ColorTween(
      begin: wm.needAccentColor ? colorAccent : elevatedButtonPrimary,
      end: elevatedButtonPrimary,
    ).animate(curvedBegin);

    iconColorTween = ColorTween(
      begin: wm.needAccentColor ? white : colorAccent,
      end: colorAccent,
    ).animate(curvedBegin);

    sizerTween = Tween<double>(begin: 40, end: 112).animate(curvedBegin);

    iconRotateTween =
        Tween<double>(begin: pi, end: pi + pi / 2).animate(curvedBegin);
    opacityTween = Tween<double>(begin: 0, end: 1).animate(curvedEnd);

    controller.addListener(() {
      setState(() {});
    });

    // если в корзине уже добавлено, сразу показываем открытый button
    if (wm.countState.value == true) {
      controller.animateTo(1);
    }

    _animationEventListener = wm.countState.stream.listen((count) {
      // если счетчик больше 0, то запускаем анимацию
      count == true ? controller.forward() : controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            primary: colorTween.value, //cartButtonBackgroundColor,
            elevation: 0,
            onSurface: colorAccent,
          ),
          onPressed: () {
            if (!wm.countState.value) {
              wm.addPortionAction();
            }
            AppMetrica.reportEvent('forus_click');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Заказать 5 ужинов',
                    style: textRegular16White.copyWith(
                        color: iconColorTween.value)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (true)
                      Text(
                        wm.price(),
                        style: textRegular12WhiteOpacityCross.copyWith(
                            color: iconColorTween.value),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        wm.discountPrice(),
                        style: textRegular16White.copyWith(
                            color: iconColorTween.value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _animationEventListener.cancel();
    super.dispose();
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({
    Key key,
    @required this.iconData,
    @required this.voidCallback,
    @required this.iconColorValue,
    this.iconRotateTweenValue,
  })  : assert(iconData != null),
        assert(voidCallback != null),
        super(key: key);

  final IconData iconData;
  final VoidCallback voidCallback;
  final Color iconColorValue;
  final double iconRotateTweenValue;

  /// Цвет кнопки
  static const Set<MaterialState> _interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  Color _getColor(Set<MaterialState> states) =>
      states.any(_interactiveStates.contains) ? pressedButton : colorAccent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          overlayColor: MaterialStateProperty.resolveWith(_getColor),
          onTap: voidCallback,
          child: Transform.rotate(
            angle: iconRotateTweenValue ?? 0,
            child: Icon(
              iconData,
              color: iconColorValue,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _VisibilityWidget extends StatelessWidget {
  const _VisibilityWidget({
    Key key,
    this.child,
    @required this.opacityTween,
  })  : assert(opacityTween != null),
        super(key: key);

  final Widget child;
  final double opacityTween;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: opacityTween > 0,
      child: Opacity(
        opacity: opacityTween,
        child: child,
      ),
    );
  }
}
