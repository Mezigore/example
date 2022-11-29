import 'package:uzhindoma/interactor/base/transformable.dart';

/// Response на <todo> ответ сервера
///
/// [https://javiercbk.github.io/json_to_dart/] для генерации
class TempResponse implements Transformable<Object> {
  TempResponse.fromJson(Map<String, dynamic> json) {
    json.toString();
    // encode
  }

  @override
  dynamic transform() {
    // transform
  }
}
