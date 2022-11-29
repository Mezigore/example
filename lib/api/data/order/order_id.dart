import 'package:json_annotation/json_annotation.dart';

part 'order_id.g.dart';

@JsonSerializable()
class OrderIdData {
  OrderIdData({
    this.id,
  });

  factory OrderIdData.fromJson(Map<String, dynamic> json) =>
      _$OrderIdDataFromJson(json);

  /// ID заказа
  final int id;

  Map<String, dynamic> toJson() => _$OrderIdDataToJson(this);
}
