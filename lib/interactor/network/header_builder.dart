import 'package:uzhindoma/interactor/token/token_storage.dart';
import 'package:uzhindoma/util/const.dart';

/// Реализация билдера заголовков http запросов
class DefaultHeaderBuilder {
  DefaultHeaderBuilder(this._ts);

  String t = emptyString;

  final AuthInfoStorage _ts;

  Map<String, String> buildDynamicHeader(String url) {
    final headers = <String, String>{};

    if (url != null && url.isNotEmpty) {
      final token = _ts.getToken();
      if (token != null) {
        headers['X-Auth-Token'] = token;
      }
    }

    return headers;
  }
}
