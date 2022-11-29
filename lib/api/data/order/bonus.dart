import 'package:json_annotation/json_annotation.dart';

part 'bonus.g.dart';

@JsonSerializable()
class BonusData {
  BonusData({
    this.bonusAmount,
  });

  factory BonusData.fromJson(Map<String, dynamic> json) =>
      _$BonusDataFromJson(json);

  /// Количество бонусов, которые можно списать
  final int bonusAmount;

  Map<String, dynamic> toJson() => _$BonusDataToJson(this);
}
