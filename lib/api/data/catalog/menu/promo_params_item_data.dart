import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_params.dart';

part 'promo_params_item_data.g.dart';

/// Data-класс для [PromoParams].
@JsonSerializable()
class PromoParamsItemData {
  PromoParamsItemData({
    this.countDin,
    this.countPers,
    this.price,
    this.oldPrice,
    this.idB24,
  });

  factory PromoParamsItemData.fromJson(Map<String, dynamic> json) =>
      _$PromoParamsItemDataFromJson(json);

  final int countDin;
  @JsonKey(name: 'count_din')
  final int countPers;
  @JsonKey(name: 'count_pers')
  final int price;
  final int oldPrice;
  @JsonKey(name: 'old_price')
  final String idB24;
  @JsonKey(name: 'id_b24')

  Map<String, dynamic> toJson() => _$PromoParamsItemDataToJson(this);
}
