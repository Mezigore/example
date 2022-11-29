import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/order/delivery_time_interval.dart';

part 'delivery_date.g.dart';

/// Дата и время доставки
@JsonSerializable()
class DeliveryDateData {
  DeliveryDateData({
    this.date,
    this.time,
  });

  factory DeliveryDateData.fromJson(Map<String, dynamic> json) =>
      _$DeliveryDateDataFromJson(json);

  /// Дата в формате ISO 8601 "yyyy-MM-dd"
  final String date;

  final List<DeliveryTimeIntervalData> time;

  Map<String, dynamic> toJson() => _$DeliveryDateDataToJson(this);
}
