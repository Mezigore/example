// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartData _$CartDataFromJson(Map<String, dynamic> json) {
  return CartData(
    minCount: json['min_count'] as int,
    minPrice: json['min_price'] as int,
    discount: json['discount'] as int,
    discountSumm: json['discount_summ'] as int,
    discountCountSumm: json['discount_count_summ'] as int,
    discountConditions: (json['discount_conditions'] as List)
        ?.map((e) =>
            e == null ? null : KeyValueData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    price: json['price'] as int,
    totalPrice: json['total_price'] as int,
    discountPrice: json['discount_price'] as int,
    weekItem: json['weekItem'] == null
        ? null
        : WeekItemData.fromJson(json['weekItem'] as Map<String, dynamic>),
    menu: (json['menu'] as List)
        ?.map((e) =>
            e == null ? null : CartItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    extraItems: (json['extra_item'] as List)
        ?.map((e) => e == null
            ? null
            : ExtraItemData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'min_count': instance.minCount,
      'min_price': instance.minPrice,
      'discount': instance.discount,
      'discount_summ': instance.discountSumm,
      'discount_count_summ': instance.discountCountSumm,
      'discount_conditions': instance.discountConditions,
      'price': instance.price,
      'total_price': instance.totalPrice,
      'discount_price': instance.discountPrice,
      'weekItem': instance.weekItem,
      'menu': instance.menu,
      'extra_item': instance.extraItems,
    };
