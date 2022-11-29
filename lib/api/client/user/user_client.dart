import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/common/info_message.dart';
import 'package:uzhindoma/api/data/user/all_client_info.dart';
import 'package:uzhindoma/api/data/user/change_phone.dart';
import 'package:uzhindoma/api/data/user/conform_change_phone.dart';
import 'package:uzhindoma/api/data/user/favourite_item.dart';
import 'package:uzhindoma/api/data/user/otp_required.dart';
import 'package:uzhindoma/api/data/user/update_profile.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'user_client.g.dart';

/// Интерфейс API данных пользователя.
@RestApi()
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  /// Обновление телефона
  @PATCH(UserApiUrls.changePhone)
  Future<OtpRequiredData> patchChangePhone(@Body() ChangePhoneData changePhone);

  /// Подтверждение обновления телефона
  @PATCH(UserApiUrls.conformChangePhone)
  Future<InfoMessageData> patchConformChangePhone(
      @Body() ConformChangePhoneData conformChangePhone);

  /// Удаление любимого блюда из профиля
  @DELETE(UserApiUrls.favourite)
  Future<void> deleteFavourite(@Query('id') String id);

  /// Поиск по доступным любимым блюдам
  @GET(UserApiUrls.favourite)
  Future<List<FavouriteItemData>> getFavourite(
      @Query('searchText') String searchText);

  /// Добавление нового любимого блюда в профиль
  @POST(UserApiUrls.favourite)
  Future<void> postFavourite(@Query('id') String id);

  /// Получение количества заказов пользователя
  @GET(UserApiUrls.ordersCount)
  Future<int> getOrdersCount();

  /// Вся информация о пользователе
  @GET(UserApiUrls.profile)
  Future<AllClientInfoData> getProfile();

  /// Обновление профиля
  @PATCH(UserApiUrls.profile)
  Future<InfoMessageData> patchProfile(@Body() UpdateProfileData updateProfile);

  /// Удаление профиля
  @DELETE(UserApiUrls.deleteAccount)
  Future<void> deleteProfile();
}
