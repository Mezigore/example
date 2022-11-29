import 'package:uzhindoma/api/data/user/all_client_info.dart';
import 'package:uzhindoma/api/data/user/change_phone.dart';
import 'package:uzhindoma/api/data/user/conform_change_phone.dart';
import 'package:uzhindoma/api/data/user/favourite_item.dart';
import 'package:uzhindoma/api/data/user/gender_info.dart';
import 'package:uzhindoma/api/data/user/otp_required.dart';
import 'package:uzhindoma/api/data/user/promocode_info.dart';
import 'package:uzhindoma/api/data/user/update_profile.dart';
import 'package:uzhindoma/domain/common/otp_required.dart';
import 'package:uzhindoma/domain/user/change_phone.dart';
import 'package:uzhindoma/domain/user/confirm_change_phone.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/gender_info.dart';
import 'package:uzhindoma/domain/user/promocode_info.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';

/// Маппер [ChangePhoneData] из [ChangePhone]
ChangePhoneData mapChangePhoneData(ChangePhone data) {
  return ChangePhoneData(
    phone: data.phone,
  );
}

/// Маппер [ChangePhoneData] из [ChangePhone]
OtpRequired mapOtpRequired(OtpRequiredData data) {
  return OtpRequired(
    nextOtp: data.nextOtp,
  );
}

/// Маппер [ConformChangePhoneData] из [ConfirmChangePhone]
ConformChangePhoneData mapConformChangePhoneData(ConfirmChangePhone data) {
  return ConformChangePhoneData(
    phone: data.phone,
    code: data.code,
  );
}

/// Маппер [UserInfo] из [AllClientInfoData]
UserInfo mapUserInfo(AllClientInfoData data) {
  return UserInfo(
    birthday: data.birthday != null ? DateTime.tryParse(data.birthday) : null,
    bonus: data.bonus,
    discount: data.discount,
    favourite: data.favourite?.map(mapFavouriteItem)?.toList(),
    gender: data.gender != null ? mapGenderInfo(data.gender) : null,
    id: data.id,
    isNew: data.isNew,
    lastName: data.lastName,
    name: data.name,
    phone: data.phone,
    promocode: data.promocode != null ? mapPromocodeInfo(data.promocode) : null,
    referral: data.referral,
    email: data.email,
    noBirthdayText: data.noBirthdayText,
    noFavouriteText: data.noFavouriteText,
  );
}

/// Маппер [FavouriteItem] из [FavouriteItemData]
FavouriteItem mapFavouriteItem(FavouriteItemData data) {
  return FavouriteItem(
    id: data.id,
    name: data.name.trim(),
  );
}

/// Маппер [GenderInfo] из [GenderInfoData]
GenderInfo mapGenderInfo(GenderInfoData data) {
  switch (data) {
    case GenderInfoData.M:
      return GenderInfo.M;
    case GenderInfoData.F:
      return GenderInfo.F;
    default:
      // todo не обязательный параметр, ошибка излишне
      return GenderInfo.unknownValue;
  }
}

/// Маппер [GenderInfoData] из [GenderInfo]
GenderInfoData mapGenderInfoData(GenderInfo data) {
  switch (data) {
    case GenderInfo.M:
      return GenderInfoData.M;
    case GenderInfo.F:
      return GenderInfoData.F;
    default:
      return GenderInfoData.unknownValue;
  }
}

/// Маппер [PromocodeInfo] из [PromocodeInfoData]
PromocodeInfo mapPromocodeInfo(PromocodeInfoData data) {
  return PromocodeInfo(
    code: data.code,
    useCount: data.useCount,
  );
}

/// Маппер [UpdateProfileData] из [UpdateProfile]
UpdateProfileData mapUpdateProfileData(UpdateProfile data) {
  return UpdateProfileData(
    name: data.name,
    birthday: data.birthday?.toIso8601String(),
    gender: mapGenderInfoData(data.gender),
    lastName: data.lastName,
    email: data.email,
  );
}
