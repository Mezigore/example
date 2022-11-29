import 'package:uzhindoma/interactor/common/exceptions.dart';

/// Проверка на ошибку во время маппинга данных
Future<T> checkMapping<T>(Future<T> future) async {
  try {
    final res = await future;
    return res;
    // ignore: avoid_catching_errors
  } on Error catch (e) {
    //Возникла ошибка, Error - чаще всего связана с Мапингом данных
    throw MappingException(e);
  }
}
