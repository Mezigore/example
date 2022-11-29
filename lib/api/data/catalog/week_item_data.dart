import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';

part 'week_item_data.g.dart';

/// Data-класс для [WeekItem].
@JsonSerializable()
class WeekItemData {
  WeekItemData({
    this.id,
    this.startDate,
    this.endDate,
    this.description,
  });

  factory WeekItemData.fromJson(Map<String, dynamic> json) =>
      _$WeekItemDataFromJson(json);

  final String id;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  final String description;

  Map<String, dynamic> toJson() => _$WeekItemDataToJson(this);
}
