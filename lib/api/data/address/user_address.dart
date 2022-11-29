import 'package:json_annotation/json_annotation.dart';

part 'user_address.g.dart';

/// Адрес пользователя из списка адресов пользователя
@JsonSerializable()
class UserAddressData {
  UserAddressData({
    this.cityId,
    this.cityName,
    this.comment,
    this.coordinates,
    this.isDefault,
    this.flat,
    this.floor,
    this.fullName,
    this.house,
    this.id,
    this.name,
    this.section,
    this.street,
  });

  factory UserAddressData.fromJson(Map<String, dynamic> json) =>
      _$UserAddressDataFromJson(json);

  @JsonKey(name: 'city_id')
  final int cityId;

  @JsonKey(name: 'city_name')
  final String cityName;

  final String comment;

  final String coordinates;

  /// Адрес по-умолчанию
  @JsonKey(name: 'default')
  final bool isDefault;

  /// Квартира
  final int flat;

  /// Этаж
  final int floor;

  /// Полный адрес cо всеми деталями
  @JsonKey(name: 'full_name')
  final String fullName;

  /// Дом
  final int house;

  final int id;

  /// Основная часть адреса, выбираемая целиком до дома включительно в стандартизированном виде из поиска адреса
  final String name;

  /// Подъезд
  final int section;

  /// Улица
  final String street;

  Map<String, dynamic> toJson() => _$UserAddressDataToJson(this);
}
