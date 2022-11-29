import 'package:uzhindoma/domain/addresses/user_address.dart';

/// Модель для добавления нового адреса
class NewAddress {
  NewAddress({
    this.comment,
    this.isDefault,
    this.flat,
    this.floor,
    this.name,
    this.section,
  });

  factory NewAddress.fromUserAddress(UserAddress userAddress) {
    return NewAddress(
      comment: userAddress.comment,
      isDefault: userAddress.isDefault,
      flat: userAddress.flat,
      floor: userAddress.floor,
      name: userAddress.name,
      section: userAddress.section,
    );
  }

  /// Комментарий
  final String comment;

  /// Адрес по-умолчанию
  final bool isDefault;

  /// Квартира
  final int flat;

  /// Этаж
  final int floor;

  /// Основная часть адреса, выбираемая целиком до дома включительно в стандартизированном виде из поиска адреса
  final String name;

  /// Подъезд
  final int section;

  NewAddress copyWith({
    String comment,
    bool isDefault,
    int flat,
    int floor,
    String name,
    int section,
  }) {
    return NewAddress(
      comment: comment ?? this.comment,
      isDefault: isDefault ?? this.isDefault,
      flat: flat ?? this.flat,
      floor: floor ?? this.floor,
      name: name ?? this.name,
      section: section ?? this.section,
    );
  }
}
