import 'package:crypt/crypt.dart';

/// Хеширование данных
class CryptManager {
  /// Вычисляет sha256 переданного значения.
  String getHash(
    String value, {
    String salt,
  }) {
    return Crypt.sha256(value, salt: salt).hash;
  }
}
