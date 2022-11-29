import 'package:geolocator/geolocator.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/city_item.dart';
import 'package:uzhindoma/interactor/catalog/catalog_interactor.dart';
import 'package:uzhindoma/interactor/location/location_manager.dart';
import 'package:uzhindoma/interactor/permission/permission_exceptions.dart';

/// Менеджер управляющий работой с текущим городом.
/// В дальнейшем тут будет логика, определения города и тд.
/// Сейчас просто хардкодим.
class CityManager {
  CityManager(this._catalogInteractor, this._locationManager);

  final CatalogInteractor _catalogInteractor;
  final LocationManager _locationManager;

  /// EntityStreamedState нужен для состояний загрузки городов или
  /// ошибки при загрузке.
  ///
  /// !!! ВАЖНО И НЕОЧЕВИДНО:
  /// Должен выставляться в состоянии загрузки или ошибки только
  /// при загрузке списка городов.
  /// Выставление и смена города выполняется через состояние контента.
  final currentCity = EntityStreamedState<CityItem>();
  final _cityList = <CityItem>[];

  String get currentCityId => currentCity.value?.data?.id;

  /// Производит инициализацию - запрашивает список доступных
  /// городов и определяет город пользователя.
  Future<void> init() async {
    await _loadCities();
    if (!currentCity.value.hasError) {
      await _detectCity();
    }
  }

  Future<void> _loadCities() async {
    await currentCity.loading();

    try {
      final list = await _catalogInteractor.getCities();
      _cityList.addAll(list);
    } on Exception catch (e) {
      await currentCity.error(e);
    }
  }

  Future<void> _detectCity() async {
    CityItem cityFromRequest;
    Position position;

    try {
      position = await _locationManager.getLocationInfo();
    } on Exception catch (e) {
      if (e is! FeatureProhibitedException &&
          e is! FeatureNotEnabledException) {
        rethrow;
      }
    }

    try {
      cityFromRequest = position == null
          ? await _catalogInteractor.getCityByIp()
          : await _catalogInteractor.getCityByPosition(
              position.latitude,
              position.longitude,
            );
      final cityFromList = _cityList?.firstWhere(
        (e) => e.id == cityFromRequest.id,
        orElse: () {
          _cityList.add(cityFromRequest);
          return cityFromRequest;
        },
      );
      await currentCity.content(cityFromList);
    } on Exception {
      if (_cityList.isNotEmpty) {
        final moscow = _cityList.firstWhere(
          (city) => city.id == moscowId,
          orElse: () => CityItem.emptyCity,
        );
        if (moscow != CityItem.emptyCity) {
          await currentCity.content(moscow);
        } else {
          await currentCity.content(_cityList[0]);
        }
      }
    }
  }
}
