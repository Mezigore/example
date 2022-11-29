// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_menu_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertiesMenuItemData _$PropertiesMenuItemDataFromJson(
    Map<String, dynamic> json) {
  return PropertiesMenuItemData(
    labels: (json['labels'] as List)
        ?.map((e) => e == null
            ? null
            : MenuItemLabelData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    mainLabel: json['main_label'] == null
        ? null
        : MenuItemMainLabelData.fromJson(
            json['main_label'] as Map<String, dynamic>),
    cookTime: json['cook_time'] as int,
    weight: json['weight'] as int,
    ratio: json['ratio'] as String,
    willDeliver: json['will_deliver'] as String,
    youNeed: json['you_need'] as String,
    prepareComment: json['prepare_comment'] as String,
    bguCal: (json['bgu_cal'] as num)?.toDouble(),
    bguProtein: (json['bgu_protein'] as num)?.toDouble(),
    bguFat: (json['bgu_fat'] as num)?.toDouble(),
    bguCarb: (json['bgu_carb'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PropertiesMenuItemDataToJson(
        PropertiesMenuItemData instance) =>
    <String, dynamic>{
      'labels': instance.labels,
      'main_label': instance.mainLabel,
      'cook_time': instance.cookTime,
      'weight': instance.weight,
      'ratio': instance.ratio,
      'will_deliver': instance.willDeliver,
      'you_need': instance.youNeed,
      'prepare_comment': instance.prepareComment,
      'bgu_cal': instance.bguCal,
      'bgu_protein': instance.bguProtein,
      'bgu_fat': instance.bguFat,
      'bgu_carb': instance.bguCarb,
    };
