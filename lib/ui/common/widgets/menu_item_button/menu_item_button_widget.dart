import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/di/menu_item_button_component.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_item_button_wm.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

/// Кнопка добавления порций
class MenuItemButtonWidget extends MwwmWidget<MenuItemButtonComponent> {
  MenuItemButtonWidget({
    Key key,
    CartElement cartElement,
    bool needAccentColor = false,
    bool needDeleteDialog = false,
  }) : super(
          widgetModelBuilder: (context) => createMenuItemButtonWidgetModel(
            context,
            cartElement,
            needAccentColor: needAccentColor,
            needDeleteDialog: needDeleteDialog,
          ),
          dependenciesBuilder: (context) => MenuItemButtonComponent(context),
          widgetStateBuilder: () => _MenuItemButtonWidgetState(),
          key: key,
        );
}

class _MenuItemButtonWidgetState extends WidgetState<MenuItemButtonWidgetModel>
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
    if (wm.countState.value > 0) {
      controller.animateTo(1);
    }

    _animationEventListener = wm.countState.stream.listen((count) {
      // если счетчик больше 0, то запускаем анимацию
      count != 0 ? controller.forward() : controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Container(
        color: colorTween.value,
        height: 40,
        width: sizerTween.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _VisibilityWidget(
              opacityTween: opacityTween.value,
              child: _ButtonWidget(
                iconData: Icons.remove,
                voidCallback: wm.removePortionAction,
                iconColorValue: iconColorTween.value,
              ),
            ),
            StreamedStateBuilder<int>(
              streamedState: wm.countState,
              builder: (context, count) {
                return _VisibilityWidget(
                  opacityTween: opacityTween.value,
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: textMedium18,
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _ButtonWidget(
                iconData: Icons.add,
                voidCallback: wm.addPortionAction,
                iconColorValue: iconColorTween.value,
                iconRotateTweenValue: iconRotateTween.value,
              ),
            ),
          ],
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
