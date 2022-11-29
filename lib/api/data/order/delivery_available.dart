import 'package:json_annotation/json_annotation.dart';

part 'delivery_available.g.dart';

@JsonSerializable()
class DeliveryAvailableData {
  DeliveryAvailableData({
    this.isAvailable,
  });

  factory DeliveryAvailableData.fromJson(Map<String, dynamic> json) =>
      _$DeliveryAvailableDataFromJson(json);

  /// Доступна ли доставка для выбранного города
  @JsonKey(name: 'is_available')
  final bool isAvailable;

  Map<String, dynamic> toJson() => _$DeliveryAvailableDataToJson(this);
}
