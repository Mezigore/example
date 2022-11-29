import 'package:json_annotation/json_annotation.dart';

part 'info_message.g.dart';

/// Модель, которая хранит какое-то сообщение
@JsonSerializable()
class InfoMessageData {
  InfoMessageData({
    this.text,
  });

  factory InfoMessageData.fromJson(Map<String, dynamic> json) =>
      _$InfoMessageDataFromJson(json);

  Map<String, dynamic> toJson() => _$InfoMessageDataToJson(this);
  String text;
}
