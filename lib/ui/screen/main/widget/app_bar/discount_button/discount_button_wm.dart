import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <DiscountButton>
class DiscountButtonWidgetModel extends WidgetModel {
  DiscountButtonWidgetModel(
    WidgetModelDependencies dependencies,
    this._cartManager,
    this._onPress,
  ) : super(dependencies);

  final CartManager _cartManager;
  final VoidCallback _onPress;

  final labelState = StreamedState<String>(ellipsisText);
  final pressAction = Action<void>();

  bool _isLocked = true;

  @override
  void onBind() {
    super.onBind();

    bind<void>(
      pressAction,
      (_) {
        _handlePress();
      },
    );

    subscribe<EntityState<Cart>>(
      _cartManager.cartState.stream,
      _updateCartState,
    );
  }

  void _handlePress() {
    if (!_isLocked) {
      _onPress?.call();
    }
  }

  void _updateCartState(EntityState<Cart> state) {
    final discount = state?.data?.discount;
    if (discount == null) {
      _isLocked = true;
      labelState.accept(ellipsisText);
    } else {
      _isLocked = false;
      labelState.accept(getDiscountText(discount));
    }
  }
}
