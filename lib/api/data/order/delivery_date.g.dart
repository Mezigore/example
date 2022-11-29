// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_date.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryDateData _$DeliveryDateDataFromJson(Map<String, dynamic> json) {
  return DeliveryDateData(
    date: json['date'] as String,
    time: (json['time'] as List)
        ?.map((e) => e == null
            ? null
            : DeliveryTimeIntervalData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DeliveryDateDataToJson(DeliveryDateData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
    };
