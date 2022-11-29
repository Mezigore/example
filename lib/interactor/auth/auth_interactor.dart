import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/auth/next_time_otp.dart';
import 'package:uzhindoma/domain/auth/public_key.dart';
import 'package:uzhindoma/domain/auth/tokens.dart';
import 'package:uzhindoma/interactor/auth/repository/auth_repository.dart';

/// Интерактор работы с авторизацией
class AuthInteractor {
  AuthInteractor(this._authRepository);

  final AuthRepository _authRepository;

  /// Обновить токен с помощью Refresh Token
  Future<Tokens> updateToken(String refreshToken) =>
      _authRepository.exchangeToken(refreshToken);

  /// Зарегестрировать uid на сервере
  Future<PublicKey> checkIn(String uid) => _authRepository.checkIn(uid);

  /// Проверка полученного из смс otp кода
  Future<Tokens> checkCode({
    @required String phoneNumber,
    @required String code,
    @required String publicKey,
    @required String hashUid,
  }) =>
      _authRepository.checkCode(
        phoneNumber: phoneNumber,
        code: code,
        publicKey: publicKey,
        hashUid: hashUid,
      );

  /// Заропсить код otp по номеру телефона
  Future<NextTimeOtp> sendCode({
    @required String phoneNumber,
    @required String publicKey,
    @required String hashUid,
  }) =>
      _authRepository.sendCode(
        phoneNumber: phoneNumber,
        publicKey: publicKey,
        hashUid: hashUid,
      );
}
