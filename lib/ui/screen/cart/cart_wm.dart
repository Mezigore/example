import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/cart/cart_screen.dart';

/// [WidgetModel] for [CartScreen]
class CartWidgetModel extends WidgetModel {
  CartWidgetModel(
    WidgetModelDependencies dependencies,
    this.navigator,
    this._cartManager,
    this._dialogController,
    this._menuManager,
    this.cartRoute,
    this._messageController,
  ) : super(dependencies);

  final NavigatorState navigator;
  final Route cartRoute;
  final CartManager _cartManager;
  final MenuManager _menuManager;
  final DefaultDialogController _dialogController;
  final MessageController _messageController;

  final clearCartAction = Action<void>();
  final onItemTapAction = Action<CartItem>();
  final extraItemDeleteAction = Action<ExtraItem>();

  EntityStreamedState<Cart> get cartState => _cartManager.cartState;

  @override
  void onLoad() {
    super.onLoad();
    _subscribeForCartState();
    subscribe(_cartManager.errorStream, handleError);
  }

  @override
  void onBind() {
    super.onBind();
    bind(onItemTapAction, _openItemScreen);
    bind(extraItemDeleteAction, _deleteExtraItem);
    bind<void>(clearCartAction, (_) => _clearCart());
  }

  Future<void> _clearCart() async {
    if ((cartState.value?.isLoading ?? true) ||
        cartState?.value?.data == null) {
      return;
    }
    final isAccepted = await _dialogController.showAcceptBottomSheet(
      cartClearTitle,
      agreeText: deleteDialogAgree,
      cancelText: deleteDialogCancel,
    );
    if (isAccepted) _cartManager.clearCart();
  }

  void _openItemScreen(CartItem item) {
    final menuItem = _menuManager.getMenuItemById(item.id);
    if (menuItem == null) {
      _messageController.show(
        msgType: MsgType.common,
        msg: badResponseErrorMessage,
      );
    } else {
      navigator.pushNamed(AppRouter.cartItemInfoScreen, arguments: menuItem);
    }
  }

  void _subscribeForCartState() {
    subscribe<EntityState<Cart>>(
      cartState.stream,
      (entity) {
        /// В случае очистки корзины или удаления последнего продукта удаляем роут экрана
        ///
        if (entity?.data?.menu?.isEmpty ?? false) {
          navigator.removeRoute(cartRoute);
        }
      },
    );
  }

  void _deleteExtraItem(ExtraItem item) {
    _cartManager.removeExtra(item.id);
  }
}
