// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <MenuItemButtonWidget>
class MenuItemButtonWidgetModel extends WidgetModel {
  MenuItemButtonWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._dialogController, {
    @required CartManager cartManager,
    @required CartElement cartElement,
    bool needDeleteDialog,
    this.needAccentColor = false,
  })  : assert(cartElement != null),
        assert(cartManager != null),
        assert(needAccentColor != null),
        _needDeleteDialog = needDeleteDialog ?? false,
        _cartManager = cartManager,
        _cartElement = cartElement,
        super(baseDependencies);

  final bool needAccentColor;
  final DefaultDialogController _dialogController;
  final bool _needDeleteDialog;
  final CartElement _cartElement;

  /// Менеджер работы с корзиной.
  final CartManager _cartManager;

  /// Добавить в корзину [+1]
  final addPortionAction = Action<void>();

  /// Убрать из корзину [-1]
  final removePortionAction = Action<void>();

  final countState = StreamedState<int>(0);

  CartElement get cartElement => _cartElement;

  @override
  void onLoad() {
    super.onLoad();
    _init();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<void>(addPortionAction.stream, (_) => _addProduct());
    subscribe<void>(removePortionAction.stream, (_) => _removeProduct());
  }

  void _init() {
    // получаем текущее состояние корзины для выбранного продукта
    _updateCount();
    // подписываемся на изменения в корзине
    _cartManager.positiveListNotifier.addListener(_updateCount);
  }

  void _updateCount() {
    final newCount =
        _cartManager.positiveListNotifier.value[_cartElement.id] ?? 0;
    if (newCount != countState.value) {
      countState.accept(newCount);
    }
  }

  void _addProduct() {
    if (_cartManager.cartState.value.data.promoname == null) {
      _cartManager.addToCart(_cartElement);
      AppMetrica.reportEventWithMap('add_to_cart', <String, String>{'id': _cartElement.id});
    }
  }

  Future<void> _removeProduct() async {
    if (countState.value > 0) {
      if (_needDeleteDialog && countState.value == _cartElement.ratio) {
        final isAccepted = await _dialogController.showAcceptBottomSheet(
          cartDeleteDishTitle,
          agreeText: deleteDialogAgree,
          cancelText: deleteDialogCancel,
        );
        if (!isAccepted) return;
      }
      _cartManager.removeFromCart(_cartElement);
    }
  }

  @override
  void dispose() {
    _cartManager.positiveListNotifier.removeListener(_updateCount);
    super.dispose();
  }
}
