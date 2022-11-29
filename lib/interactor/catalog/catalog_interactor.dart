import 'package:uzhindoma/domain/catalog/city_item.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/recommendation_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/interactor/catalog/repository/catalog_repository.dart';
import 'package:uzhindoma/util/future_utils.dart';

/// Интерактор для работы с каталогом.
class CatalogInteractor {
  CatalogInteractor(this._catalogRepository);

  final CatalogRepository _catalogRepository;

  /// Возвращает информацию о доступных неделях
  /// [city] - идентификатор города
  Future<List<WeekItem>> getWeekInfo(String city) {
    return _catalogRepository.getWeekInfo(city);
  }

  /// Возвращает список доступных городов.
  Future<List<CityItem>> getCities() {
    return _catalogRepository.getCities();
  }

  /// Возвращает меню для города на указанную неделю.
  Future<List<CategoryItem>> getMenu(String city, String date) {
    return checkMapping(_catalogRepository.getMenu(city, date));
  }

  /// Возвращает список рекомендаций
  Future<RecommendationItem> getRecommend(String id) {
    return _catalogRepository.getRecommend(id);
  }

  /// Возвращает город по координатам
  Future<CityItem> getCityByPosition(double lat, double long) {
    return _catalogRepository.getCityByPosition(lat, long);
  }

  /// Возвращает город по ip
  Future<CityItem> getCityByIp() {
    return _catalogRepository.getCityByIp();
  }
}
