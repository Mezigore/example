import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/catalog/menu/menu_label_data.dart';
import 'package:uzhindoma/domain/catalog/menu/properties_menu_item.dart';

part 'properties_menu_item_data.g.dart';

/// Data-класс для [PropertiesMenuItem].
@JsonSerializable()
class PropertiesMenuItemData {
  PropertiesMenuItemData({
    this.labels,
    this.mainLabel,
    this.cookTime,
    this.weight,
    this.ratio,
    this.willDeliver,
    this.youNeed,
    this.prepareComment,
    this.bguCal,
    this.bguProtein,
    this.bguFat,
    this.bguCarb,
  });

  factory PropertiesMenuItemData.fromJson(Map<String, dynamic> json) =>
      _$PropertiesMenuItemDataFromJson(json);

  final List<MenuItemLabelData> labels;
  @JsonKey(name: 'main_label')
  final MenuItemMainLabelData mainLabel;
  @JsonKey(name: 'cook_time')
  final int cookTime;
  final int weight;
  final String ratio;
  @JsonKey(name: 'will_deliver')
  final String willDeliver;
  @JsonKey(name: 'you_need')
  final String youNeed;
  @JsonKey(name: 'prepare_comment')
  final String prepareComment;
  @JsonKey(name: 'bgu_cal')
  final double bguCal;
  @JsonKey(name: 'bgu_protein')
  final double bguProtein;
  @JsonKey(name: 'bgu_fat')
  final double bguFat;
  @JsonKey(name: 'bgu_carb')
  final double bguCarb;

  Map<String, dynamic> toJson() => _$PropertiesMenuItemDataToJson(this);
}
