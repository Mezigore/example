import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';

/// Получить уникальный Uid устройства
class UidManager {
  final _deviceInfo = DeviceInfoPlugin();

  String _uid;

  Future<String> get uid async => _uid ??= await _getUid();

  Future<String> _getUid() async {
    if (Platform.isAndroid) {
      return (await _deviceInfo.androidInfo).androidId;
    }
    if (Platform.isIOS) {
      return (await _deviceInfo.iosInfo).identifierForVendor;
    }
    throw PlatformException(
      message: 'Не поддерживаемое устройсво',
      code: 'unavailableDevice',
    );
  }
}
