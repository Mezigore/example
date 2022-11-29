import 'package:uzhindoma/api/client/addresses/addresses_client.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/interactor/address/repository/address_data_mappers.dart';

/// Репозиторий для работы с адресами
class AddressRepository {
  AddressRepository(this._client);

  final AddressesClient _client;

  /// Удаление адреса пользователя
  Future<List<UserAddress>> removeAddress(String id) async {
    final addresses = await _client.deleteAddressesId(id);
    return addresses.map(mapUserAddress).toList();
  }

  /// Поиск доступных адресов для заказа
  Future<List<String>> searchAddress(String address) =>
      _client.getSearch(address);

  /// Получить адреса пользователя
  Future<List<UserAddress>> getAddresses() async {
    final data = await _client.getAddresses();
    return data.map(mapUserAddress).toList();
  }

  /// Добавление нового адреса
  Future<List<UserAddress>> addAddress(NewAddress newAddress) async {
    final data = mapNewAddressData(newAddress);
    final addresses = await _client.postAddresses(data);
    return addresses.map(mapUserAddress).toList();
  }

  /// Редактирование адреса пользователя
  Future<List<UserAddress>> updateAddress(
    String id,
    NewAddress newAddress,
  ) async {
    final data = mapNewAddressData(newAddress);
    final addresses = await _client.putAddressesId(id, data);
    return addresses.map(mapUserAddress).toList();
  }
}
