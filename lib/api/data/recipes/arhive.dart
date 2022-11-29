import 'package:json_annotation/json_annotation.dart';

part 'arhive.g.dart';

@JsonSerializable()
class ArhiveData {
  ArhiveData({
    this.toArchive,
  });

  factory ArhiveData.fromJson(Map<String, dynamic> json) =>
      _$ArhiveDataFromJson(json);

  /// Если параметр true, рецепт переносится из актуальных во все рецепты, если false - обратно.
  @JsonKey(name: 'to_archive')
  final bool toArchive;

  Map<String, dynamic> toJson() => _$ArhiveDataToJson(this);
}
