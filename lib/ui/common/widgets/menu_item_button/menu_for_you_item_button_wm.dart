import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart_element.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';


/// [WidgetModel] для <MenuItemButtonWidget>
class MenuForYouItemButtonWidgetModel extends WidgetModel {
  MenuForYouItemButtonWidgetModel(
    WidgetModelDependencies baseDependencies,
    this._dialogController, {
    @required CartManager cartManager,
    @required List<CartElement> cartElements,
    @required CategoryItem categoryItem,
    bool needDeleteDialog,
    this.needAccentColor = false,
  })  : assert(cartElements != null),
        assert(cartManager != null),
        assert(needAccentColor != null),
        _needDeleteDialog = needDeleteDialog ?? false,
        _cartManager = cartManager,
        _cartElements = cartElements,
        _categoryItem = categoryItem,
        super(baseDependencies);

  final bool needAccentColor;
  final DefaultDialogController _dialogController;
  final bool _needDeleteDialog;
  final List<CartElement> _cartElements;
  final CategoryItem _categoryItem;

  /// Менеджер работы с корзиной.
  final CartManager _cartManager;

  /// Добавить в корзину [+1]
  final addPortionAction = Action<void>();

  /// Убрать из корзину [-1]
  final removePortionAction = Action<void>();

  final countState = StreamedState<bool>(false);

  List<CartElement> get cartElements => _cartElements;

  @override
  void onLoad() {
    super.onLoad();
    _init();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<void>(addPortionAction.stream, (_) => _addProduct());
  }

  void _init() {
    // получаем текущее состояние корзины для выбранного продукта
    _updateCount();
    // подписываемся на изменения в корзине
    _cartManager.positiveListNotifier.addListener(_updateCount);
  }

  void _updateCount() {
    final List<bool> check = [];
    for (int i = 0; i < _cartElements.length; i++) {
      if (_cartManager.positiveListNotifier.value[_cartElements[i].id] !=
          null) {
        check.add(true);
      } else {
        check.add(false);
      }
    }
    countState.accept(!check.contains(false));
  }

  String price() {
    int price = 0;
    for (int i = 0; i < _categoryItem.products.length; i++) {
      price = price + _categoryItem.products[i].price;
    }
    return '${(price * 2).toString()} ₽';
  }

  String discountPrice() {
    int discountPrice = 0;
    for (int i = 0; i < _categoryItem.products.length; i++) {
      discountPrice =
          discountPrice + (_categoryItem.products[i].price * 0.83).round();
    }
    return '${(discountPrice * 2).toString()} ₽';
  }

  void _addProduct() {
    for (int i = 0; i < _categoryItem.products.length; i++) {
      _cartManager.addToCart(_categoryItem.products[i]);
      AppMetrica.reportEventWithMap(
          'add_to_cart', <String, String>{'id': _categoryItem.products[i].id});
    }
    countState.accept(true);
  }

  @override
  void dispose() {
    _cartManager.positiveListNotifier.removeListener(_updateCount);
    super.dispose();
  }
}
