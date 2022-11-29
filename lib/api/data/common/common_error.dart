import 'package:json_annotation/json_annotation.dart';

part 'common_error.g.dart';

/// Это общий тип ошибки, который может возвращать сервер.
@JsonSerializable()
class CommonErrorData {
  CommonErrorData({
    this.code,
    this.developerMessage,
    this.userMessage,
  });

  factory CommonErrorData.fromJson(Map<String, dynamic> json) =>
      _$CommonErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommonErrorDataToJson(this);

  /// Это идентификатор ошибки. Этот идентификатор мобильное приложение будет использовать для того, чтобы включать определенное поведение
  int code;

  /// Пояснение для разработчика/тестировщика о том, что пошло не так
  String developerMessage;

  /// Сообщение, которое будет выведено пользователю в интерфейсе
  String userMessage;
}
