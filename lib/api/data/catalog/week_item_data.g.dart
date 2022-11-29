// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_item_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekItemData _$WeekItemDataFromJson(Map<String, dynamic> json) {
  return WeekItemData(
    id: json['id'] as String,
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    endDate: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$WeekItemDataToJson(WeekItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'description': instance.description,
    };
