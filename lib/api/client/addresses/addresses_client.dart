import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/address/new_address.dart';
import 'package:uzhindoma/api/data/address/user_address.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'addresses_client.g.dart';

@RestApi()
abstract class AddressesClient {
  factory AddressesClient(Dio dio, {String baseUrl}) = _AddressesClient;

  /// Получение списка адресов пользователя
  @GET(AddressesUrls.addresses)
  Future<List<UserAddressData>> getAddresses();

  /// Добавление нового адреса
  @POST(AddressesUrls.addresses)
  Future<List<UserAddressData>> postAddresses(
      @Body() NewAddressData newAddress);

  /// Удаление адреса пользователя
  @DELETE(AddressesUrls.addressById)
  Future<List<UserAddressData>> deleteAddressesId(@Path() String id);

  /// Редактирование адреса пользователя
  @PUT(AddressesUrls.addressById)
  Future<List<UserAddressData>> putAddressesId(
      @Path() String id, @Body() NewAddressData newAddress);

  /// Поиск доступных адресов для заказа
  @GET(AddressesUrls.search)
  Future<List<String>> getSearch(@Query('address') String address);
}
