import 'package:dio/dio.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_logger/surf_logger.dart';

///Базовый класс для обработки ошибок, связанных с сервисным слоем
abstract class NetworkErrorHandler implements ErrorHandler {
  @override
  void handleError(Object e) {
    Exception exception;

    if (e is Error) {
      exception = Exception(e.stackTrace);
    } else if (e is Exception) {
      exception = e;
      Logger.d('NetworkErrorHandler handle error', exception);

      if (exception is ConversionException) {
        handleConversionError(exception);
      } else if (exception is NoInternetException) {
        handleNoInternetError(exception);
      } else if (exception is HttpProtocolException) {
        handleHttpProtocolException(exception);
      } else if (exception is DioError &&
          (exception.type == DioErrorType.connectTimeout ||
              exception.type == DioErrorType.receiveTimeout ||
              exception.type == DioErrorType.other)) {
        handleNoInternetError(
          NoInternetException(null),
        );
      } else {
        handleOtherError(exception);
      }
    }
  }

  void handleConversionError(ConversionException e);

  void handleNoInternetError(NoInternetException e);

  void handleHttpProtocolException(HttpProtocolException e);

  void handleOtherError(Exception e);
}

///Базовое http исключение
abstract class HttpException implements Exception {
  HttpException(this.response);

  final Response response;
}

///Неизвестный статус код
class UnknownHttpStatusCode extends HttpException {
  UnknownHttpStatusCode(Response response) : super(response);
}

///Пришло не 2хх
class HttpProtocolException extends HttpException {
  HttpProtocolException(Response response) : super(response);
}

///Перенаправление 3xx
class RedirectionHttpException extends HttpProtocolException {
  RedirectionHttpException(Response response) : super(response);
}

///Ошибка клиента 4xx
class ClientHttpException extends HttpProtocolException {
  ClientHttpException(Response response) : super(response);
}

///Ошибка сервера 5xx
class ServerHttpException extends HttpException {
  ServerHttpException(Response response) : super(response);
}

///Интернет недоступен
class NoInternetException extends HttpException {
  NoInternetException(Response response) : super(response);
}

///Ошибка парсинга ответа
class ConversionException extends HttpException {
  ConversionException(Response response) : super(response);
}
