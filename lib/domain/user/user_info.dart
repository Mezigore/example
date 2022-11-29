import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/gender_info.dart';
import 'package:uzhindoma/domain/user/promocode_info.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';

/// Информация о пользователе
/// [id] - идентификатор пользователя.
/// [name] - имя.
/// [lastName] - фамилия.
/// [gender] - пол.
/// [birthday] - дата рождения.
/// [bonus] - бонус.
/// [discount] - скидка Family.
/// [favourite] - список любимых блюд.
/// [phone] - номер телефона.
/// [promocode] - промокод.
/// [isNew] - является ли новым пользователем.
/// [email] - почта.
class UserInfo {
  UserInfo(
      {this.id,
      this.name,
      this.lastName,
      this.gender,
      this.birthday,
      this.bonus,
      this.discount,
      this.favourite,
      this.phone,
      this.promocode,
      this.referral,
      this.isNew,
      this.email,
      this.noBirthdayText,
      this.noFavouriteText});

  UserInfo.copy(
    UserInfo item, {
    String name,
    String lastName,
    String phone,
    DateTime birthday,
    int bonus,
    int discount,
    List<FavouriteItem> favourite,
    GenderInfo gender,
    bool isNew,
    PromocodeInfo promocode,
    String referral,
    String email,
    String noBirthdayText,
    String noFavouriteText,
  })  : id = item.id,
        name = name ?? item.name,
        lastName = lastName ?? item.lastName,
        phone = phone ?? item.phone,
        birthday = birthday ?? item.birthday,
        bonus = bonus ?? item.bonus,
        discount = discount ?? item.discount,
        favourite = favourite ?? item.favourite,
        gender = gender ?? item.gender,
        isNew = isNew ?? item.isNew,
        promocode = promocode ?? item.promocode,
        referral = referral ?? item.referral,
        email = email ?? item.email,
        noBirthdayText = noBirthdayText ?? item.noBirthdayText,
        noFavouriteText = noFavouriteText ?? item.noFavouriteText;

  UserInfo.patch(UserInfo item, UpdateProfile update)
      : id = item.id,
        name = update.name ?? item.name,
        lastName = update.lastName ?? item.lastName,
        birthday = update.birthday ?? item.birthday,
        phone = item.phone,
        bonus = item.bonus,
        discount = item.discount,
        favourite = item.favourite,
        gender = update.gender ?? item.gender,
        isNew = item.isNew,
        promocode = item.promocode,
        referral = item.referral,
        email = update.email,
        noBirthdayText = item.noBirthdayText,
        noFavouriteText = item.noFavouriteText;

  final DateTime birthday;
  final int bonus;
  final int discount;
  final List<FavouriteItem> favourite;
  final GenderInfo gender;
  final String id;
  final bool isNew;
  final String lastName;
  final String name;
  final String phone;
  final PromocodeInfo promocode;
  final String referral;
  final String email;
  final String noBirthdayText;
  final String noFavouriteText;
}
