// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_label_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemLabelData _$MenuItemLabelDataFromJson(Map<String, dynamic> json) {
  return MenuItemLabelData(
    title: json['title'] as String,
    labelColor: json['label_color'] as String,
    textColor: json['text_color'] as String,
  );
}

Map<String, dynamic> _$MenuItemLabelDataToJson(MenuItemLabelData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'label_color': instance.labelColor,
      'text_color': instance.textColor,
    };

MenuItemMainLabelData _$MenuItemMainLabelDataFromJson(
    Map<String, dynamic> json) {
  return MenuItemMainLabelData(
    title: json['title'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$MenuItemMainLabelDataToJson(
        MenuItemMainLabelData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
