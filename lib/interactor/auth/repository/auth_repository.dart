import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:uzhindoma/api/data/auth/next_time_otp_data.dart';
import 'package:uzhindoma/api/data/auth/public_key_data.dart';
import 'package:uzhindoma/api/data/auth/tokens_data.dart';
import 'package:uzhindoma/domain/auth/next_time_otp.dart';
import 'package:uzhindoma/domain/auth/public_key.dart';
import 'package:uzhindoma/domain/auth/tokens.dart';
import 'package:uzhindoma/interactor/auth/repository/auth_data_mapper.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

/// Репозиторий работы с авторизацией
class AuthRepository {
  AuthRepository(this._dio);

  final Dio _dio;

  /// Зарегестрировать uid на сервере
  Future<PublicKey> checkIn(String uid) async {
    final response = await _dio.post<Map<String, dynamic>>(
      AuthApiUrls.checkIn,
      data: {'uid': uid},
    );
    final value = PublicKeyData.fromJson(response.data);

    return mapPublicKey(value);
  }

  /// Проверка полученного из смс otp кода
  Future<Tokens> checkCode({
    @required String phoneNumber,
    @required String code,
    @required String publicKey,
    @required String hashUid,
  }) async {
    final response = await _dio.post<Map<String, Object>>(
      AuthApiUrls.checkCode,
      data: {
        'phone': phoneNumber,
        'code': code,
      },
      options: Options(
        headers: <String, String>{
          'pk': publicKey,
          'hu': hashUid,
        },
      ),
    );

    final value = TokensData.fromJson(response.data);
    return mapTokens(value);
  }

  /// Обновить токен с помощью Refresh Token
  Future<Tokens> exchangeToken(String refreshToken) async {
    final response = await _dio.post<Map<String, Object>>(
      AuthApiUrls.exchangeToken,
      data: {'refresh_token': refreshToken},
    );

    final value = TokensData.fromJson(response.data);
    return mapTokens(value);
  }

  Future<NextTimeOtp> sendCode({
    @required String phoneNumber,
    @required String publicKey,
    @required String hashUid,
  }) async {
    final response = await _dio.post<Map<String, Object>>(
      AuthApiUrls.sendCode,
      data: {'phone': phoneNumber},
      options: Options(
        headers: <String, String>{
          'pk': publicKey,
          'hu': hashUid,
        },
      ),
    );

    final value = NextTimeOtpData.fromJson(response.data);
    return mapNextTimeOtp(value);
  }
}
