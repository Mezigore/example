import 'package:uzhindoma/domain/auth/tokens.dart';
import 'package:uzhindoma/interactor/common/managers/secure_storage.dart';

/// Хранилище токена сессии
class AuthInfoStorage {
  AuthInfoStorage(this._secureStorage) {
    readUserId().then((value) => userIdLast = value);
  }

  final SecureStorage _secureStorage;
  String _token;
  String userIdLast;

  /// Получить текущий токен.
  String getToken() => _token;

  /// Считать токен из хранилища.
  /// В случае наличия токена в хранилище, в случае наличия
  /// валидного токена в хранилище, он будет использован как текущий.
  Future<String> readToken() async {
    final rawExpires =
        await _secureStorage.getValue(SecureStorage.keyExpiresToken);
    final isExpired = rawExpires == null ||
        (DateTime.tryParse(rawExpires)?.isBefore(DateTime.now()) ?? true);

    if (!isExpired) {
      final token = await _secureStorage.getValue(SecureStorage.keyToken);
      if (token != null) {
        _token = token;
        return _token;
      }
    }

    return null;
  }

  /// Считать токен для обновления из хранилища.
  Future<String> readRefreshToken() async {
    final refreshToken =
        await _secureStorage.getValue(SecureStorage.keyRefreshToken);
    return refreshToken;
  }

  /// Считать ID пользователя.
  Future<String> readUserId() async {
    final id = await _secureStorage.getValue(SecureStorage.keyUserId);
    return id;
  }

  /// Сохраняет токены в хранилище.
  /// Актуализирует текущий токен.
  Future<void> saveTokens(Tokens tokens) async {
    await _secureStorage.saveValue(SecureStorage.keyToken, tokens.accessToken);
    await _secureStorage.saveValue(
      SecureStorage.keyExpiresToken,
      tokens.expires.toIso8601String(),
    );
    await _secureStorage.saveValue(
      SecureStorage.keyRefreshToken,
      tokens.refreshToken,
    );
    await _secureStorage.saveValue(SecureStorage.keyUserId, tokens.userId);
    userIdLast = tokens.userId;

    _token = tokens.accessToken;
  }

  /// Сбросить данные по авторизации, включая текущий токен.
  Future<void> clearData() async {
    await _secureStorage.deleteValue(SecureStorage.keyToken);
    await _secureStorage.deleteValue(SecureStorage.keyUserId);
    await _secureStorage.deleteValue(SecureStorage.keyRefreshToken);
    await _secureStorage.deleteValue(SecureStorage.keyExpiresToken);

    _token = null;
  }
}
