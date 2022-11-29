import 'dart:async';

import 'package:dio/dio.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/payment/payment_card.dart';
import 'package:uzhindoma/domain/user/change_phone.dart';
import 'package:uzhindoma/domain/user/confirm_change_phone.dart';
import 'package:uzhindoma/domain/user/favourite_item.dart';
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/address/address_interactor.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/payment/payment_interactor.dart';
import 'package:uzhindoma/interactor/token/token_storage.dart';
import 'package:uzhindoma/interactor/user/user_interactor.dart';

/// Менеджер работы с пользовательскими данными.
/// В области ответственности данные профиля пользователя,
/// варианты оплаты, адреса пользователя.
///
/// Для предоставления данных экранам и тд, используются EntityStreamedState
/// чтобы показать в каком состоянии сейчас находятся данные - загрузка,
/// ошибка, или они есть. И дать возможность в нужном месте гибко отреагировать.
/// Все действия с данными поражадаются отдельными методами.
/// Результат этих действий по факту окажется в соответствующем state.
class UserManager {
  UserManager(
    this._userInteractor,
    this._addressInteractor,
    this._paymentInteractor,
    this._authInfoStorage,
  );

  final UserInteractor _userInteractor;
  final AddressInteractor _addressInteractor;
  final PaymentInteractor _paymentInteractor;
  final AuthInfoStorage _authInfoStorage;
  Timer _lockTimer;

  /// Стрим с сотоянием пользователя
  final userState = EntityStreamedState<UserInfo>();

  /// Стрим с адресами пользователя
  final userAddressesState = EntityStreamedState<List<UserAddress>>();

  /// Стрим с картами пользователя
  final userCardsState = EntityStreamedState<List<PaymentCard>>();

  /// Состояние блокировки смены номера
  final changePhoneRequestLockedState = StreamedState<DateTime>();

  /// Количество заказов пользователя
  final ordersCountState = StreamedState<int>();

  /// Id пользователя
  String get id => userState?.value?.data?.id ?? _authInfoStorage.userIdLast;

  /// Вся ли информация для заказа есть
  bool get isFullOrderInfo =>
      userState?.value?.data?.name != null &&
      userState?.value?.data?.name?.trim() != '' &&
      userState?.value?.data?.lastName != null &&
      userState?.value?.data?.lastName?.trim() != '' &&
      userState?.value?.data?.email != null &&
      userState?.value?.data?.email?.trim() != '';

  /// Есть ли у пользователя адреса
  bool get hasAddresses => userAddressesState.value?.data?.isNotEmpty ?? false;

  /// Инициирует загрузку данных пользователя.
  /// Результат подразумевается окажется в userState.
  Future<void> loadUserInfo() async {
    await userState.loading(userState.value?.data);
    try {
      final result = await _userInteractor.getUser();
      await userState.content(result);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<UserInfo>.error(e, userState.value?.data);
      await userState.accept(newState);
      rethrow;
    }
  }

  /// Инициирует процесс обновления данных пользователя.
  /// Результат отразится в userState.
  Future<void> updateUserInfo(UpdateProfile update) async {
    await userState.loading(userState.value.data);

    try {
      await _userInteractor.updateUser(update);

      final info = UserInfo.patch(userState.value.data, update);
      await userState.content(info);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<UserInfo>.error(e, userState.value.data);
      await userState.accept(newState);
      rethrow;
    }
  }

  /// Инициирует процесс удаления данных пользователя.
  Future<String> deleteUserInfo() async {
    try {
      await _userInteractor.deleteAccount();
    } on DioError catch (e) {
      return e.response.data['userMessage'].toString();
    }
    return '';
  }

  /// Инициирует процесс смена номера телефона пользователем.
  /// В результате пользователю должна прийти смс.
  Future<void> changePhone(String phone) async {
    final DateTime lockDate = changePhoneRequestLockedState.value;
    if (lockDate != null && lockDate.isAfter(DateTime.now())) {
      throw UnavailableActionException(
        'Повторный запрос смены номера недоступен до ${lockDate.toIso8601String()}',
      );
    }

    final otp = await _userInteractor.changePhone(ChangePhone(phone: phone));
    final duration = Duration(seconds: otp.nextOtp.toInt());

    await changePhoneRequestLockedState.accept(DateTime.now().add(duration));

    _lockTimer?.cancel();
    _lockTimer = Timer(
      duration,
      () {
        changePhoneRequestLockedState.accept(null);
        _lockTimer = null;
      },
    );
  }

  /// Завершает процесс смена номера телефона пользователем.
  /// В случае позитивного исхода результат отразится на userState.
  /// Ошибка не приведет к изменению, а просто вернется из метода.
  Future<void> confirmChangePhone(String code, String phone) async {
    await _userInteractor.confirmChangePhone(
      ConfirmChangePhone(
        code: code,
        phone: phone,
      ),
    );

    final info = UserInfo.copy(userState.value.data, phone: phone);

    await userState.content(info);
  }

  /// Получение количества совершенных заказов
  Future<int> getOrdersCount ()async {
    final ordersCount = await _userInteractor.getOrdersCount();
    return ordersCount;
  }

  /// Добавить блюдо в любимые пользователю.
  Future<void> addFavourite(FavouriteItem item) async {
    await _userInteractor.addFavourite(item.id.toString());

    final currentInfo = userState.value.data;
    final info = UserInfo.copy(
      currentInfo,
      favourite: currentInfo.favourite.toList()..add(item),
    );

    await userState.content(info);
  }

  /// Удалить блюдо из любимых у пользователя.
  Future<void> removeFromFavourite(String id) async {
    await _userInteractor.removeFavourite(id);

    final currentInfo = userState.value.data;
    final info = UserInfo.copy(
      currentInfo,
      favourite: currentInfo.favourite.toList()
        ..removeWhere((favourite) => favourite.id.toString() == id),
    );

    await userState.content(info);
  }

  /// Поиск по доступным любимым блюдам
  Future<List<FavouriteItem>> searchFavourite(String searchText) async {
    final currentFavouriteId =
        userState.value?.data?.favourite?.map((f) => f.id) ?? [];
    final items = await _userInteractor.searchFavourite(searchText);
    return items..removeWhere((dish) => currentFavouriteId.contains(dish.id));
  }

  /// Загрузка адресов пользователя
  Future<void> loadUserAddresses() async {
    await userAddressesState.loading(userAddressesState.value?.data);
    try {
      final addresses = await _addressInteractor.getAddresses();
      await userAddressesState.content(addresses);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<UserAddress>>.error(
        e,
        userAddressesState.value.data,
      );
      await userAddressesState.accept(newState);
      rethrow;
    }
  }

  /// Добавление нового адреса пользователю
  Future<void> addAddress(NewAddress newAddress) async {
    await userAddressesState.loading(userAddressesState.value?.data);
    try {
      final addresses = await _addressInteractor.addAddress(newAddress);
      await userAddressesState.content(addresses);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<UserAddress>>.error(
        e,
        userAddressesState.value.data,
      );
      await userAddressesState.accept(newState);
      rethrow;
    }
  }

  /// Обновить адрес пользователя
  Future<void> updateAddress(int id, NewAddress address) async {
    await userAddressesState.loading(userAddressesState.value.data);
    try {
      final addresses = await _addressInteractor.updateAddress(
        id.toString(),
        address,
      );
      await userAddressesState.content(addresses);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<UserAddress>>.error(
        e,
        userAddressesState.value.data,
      );
      await userAddressesState.accept(newState);
      rethrow;
    }
  }

  /// Удалить адрес
  Future<void> removeAddress(int id) async {
    await userAddressesState.loading(userAddressesState.value.data);
    try {
      final addresses = await _addressInteractor.removeAddress(id.toString());
      await userAddressesState.content(addresses);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<UserAddress>>.error(
        e,
        userAddressesState.value.data,
      );
      await userAddressesState.accept(newState);
      rethrow;
    }
  }

  /// Загрузка списка карт пользователя
  Future<void> loadUserCards() async {
    await userCardsState.loading(userCardsState.value?.data);
    try {
      final cards = await _paymentInteractor.getPaymentCards();
      await userCardsState.content(cards);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<PaymentCard>>.error(
        e,
        userCardsState.value.data,
      );
      await userCardsState.accept(newState);
      rethrow;
    }
  }

  /// Удаление карты пользователя
  Future<void> deleteCard(String id) async {
    await userCardsState.loading(userCardsState.value?.data);
    try {
      await _paymentInteractor.deleteCard(id);
      final cards = userCardsState.value.data;
      if (cards != null) {
        await userCardsState.content(
          cards..removeWhere((e) => e.id == id),
        );
      }
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<PaymentCard>>.error(
        e,
        userCardsState.value.data,
      );
      await userCardsState.accept(newState);
      rethrow;
    }
  }

  /// Обновить дефолтную карту
  Future<void> updateDefaultCard(String id) async {
    await userCardsState.loading(userCardsState.value?.data);
    try {
      await _paymentInteractor.updateDefaultCard(id);
      final cards = userCardsState.value.data;
      if (cards != null) {
        await userCardsState.content(
          cards.map((card) => card.copyWith(isDefault: card.id == id)).toList(),
        );
      }
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState<List<PaymentCard>>.error(
        e,
        userCardsState.value.data,
      );
      await userCardsState.accept(newState);
      rethrow;
    }
  }
}
