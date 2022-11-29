import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_label.dart';

part 'menu_label_data.g.dart';

/// Data-класс для [MenuItemLabel].
@JsonSerializable()
class MenuItemLabelData {
  MenuItemLabelData({
    this.title,
    this.labelColor,
    this.textColor,
  });

  factory MenuItemLabelData.fromJson(Map<String, dynamic> json) =>
      _$MenuItemLabelDataFromJson(json);

  final String title;
  @JsonKey(name: 'label_color')
  final String labelColor;
  @JsonKey(name: 'text_color')
  final String textColor;

  Map<String, dynamic> toJson() => _$MenuItemLabelDataToJson(this);
}

/// Data-класс для [MenuItemMainLabel].
@JsonSerializable()
class MenuItemMainLabelData {
  MenuItemMainLabelData({
    this.title,
    this.imageUrl,
  });

  factory MenuItemMainLabelData.fromJson(Map<String, dynamic> json) =>
      _$MenuItemMainLabelDataFromJson(json);

  final String title;
  final String imageUrl;

  Map<String, dynamic> toJson() => _$MenuItemMainLabelDataToJson(this);
}
