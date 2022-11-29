import 'package:uzhindoma/api/data/cart/cart_data.dart';
import 'package:uzhindoma/api/data/cart/cart_item_data.dart';
import 'package:uzhindoma/api/data/cart/edit_cart_item_data.dart';
import 'package:uzhindoma/api/data/cart/extra_item_data.dart';
import 'package:uzhindoma/api/data/common/key_value_data.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';
import 'package:uzhindoma/domain/cart/discount_condition.dart';
import 'package:uzhindoma/domain/cart/edit_cart_item.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/interactor/catalog/repository/catalog_data_mappers.dart';

/// Маппер [Cart] из [CartData]
Cart mapCart(CartData data) {
  return Cart(
    minCount: data.minCount,
    minPrice: data.minPrice,
    discount: data.discount,
    discountSumm: data.discountSumm,
    discountCountSumm: data.discountCountSumm,
    discountConditions:
        data.discountConditions.map(mapDiscountCondition).toList(),
    price: data.price,
    totalPrice: data.totalPrice,
    discountPrice: data.discountPrice,
    menu: data.menu.map(mapCartItem).toList(),
    // недели может не быть когда корзина пустая
    weekItem: data.weekItem == null ? null : mapWeekItem(data.weekItem),
    extraItems: data.extraItems == null
        ? []
        : data.extraItems.map(mapExtraItem).toList(),
  );
}

/// Маппер [CartItem] из [CartItemData]
CartItem mapCartItem(CartItemData data) {
  return CartItem(
    id: data.id,
    name: data.name,
    previewImg: data.previewImg,
    price: data.price,
    discountPrice: data.discountPrice,
    qty: data.qty,
    ratio: data.ratio,
    type: mapMenuItemType(data.type),
  );
}

/// Маппер [DiscountCondition] из [KeyValueData]
DiscountCondition mapDiscountCondition(KeyValueData data) {
  return DiscountCondition(
    int.parse(data.key),
    int.parse(data.value),
  );
}

/// Маппер [ExtraItem] из [ExtraItemData]
ExtraItem mapExtraItem(ExtraItemData data) {
  return ExtraItem(
    id: data.id,
    name: data.name,
    previewImg: data.previewImg,
    price: data.price,
  );
}

/// Маппер [EditCartItemData] из [EditCartItem]
EditCartItemData mapEditCartItemData(EditCartItem data) {
  return EditCartItemData(
    id: data.id,
    qty: data.qty,
  );
}
