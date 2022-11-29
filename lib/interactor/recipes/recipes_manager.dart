import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/recipes/recipes_interactor.dart';

/// Менеджер для работы с рецептами пользователя
class RecipesManager {
  RecipesManager(this._recipesInteractor);

  final RecipesInteractor _recipesInteractor;

  /// Стрим с актуальными рецептами пользователя
  final actualRecipesState = EntityStreamedState<List<Recipe>>();

  /// Стрим со всеми рецептами пользователя
  final recipesFromHistoryState = EntityStreamedState<List<Recipe>>();

  /// Стрим с любимыми рецептами пользователя
  final likeRecipesState = EntityStreamedState<List<Recipe>>();

  /// Инициирует процесс загрузки актуальных рецептов пользователя.
  /// Результат отразится в actualRecipesState.
  Future<void> loadActualRecipes() async {
    await actualRecipesState.loading(actualRecipesState.value?.data);

    try {
      final recipes = await _recipesInteractor.getAllRecipes();
      await actualRecipesState.content(recipes);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState = EntityState.error(e, actualRecipesState.value?.data);
      await actualRecipesState.accept(newState);
      rethrow;
    }
  }

  /// Инициирует процесс зкгрузки старых рецептов пользователя.
  /// Результат отразится в recipesFromHistoryState.
  Future<void> loadOldRecipes() async {
    await recipesFromHistoryState.loading(recipesFromHistoryState.value?.data);

    try {
      final recipes = await _recipesInteractor.getAllRecipes();
      await recipesFromHistoryState.content(recipes);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState =
          EntityState.error(e, recipesFromHistoryState.value?.data);
      await recipesFromHistoryState.accept(newState);
      rethrow;
    }
  }

  /// Инициирует процесс зкгрузки любимых рецептов пользователя.
  /// Результат отразится в likeRecipesState.
  Future<void> loadLikeRecipes() async {
    await likeRecipesState.loading(likeRecipesState.value?.data);

    try {
      final recipes = await _recipesInteractor.getLikeRecipes();
      await likeRecipesState.content(recipes);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState =
          EntityState.error(e, likeRecipesState.value?.data);
      await likeRecipesState.accept(newState);
      rethrow;
    }
  }

  bool search = false;

  Future<void> searchOldRecipes({String value}) async {
    final List<Recipe> searchList = [];
    try {
      final recipes = await _recipesInteractor.getAllRecipes();
      if(value.isEmpty){
        search = false;
        await recipesFromHistoryState.content(recipes);
      }else{
        for(int i = 0; i < recipes.length; i++){
          if(recipes[i].name.toLowerCase().contains(value.toLowerCase()) || recipes[i].willDeliver.toLowerCase().contains(value.toLowerCase())){
            searchList.add(recipes[i]);
          }
        }
        search = true;
        await recipesFromHistoryState.content(searchList);
      }
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState =
          EntityState.error(e, recipesFromHistoryState.value?.data);
      await recipesFromHistoryState.accept(newState);
      rethrow;
    }
  }

  Future<void> rateRecipe(
      String orderId,
      List<OrdersHistoryRating> ordersHistoryRatings,
      ) async {
    await _recipesInteractor.rateRecipe(orderId, ordersHistoryRatings);
  }

  /// Перенос рецепта в историю
  Future<void> moveRecipeToHistory(String recipeId, String orderId) async {
    await recipesFromHistoryState.loading(recipesFromHistoryState.value?.data);

    try {
      await _recipesInteractor.moveRecipeToArchive(recipeId);
      final actual = actualRecipesState.value?.data ?? [];
      final old = recipesFromHistoryState.value?.data;

      final recipe = actual.firstWhere(
        (e) => e.id == recipeId,
        orElse: () => null,
      );
      if (recipe != null) {
        actual.removeWhere((e) => e.id == recipeId);
        old?.add(recipe);
      }
      await actualRecipesState.content(actual);
      if (old != null) await recipesFromHistoryState.content(old);
    } on Exception catch (e) {
      // делаем вручную чтобы протащить на всякий случай старые данные
      final newState =
          EntityState.error(e, recipesFromHistoryState.value?.data);
      await recipesFromHistoryState.accept(newState);
      rethrow;
    }
  }
  Future<void> likeRecipe(String productId) async {
    try{
      await _recipesInteractor.likeRecipes(productId);
    }
    on DioError catch (e){
      log('$e',name: 'likeRecipe error');
      rethrow;
    }
  }
  Future<void> unlikeRecipe(String productId) async {
    try{
      await _recipesInteractor.unlikeRecipes(productId);
    }
    on DioError catch (e){
      log('$e',name: 'unlikeRecipes error');
      rethrow;
    }
  }
}
