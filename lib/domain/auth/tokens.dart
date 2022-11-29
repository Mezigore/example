import 'package:flutter/material.dart';

/// Модель токенов авторизации.
/// Срок жизни имеет только access токен, токен для обновения в данной
/// реализации бессмертен. Теоретически его могут только отозвать.
///
/// [accessToken] - токен доступа.
/// [expires] - время истечения токена.
/// [refreshToken] - токен обновления.
class Tokens {
  Tokens({
    @required this.accessToken,
    @required this.tokenType,
    @required this.issued,
    @required this.expires,
    @required this.refreshToken,
    @required this.userId,
  });

  final String accessToken;
  final String tokenType;
  final DateTime issued;
  final DateTime expires;
  final String refreshToken;
  final String userId;
}
