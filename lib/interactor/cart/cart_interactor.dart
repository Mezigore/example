import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/edit_cart_item.dart';
import 'package:uzhindoma/interactor/cart/repository/cart_repository.dart';

/// Интерактор работы с корзиной.
class CartInteractor {
  CartInteractor(this._cartRepository);

  final CartRepository _cartRepository;

  /// Загружает текущую корзину.
  Future<Cart> getCart() {
    return _cartRepository.getCart();
  }

 /// Загружает текущую корзину.
  Future<Cart> getPromoCart({String promoname}) {
    return _cartRepository.getPromoCart(promoname:promoname);
  }

  /// Очищает корзину
  Future<void> clearCart() {
    return _cartRepository.clearCart();
  }

  /// Добавляет товар в корзину
  Future<void> addToCart(EditCartItem item) {
    return _cartRepository.addToCart(item);
  }

  /// Убирает товар из корзины
  Future<void> removeFromCart(EditCartItem item) {
    return _cartRepository.removeFromCart(item);
  }

  /// Убирает подарок из корзины
  Future<void> removeExtra(String extraId) {
    return _cartRepository.removeExtra(extraId);
  }
}
