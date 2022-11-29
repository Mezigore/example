import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/catalog/city_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/category_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/promo_item_data.dart';
import 'package:uzhindoma/api/data/catalog/menu/recommendation_item_data.dart';
import 'package:uzhindoma/api/data/catalog/week_item_data.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'dart:developer';

part 'catalog_client.g.dart';

/// Интерфейс API каталога.
@RestApi()
abstract class CatalogClient {
  factory CatalogClient(Dio dio, {String baseUrl}) = _CatalogClient;

  @GET(CatalogApiUrl.menu)
  Future<List<CategoryItemData>> getMenu(
    @Query('city') String city,
    @Query('date') String date,
  );

  @GET(CatalogApiUrl.weeks)
  Future<List<WeekItemData>> getWeekInfo(@Query('city') String city);

  @GET(CatalogApiUrl.recommend)
  Future<RecommendationItemData> recommend(@Query('id') String id);

  @GET(CatalogApiUrl.promo)
  Future<PromoItemData> getPromo();

  @GET(CatalogApiUrl.cities)
  Future<List<CityItemData>> getCities();

  /// Получение предпочитаемого для пользователя города на основе переданных координат и данных на сервере.
  @GET(CatalogApiUrl.citiesByPosition)
  Future<CityItemData> getCityByPosition(
    @Query('lat') double lat,
    @Query('long') double long,
  );

  /// Получение предпочитаемого для пользователя города на основе переданных данных
  @GET(CatalogApiUrl.citiesByPosition)
  Future<CityItemData> getCityByIp();
}
