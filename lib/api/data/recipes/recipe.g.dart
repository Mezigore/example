// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeData _$RecipeDataFromJson(Map<String, dynamic> json) {
  return RecipeData(
    bguCal: (json['bgu_cal'] as num)?.toDouble(),
    bguCarb: (json['bgu_carb'] as num)?.toDouble(),
    bguFat: (json['bgu_fat'] as num)?.toDouble(),
    bguProtein: (json['bgu_protein'] as num)?.toDouble(),
    cookBefore: json['cook_before'] as String,
    cookTime: json['cook_time'] as int,
    detailImg: json['detail_img'] as String,
    id: json['id'] as String,
    name: json['name'] as String,
    previewImg: json['preview_img'] as String,
    ratio: json['ratio'] as String,
    recipes: (json['recipes'] as List)
        ?.map((e) => e == null
            ? null
            : RecipeDescriptionData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    weight: json['weight'] as int,
    willDeliver: json['will_deliver'] as String,
    youNeed: json['you_need'] as String,
    rate: json['rate'] as int,
    orderId: json['order_id'] as String,
    productId: json['product_id'] as String,
    isFavorite: json['is_favorite'] as bool,
    showTime: json['show_time'] as int,
    hideTime: json['hide_time'] as int,
    toShow: json['to_show'] as bool,
  );
}

Map<String, dynamic> _$RecipeDataToJson(RecipeData instance) =>
    <String, dynamic>{
      'bgu_cal': instance.bguCal,
      'bgu_carb': instance.bguCarb,
      'bgu_fat': instance.bguFat,
      'bgu_protein': instance.bguProtein,
      'cook_before': instance.cookBefore,
      'cook_time': instance.cookTime,
      'detail_img': instance.detailImg,
      'id': instance.id,
      'name': instance.name,
      'preview_img': instance.previewImg,
      'ratio': instance.ratio,
      'recipes': instance.recipes,
      'weight': instance.weight,
      'will_deliver': instance.willDeliver,
      'you_need': instance.youNeed,
      'rate': instance.rate,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'is_favorite': instance.isFavorite,
      'show_time': instance.showTime,
      'hide_time': instance.hideTime,
      'to_show': instance.toShow,
    };
