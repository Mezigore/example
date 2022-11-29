import 'dart:developer';

import 'package:uzhindoma/api/client/cart/cart_client.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/edit_cart_item.dart';
import 'package:uzhindoma/interactor/cart/repository/cart_data_mappers.dart';


/// Репозиторий работы с корзиной
class CartRepository {
  CartRepository(this._client);

  final CartClient _client;

  /// Загружает текущую корзину.
  Future<Cart> getCart() {
    return _client.getCart().then(mapCart);
  }

 /// Загружает текущую корзину.
  Future<Cart> getPromoCart({String promoname}) {
    return _client.getPromoCart(promoname).then(mapCart);
  }

  /// Очищает корзину
  Future<void> clearCart() {
    return _client.clearCart();
  }

  /// Добавляет товар в корзину
  Future<void> addToCart(EditCartItem item) {
    return _client.addToCart(mapEditCartItemData(item));
  }

  /// Убирает товар из корзины
  Future<void> removeFromCart(EditCartItem item) {
    return _client.removeFromCart(mapEditCartItemData(item));
  }

  /// Убирает подарок из корзины
  Future<void> removeExtra(String extraId) {
    return _client.removeExtra(extraId);
  }

  /// Добавить промо-набор в корзину
  Future<String> addPromoToCart() async {
      return _client.addPromo();
  }
}
