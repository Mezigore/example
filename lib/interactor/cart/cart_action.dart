import 'package:uzhindoma/domain/cart/cart_element.dart';

/// Некоторое действие внутри корзины
abstract class CartAction {
  @override
  String toString() => 'CartAction{}';
}

/// Некоторое действие с товаром внутри корзины
class CartElementAction implements CartAction {
  CartElementAction(this.type, this.item, this.count);

  final CartActionType type;
  final CartElement item;
  final int count;

  String get id => item.id;
  int get changeValue => count * (type == CartActionType.remove ? -1 : 1);

  @override
  String toString() =>
      'CartElementAction{$id: ${type == CartActionType.remove ? "-" : ""}$count}';
}

/// Удаление допа из корзины
class RemoveExtraAction implements CartAction {
  RemoveExtraAction({this.id});

  final String id;

  @override
  String toString() => 'RemoveExtraAction{$id}';
}

/// Удаление допа из корзины
class ClearCartAction implements CartAction {
  ClearCartAction();

  @override
  String toString() => 'ClearCartAction{}';
}

/// Обновление корзины
class UpdateCartAction implements CartAction {
  UpdateCartAction();

  @override
  String toString() => 'UpdateCartAction{}';
}

/// Некоторое действие, которое не удалось
class FailedCartAction implements CartAction {
  FailedCartAction(this.action);

  final CartAction action;
}

/// Тип действия
enum CartActionType {
  /// добавление в корзину
  add,

  /// удаление из корзины
  remove,
}
