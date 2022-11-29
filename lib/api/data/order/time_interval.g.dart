// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeIntervalData _$TimeIntervalDataFromJson(Map<String, dynamic> json) {
  return TimeIntervalData(
    from: json['from'] as String,
    to: json['to'] as String,
  );
}

Map<String, dynamic> _$TimeIntervalDataToJson(TimeIntervalData instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
    };
