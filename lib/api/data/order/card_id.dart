import 'package:json_annotation/json_annotation.dart';

part 'card_id.g.dart';

@JsonSerializable()
class CardIdData {
  CardIdData({
    this.cardId,
  });

  factory CardIdData.fromJson(Map<String, dynamic> json) =>
      _$CardIdDataFromJson(json);

  /// ID карты, с которой будет оплачен заказ
  @JsonKey(name: 'card_id')
  final String cardId;

  Map<String, dynamic> toJson() => _$CardIdDataToJson(this);
}
