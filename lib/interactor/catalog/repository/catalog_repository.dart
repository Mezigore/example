import 'package:uzhindoma/api/client/catalog/catalog_client.dart';
import 'package:uzhindoma/domain/catalog/city_item.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/menu/promo_item.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/interactor/catalog/repository/catalog_data_mappers.dart';


/// Репозиторий для работы с каталогом.
class CatalogRepository {
  CatalogRepository(this._catalogClient);

  final CatalogClient _catalogClient;

  /// Возвращает информацию о доступных неделях.
  /// [city] - идентификатор города.
  Future<List<WeekItem>> getWeekInfo(String city) {
    return _catalogClient
        .getWeekInfo(city)
        .then((value) => value.map(mapWeekItem).toList());
  }

  /// Возвращает список доступных городов.
  Future<List<CityItem>> getCities() {
    return _catalogClient
        .getCities()
        .then((value) => value.map(mapCityItem).toList());
  }

  /// Возвращает меню для города на указанную неделю.
  Future<List<CategoryItem>> getMenu(String city, String date) {
    return _catalogClient
        .getMenu(city, date)
        .then((value) {
          return value.map(mapCategoryItem).toList();
    } );
  }

  /// Возвращает список рекомендаций
  Future<RecommendationItem> getRecommend(String id) async {
    final data = await  _catalogClient.recommend(id);
    return mapRecommendationItem(data);
  }

 /// Возвращает промо набор
  Future<PromoItem> getPromo() async {
    final data = await  _catalogClient.getPromo();
    return mapPromoItem(data);
  }

  /// Возвращает город по координатам
  Future<CityItem> getCityByPosition(double lat, double long) async {
    final data = await _catalogClient.getCityByPosition(lat, long);
    return mapCityItem(data);
  }

  /// Возвращает город по ip
  Future<CityItem> getCityByIp() async {
    final data = await _catalogClient.getCityByIp();
    return mapCityItem(data);
  }
}
