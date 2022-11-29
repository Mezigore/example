import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/interactor/address/repository/address_repository.dart';

/// Интерактор для работы с адресами
class AddressInteractor {
  AddressInteractor(this._repository);

  final AddressRepository _repository;

  /// Удаление адреса пользователя
  Future<List<UserAddress>> removeAddress(String id) =>
      _repository.removeAddress(id);

  /// Поиск доступных адресов для заказа
  Future<List<String>> searchAddress(String address) =>
      _repository.searchAddress(address);

  /// Получить адреса пользователя
  Future<List<UserAddress>> getAddresses() => _repository.getAddresses();

  /// Добавление нового адреса
  Future<List<UserAddress>> addAddress(NewAddress newAddress) =>
      _repository.addAddress(newAddress);

  /// Редактирование адреса пользователя
  Future<List<UserAddress>> updateAddress(String id, NewAddress newAddress) =>
      _repository.updateAddress(id, newAddress);
}
