/// Адрес пользователя из списка адресов пользователя
class UserAddress {
  UserAddress({
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

  final int cityId;

  final String cityName;

  final String comment;

  final String coordinates;

  /// Адрес по-умолчанию
  final bool isDefault;

  /// Квартира
  final int flat;

  /// Этаж
  final int floor;

  /// Полный адрес cо всеми деталями
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
}
