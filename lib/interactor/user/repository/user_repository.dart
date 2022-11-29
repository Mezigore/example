import 'package:uzhindoma/api/client/user/user_client.dart';
import 'package:uzhindoma/domain/common/otp_required.dart';
import 'package:uzhindoma/domain/user/change_phone.dart';
import 'package:uzhindoma/domain/user/confirm_change_phone.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/user/repository/user_data_mappers.dart';

/// Репозиторий работы с пользователем
class UserRepository {
  UserRepository(this._client);

  final UserClient _client;

  /// Обновление телефона
  Future<OtpRequired> changePhone(ChangePhone changePhone) {
    return _client
        .patchChangePhone(mapChangePhoneData(changePhone))
        .then(mapOtpRequired);
  }

  /// Подтверждение обновления телефона
  Future<void> confirmChangePhone(ConfirmChangePhone confirmChangePhone) async {
    await _client.patchConformChangePhone(
      mapConformChangePhoneData(confirmChangePhone),
    );
    return;
  }

  /// Удаление любимого блюда из профиля
  Future<void> removeFavourite(String id) {
    return _client.deleteFavourite(id);
  }

  /// Поиск по доступным любимым блюдам
  Future<List<FavouriteItem>> searchFavourite(String searchText) async {
    final res = await _client.getFavourite(searchText);
    return res.map(mapFavouriteItem).toList();
  }

  /// Добавление нового любимого блюда в профиль
  Future<void> addFavourite(String id) {
    return _client.postFavourite(id);
  }

  Future<int> getOrdersCount() {
    return _client.getOrdersCount();
  }

  /// Вся информация о пользователе
  Future<UserInfo> getUser() {
    return _client.getProfile().then(mapUserInfo);
  }

  /// Обновление профиля
  Future<void> updateUser(UpdateProfile updateProfile) async {
    await _client.patchProfile(mapUpdateProfileData(updateProfile));
    return;
  }
  /// Удаление профиля
  Future<void> deleteAccount() async {
    await _client.deleteProfile();
    return;
  }
}
