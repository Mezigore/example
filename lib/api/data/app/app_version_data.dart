import 'package:json_annotation/json_annotation.dart';

part 'app_version_data.g.dart';

/// Модель для добавления нового адреса
@JsonSerializable()
class AppVersionData {
  AppVersionData({
    this.appStore,
    this.playMarket,
  });

  factory AppVersionData.fromJson(Map<String, dynamic> json) =>
      _$AppVersionDataFromJson(json);

  @JsonKey(name: 'app_store')
  final String appStore;

  @JsonKey(name: 'play_market')
  final String playMarket;


  Map<String, dynamic> toJson() => _$AppVersionDataToJson(this);
}
