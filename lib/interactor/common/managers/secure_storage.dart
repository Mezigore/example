import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uzhindoma/util/sp_helper.dart';

/// Хранилище.
class SecureStorage {
  SecureStorage(
    this._storage,
    this._preferencesHelper,
  )   : assert(_storage != null),
        assert(_preferencesHelper != null);

  Future<void> init() async {
    final isFirstRun = await _preferencesHelper.get<bool>(
      PreferencesHelper.keyFirstRun,
      true,
    );

    if (isFirstRun) {
      await _storage.deleteAll();
      await _preferencesHelper.set(PreferencesHelper.keyFirstRun, false);
    }
  }

  static const keyToken = 'KEY_TOKEN';
  static const keyUserId = 'KEY_USER_ID';
  static const keyRefreshToken = 'KEY_REFRESH_TOKEN';
  static const keyExpiresToken = 'KEY_EXPIRES_TOKEN';
  static const keyOnboardingComplete = 'KEY_ONBOARDING_COMPLETE';

  final FlutterSecureStorage _storage;
  final PreferencesHelper _preferencesHelper;

  /// Считать значение из хранилища.
  Future<String> getValue(String key) => _storage.read(key: key);

  /// Проверить наличие значения в хранилище.
  Future<bool> hasValue(String key) => _storage.containsKey(key: key);

  /// Записать значение в хранилище.
  Future<void> saveValue(String key, String value) =>
      _storage.write(key: key, value: value);

  /// Очистить хранилище.
  Future<void> cleanStorage() => _storage.deleteAll();

  /// Удалить значение из хранилища.
  Future<void> deleteValue(String key) => _storage.delete(key: key);
}
