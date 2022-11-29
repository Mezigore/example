import 'package:dio/dio.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/util/const.dart';

/// Интерцептор, который следит за валидностью авторизационного токена-доступа
class RefreshTokenInterceptor implements Interceptor {
  RefreshTokenInterceptor(this._authManger);

  final AuthManager _authManger;

  @override
  Future onRequest(RequestOptions options, handler) async => handler.next(options);

  @override
  Future onResponse(Response<dynamic> response, handler) async => handler.next(response);

  @override
  Future onError(DioError err, handler) async {
    if (err.response?.statusCode == authHttpCode) {
      try {
        final isSuccess = await _authManger.prolongAuth();
        if (!isSuccess) await _authManger.logout();
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        // При любой плохой ситуации
        await _authManger.logout();
      }
    }
    return handler.next(err);
  }
}
