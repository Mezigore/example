import 'package:dio/dio.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/ui/base/error/network_error_handler.dart';
import 'package:uzhindoma/util/extension/extensions.dart';

///Стандартный для проекта обработчик статус кода
class DefaultStatusMapper {
  void checkStatus(Response response) {
    final statusCategory = _getFirstNumberFromStatus(response.statusCode);
    switch (statusCategory) {
      case 1:
        checkInformationalStatus(response);
        return;
      case 2:
        checkSuccessStatus(response);
        return;
      case 3:
        checkRedirectStatus(response);
        return;
      case 4:
        checkClientStatus(response);
        return;
      case 5:
        checkServerStatus(response);
        return;
      default:
        throw UnknownHttpStatusCode(response);
    }
  }

  ///status 1xx
  void checkInformationalStatus(Response response) {}

  ///status 2xx
  void checkSuccessStatus(Response response) {}

  ///status 3xx
  void checkRedirectStatus(Response response) {
    throw RedirectionHttpException(response);
  }

  ///status 4xx
  void checkClientStatus(Response response) {
    ErrorResponse er;

    //todo смапить основные ошибки сервера в проекте
    try {
      er = ErrorResponse.fromResponse(response);
      switch (er.errorCode) {
        case 105:
          throw NotFoundException(er.message);
        default:
          throw ClientHttpException(response);
      }
    } on Exception {
      rethrow;
    }
  }

  ///status 5xx
  void checkServerStatus(Response response) {
    throw ServerHttpException(response);
  }

  ///получить первую цифру статус кода
  int _getFirstNumberFromStatus(int status) {
    final firstNumberStr = status.toString()[0];
    return int.parse(firstNumberStr);
  }
}

/// Response с ошибкой
class ErrorResponse {
  ErrorResponse({this.errorCode, this.message});

  ErrorResponse.fromResponse(Response response) {
    errorCode = response.statusCode;
    message = response.statusMessage;
  }

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json.get<int>('errorCode');
    message = json.get<String>('message');
  }

  int errorCode;
  String message;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }
}
