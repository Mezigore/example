// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_time_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryTimeIntervalData _$DeliveryTimeIntervalDataFromJson(
    Map<String, dynamic> json) {
  return DeliveryTimeIntervalData(
    id: json['id'] as int,
    intervals: json['intervals'] == null
        ? null
        : TimeIntervalData.fromJson(json['intervals'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeliveryTimeIntervalDataToJson(
        DeliveryTimeIntervalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intervals': instance.intervals,
    };
