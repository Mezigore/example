import 'package:json_annotation/json_annotation.dart';

part 'promocode.g.dart';

@JsonSerializable()
class PromoCodeData {
  PromoCodeData({
    this.promoCode,
  });

  factory PromoCodeData.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeDataFromJson(json);

  /// Скидка в рублях за счет применения промокода
  @JsonKey(name: 'promocode')
  final String promoCode;

  Map<String, dynamic> toJson() => _$PromoCodeDataToJson(this);
}
