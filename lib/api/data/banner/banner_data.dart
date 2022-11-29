import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/domain/banner/banner.dart';

part 'banner_data.g.dart';

/// Data-класс для [Banner]
@JsonSerializable()
class BannerData {
  BannerData({
    this.id,
    this.imageUrl,
    this.url,
    this.title,
    this.description,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);

  final String id;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String url;
  final String title;
  final String description;

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}
