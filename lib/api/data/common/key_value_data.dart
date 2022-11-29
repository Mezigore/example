import 'package:json_annotation/json_annotation.dart';

part 'key_value_data.g.dart';

/// Data-класс для данных ключ значение.
@JsonSerializable()
class KeyValueData {
  KeyValueData({
    this.key,
    this.value,
  });

  factory KeyValueData.fromJson(Map<String, dynamic> json) =>
      _$KeyValueDataFromJson(json);

  final String key;
  final String value;

  Map<String, dynamic> toJson() => _$KeyValueDataToJson(this);
}
