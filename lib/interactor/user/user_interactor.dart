import 'package:uzhindoma/domain/common/otp_required.dart';
import 'package:uzhindoma/domain/user/change_phone.dart';
import 'package:uzhindoma/domain/user/confirm_change_phone.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/user/repository/user_repository.dart';

/// Интерактор работы с данными пользователя.
class UserInteractor {
  UserInteractor(this._userRepository);

  final UserRepository _userRepository;

  /// Обновление телефона
  Future<OtpRequired> changePhone(ChangePhone changePhone) {
    return _userRepository.changePhone(changePhone);
  }

  /// Подтверждение обновления телефона
  Future<void> confirmChangePhone(ConfirmChangePhone confirmChangePhone) {
    return _userRepository.confirmChangePhone(confirmChangePhone);
  }

  /// Удаление любимого блюда из профиля
  Future<void> removeFavourite(String id) {
    return _userRepository.removeFavourite(id);
  }

  /// Поиск по доступным любимым блюдам
  Future<List<FavouriteItem>> searchFavourite(String searchText) {
    return _userRepository.searchFavourite(searchText);
  }

  /// Добавление нового любимого блюда в профиль
  Future<void> addFavourite(String id) {
    return _userRepository.addFavourite(id);
  }

  /// Получение количества заказов пользователя
  Future<int> getOrdersCount(){
    return _userRepository.getOrdersCount();
  }

  /// Вся информация о пользователе
  Future<UserInfo> getUser() {
    return _userRepository.getUser();
  }

  /// Обновление профиля
  Future<void> updateUser(UpdateProfile updateProfile) async {
    await _userRepository.updateUser(updateProfile);
  }

  /// Удаление профиля
  Future<void> deleteAccount() async {
    await _userRepository.deleteAccount();
  }
}
