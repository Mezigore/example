import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';

// ignore: always_use_package_imports
import 'di/discount_button_component.dart';
// ignore: always_use_package_imports
import 'discount_button_wm.dart';

const double _splashRadius = 20.0;
const double _discountButtonRadius = 30.0;

/// Кнопка скидки
class DiscountButton extends MwwmWidget<DiscountButtonComponent> {
  DiscountButton({Key key, VoidCallback onPress})
      : super(
          widgetModelBuilder: createDiscountButtonWidgetModel,
          dependenciesBuilder: (context) => DiscountButtonComponent(
            context,
            onPress,
          ),
          widgetStateBuilder: () => _DiscountButtonState(),
          key: key,
        );
}

class _DiscountButtonState extends WidgetState<DiscountButtonWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: IconButton(
        splashRadius: _splashRadius,
        icon: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_discountButtonRadius),
              color: mainAppBarDiscountBackground),
          width: _discountButtonRadius,
          height: _discountButtonRadius,
          child: Center(
            child: StreamedStateBuilder<String>(
              streamedState: wm.labelState,
              builder: (ctx, label) {
                return Text(
                  label,
                  style: textRegular14White,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                );
              },
            ),
          ),
        ),
        onPressed: wm.pressAction,
      ),
    );
  }
}
