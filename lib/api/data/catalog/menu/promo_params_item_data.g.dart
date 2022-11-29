// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_params_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoParamsItemData _$PromoParamsItemDataFromJson(Map<String, dynamic> json) {
  return PromoParamsItemData(
    countDin: json['count_din'] as int,
    countPers: json['count_pers'] as int,
    price: json['price'] as int,
    oldPrice: json['old_price'] as int,
    idB24: (json['id_b24'] as String),
  );
}

Map<String, dynamic> _$PromoParamsItemDataToJson(PromoParamsItemData instance) =>
    <String, dynamic>{
      'count_din': instance.countDin,
      'count_pers': instance.countPers,
      'price': instance.price,
      'old_price': instance.oldPrice,
      'id_b24': instance.idB24,
    };
