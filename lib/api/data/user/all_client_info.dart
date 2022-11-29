import 'package:json_annotation/json_annotation.dart';
import 'package:uzhindoma/api/data/user/favourite_item.dart';
import 'package:uzhindoma/api/data/user/gender_info.dart';
import 'package:uzhindoma/api/data/user/promocode_info.dart';

part 'all_client_info.g.dart';

/// Информация о пользователе
@JsonSerializable()
class AllClientInfoData {
  AllClientInfoData({
    this.birthday,
    this.bonus,
    this.discount,
    this.favourite,
    this.gender,
    this.id,
    this.isNew,
    this.lastName,
    this.name,
    this.phone,
    this.promocode,
    this.referral,
    this.email,
    this.noBirthdayText,
    this.noFavouriteText,
  });

  factory AllClientInfoData.fromJson(Map<String, dynamic> json) =>
      _$AllClientInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$AllClientInfoDataToJson(this);

  final String birthday;

  /// Если бонуса нет -- приходит 0.
  final int bonus;

  /// Скидка Family. Если скидки нет -- приходит 0.
  final int discount;

  final List<FavouriteItemData> favourite;

  @JsonKey(unknownEnumValue: GenderInfoData.unknownValue)
  final GenderInfoData gender;

  final String id;

  /// Если true - не было ни одного заказа
  @JsonKey(name: 'is_new')
  final bool isNew;

  @JsonKey(name: 'last_name')
  final String lastName;

  final String name;

  final String phone;

  final PromocodeInfoData promocode;

  final String referral;

  final String email;

  @JsonKey(name: 'no_birthday_text')
  final String noBirthdayText;

  @JsonKey(name: 'no_favourite_text')
  final String noFavouriteText;
}
