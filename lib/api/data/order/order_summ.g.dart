// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_summ.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderSummData _$OrderSummDataFromJson(Map<String, dynamic> json) {
  return OrderSummData(
    summId: json['summ_id'] as int,
    discount: json['discount'] as int,
    discountSumm: json['discount_summ'] as int,
    discountCountSumm: json['discount_count_summ'] as int,
    discountConditions: (json['discount_conditions'] as List)
        ?.map((e) =>
            e == null ? null : KeyValueData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    bonuses: json['bonuses'] as int,
    promocode: json['promocode'] as int,
    totalPrice: json['total_price'] as int,
    price: json['price'] as int,
    discountPrice: json['discount_price'] as int,
  );
}

Map<String, dynamic> _$OrderSummDataToJson(OrderSummData instance) =>
    <String, dynamic>{
      'summ_id': instance.summId,
      'discount': instance.discount,
      'discount_summ': instance.discountSumm,
      'discount_count_summ': instance.discountCountSumm,
      'discount_conditions': instance.discountConditions,
      'bonuses': instance.bonuses,
      'promocode': instance.promocode,
      'total_price': instance.totalPrice,
      'price': instance.price,
      'discount_price': instance.discountPrice,
    };
