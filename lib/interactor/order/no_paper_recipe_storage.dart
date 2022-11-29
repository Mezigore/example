import 'package:flutter/material.dart';
import 'package:uzhindoma/util/sp_helper.dart';

/// Хранилище для флага 'Отказ от печатных рецептов' при оформлении заказа
class NoPaperRecipeStorage {
  NoPaperRecipeStorage(this._preferencesHelper);

  static const _isNoPaperRecipeIdKey = 'needPaperKey';

  final PreferencesHelper _preferencesHelper;

  /// Получить текущий флаг чекбокса 'Отказ от печатных рецептов'
  Future<bool> getNoPaper() =>
      _preferencesHelper.get(_isNoPaperRecipeIdKey, false);

  /// Сохранить новый флаг чекбокса
  Future<void> setNoPaper({@required bool isNoPaperRecipe}) =>
      _preferencesHelper.set(_isNoPaperRecipeIdKey, isNoPaperRecipe);

  /// Значение по умолчанию флаг чекбокса
  Future<void> setDefaultNoPaper() =>
      _preferencesHelper.set(_isNoPaperRecipeIdKey, false);
}
