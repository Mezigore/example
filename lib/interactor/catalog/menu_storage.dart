import 'package:uzhindoma/util/sp_helper.dart';

/// Хранилище доп данных
class MenuStorage {
  MenuStorage(this._preferencesHelper);

  static const _weekIdKey = 'weekKey';

  final PreferencesHelper _preferencesHelper;

  /// Получить id недели с которой работали
  Future<String> getLastWeek() => _preferencesHelper.get(_weekIdKey, null);

  /// Сохранить id недели, с которой работали
  Future<void> setLastWeek(String id) => _preferencesHelper.set(_weekIdKey, id);
}
