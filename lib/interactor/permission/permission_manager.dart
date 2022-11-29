import 'package:permission_handler/permission_handler.dart';

/// Менеджер разрешений
class PermissionManager {
  Future<bool> openSettings() => openAppSettings();

  /// Запрос разрешения
  Future<bool> request(Permission permission) async {
    final status = await permission.request();
    return _isGoodStatus(status);
  }

  /// Есть ли разрешение у приложения (без запроса)
  Future<bool> check(Permission permission) async {
    final status = await permission.status;
    return _isGoodStatus(status);
  }

  /// Полный статус разрешения
  Future<PermissionStatus> getPermissionStatus(Permission permission) {
    return permission.status;
  }

  /// Проверка на то, что разрешение еще не запрашивалось
  Future<bool> isNeverRequested(Permission permission) async {
    final status = await getPermissionStatus(permission);
    return status == PermissionStatus.denied;
  }

  bool _isGoodStatus(PermissionStatus status) =>
      status == PermissionStatus.granted ||
      status == PermissionStatus.restricted;
}
