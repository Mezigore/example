import 'package:flutter/material.dart' hide MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';

class PromoPriceTextWidgetModel extends WidgetModel {
  PromoPriceTextWidgetModel(
    WidgetModelDependencies baseDependencies, {
    @required this.menuItem,
    @required CartManager cartManager,
  })  : assert(menuItem != null),
        assert(cartManager != null),
        _cartManager = cartManager,
        super(baseDependencies);

  final MenuItem menuItem;
  final CartManager _cartManager;

  /// Есть ли позиция в корзине
  final countState = StreamedState<int>(0);

  @override
  void onLoad() {
    super.onLoad();

    _init();
  }

  void _init() {
    _updateCount();
    // подписываемся на изменения в корзине
    _cartManager.positiveListNotifier.addListener(_updateCount);
  }

  void _updateCount() {
    final newCount = _cartManager.positiveListNotifier.value[menuItem.id] ?? 0;

    if (newCount != countState.value) {
      countState.accept(newCount);
    }
  }
}
