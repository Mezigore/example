import 'dart:developer';

import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/interactor/cart/repository/cart_repository.dart';
import 'package:uzhindoma/interactor/catalog/repository/catalog_repository.dart';
import 'package:uzhindoma/util/future_utils.dart';

/// Итерактор для работы с промо набором
class PromoInteractor {
  PromoInteractor(this._catalogRepository, this._cartRepository);

  final CatalogRepository _catalogRepository;
  final CartRepository _cartRepository;

  /// Получение новых рецептов пользователя
  Future<PromoItem> getPromoSet() {
    return checkMapping(_catalogRepository.getPromo());
  }

  Future<String> addPromoToCart() async {
    return _cartRepository.addPromoToCart();
  }

}
