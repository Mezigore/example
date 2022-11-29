import 'package:json_annotation/json_annotation.dart';

part 'new_address.g.dart';

/// Модель для добавления нового адреса
@JsonSerializable()
class NewAddressData {
  NewAddressData({
    this.comment,
    this.isDefault,
    this.flat,
    this.floor,
    this.name,
    this.section,
  });

  factory NewAddressData.fromJson(Map<String, dynamic> json) =>
      _$NewAddressDataFromJson(json);

  /// Комментарий
  final String comment;

  /// Адрес по-умолчанию
  @JsonKey(name: 'default')
  final bool isDefault;

  /// Квартира
  final int flat;

  /// Этаж
  final int floor;

  /// Основная часть адреса, выбираемая целиком до дома включительно в стандартизированном виде из поиска адреса
  final String name;

  /// Подъезд
  final int section;

  Map<String, dynamic> toJson() => _$NewAddressDataToJson(this);
}
