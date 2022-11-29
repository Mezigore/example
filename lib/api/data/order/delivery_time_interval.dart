import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/time_interval.dart';

part 'delivery_time_interval.g.dart';

/// id временного интервала, верхняя и нижняя граница
@JsonSerializable()
class DeliveryTimeIntervalData {
  DeliveryTimeIntervalData({
    this.id,
    this.intervals,
  });

  factory DeliveryTimeIntervalData.fromJson(Map<String, dynamic> json) =>
      _$DeliveryTimeIntervalDataFromJson(json);

  /// Id временного интервала доставки
  final int id;

  final TimeIntervalData intervals;

  Map<String, dynamic> toJson() => _$DeliveryTimeIntervalDataToJson(this);
}
