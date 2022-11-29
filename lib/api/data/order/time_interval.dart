import 'package:json_annotation/json_annotation.dart';

part 'time_interval.g.dart';

/// Временные границы доставки
@JsonSerializable()
class TimeIntervalData {
  TimeIntervalData({
    this.from,
    this.to,
  });

  factory TimeIntervalData.fromJson(Map<String, dynamic> json) =>
      _$TimeIntervalDataFromJson(json);

  /// Время в формате ISO 8601 hh:mm
  final String from;

  /// Время в формате ISO 8601 hh:mm
  final String to;

  Map<String, dynamic> toJson() => _$TimeIntervalDataToJson(this);
}
