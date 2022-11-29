import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/interactor/permission/permission_exceptions.dart';
import 'package:uzhindoma/interactor/permission/permission_manager.dart';

/// Менеджер для получения и хранения местоположения устройства
class LocationManager {
  LocationManager(this._permissionManager);

  final PermissionManager _permissionManager;

  final locationState = EntityStreamedState<Position>();

  Permission get _permission => Permission.locationWhenInUse;

  /// Запрос разрешения на геолокацию
  Future<bool> requestLocationPermission() {
    return _permissionManager.request(_permission);
  }

  /// Перейти в настройки
  Future<bool> openSettings() => _permissionManager.openSettings();

  /// Получение информации о местоположении пользователя
  Future<Position> getLocationInfo() async {
    final isGranted = await requestLocationPermission();
    if (!isGranted) throw FeatureProhibitedException();
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) throw FeatureNotEnabledException();
    return Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 10),
    );
  }
}
