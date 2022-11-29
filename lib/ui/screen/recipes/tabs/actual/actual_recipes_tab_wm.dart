import 'dart:developer';

import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/recipes/recipes_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <ActualRecipesTab>
class ActualRecipesTabWidgetModel extends WidgetModel with ReloadMixin {
  ActualRecipesTabWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._recipesManager,
    this._messageController,
  ) : super(dependencies);

  //ignore: unused_field
  final NavigatorState _navigator;
  final MessageController _messageController;
  final RecipesManager _recipesManager;

  final actualRecipesState = EntityStreamedState<Map<String, List<Recipe>>>();
  final recipeTapAction = Action<Recipe>();

  /// Нажатие на кнопку лайка
  final likeAction = Action<String>();
  final unlikeAction = Action<String>();

  @override
  void onLoad() {
    super.onLoad();
    subscribe<EntityState<List<Recipe>>>(
        _recipesManager.actualRecipesState.stream, (entity) {
      actualRecipesState.accept(
        EntityState(
          data: entity.data == null ? null : _sortRecipes(entity.data),
          isLoading: entity.isLoading,
          hasError: entity.hasError,
        ),
      );
    });
    if (actualRecipesState.value?.data == null) reloadData();
  }

  @override
  void onBind() {
    super.onBind();
    bind(recipeTapAction, _openRecipeDetails);

    bind<void>(likeAction, (productId) => _likeRecipe(productId as String));
    bind<void>(unlikeAction, (productId) => _unlikeRecipe(productId as String));
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _recipesManager.loadActualRecipes(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }

  Map<String, List<Recipe>> _sortRecipes(List<Recipe> recipes) {
    final sorted = <DateTime, List<Recipe>>{};
    final List<String> listId = [];
    final dateNow = DateTime.now();
    // ignore: avoid_function_literals_in_foreach_calls
    recipes.forEach((r) {
      if(r.rate==0){
        if(r.hideTime.compareTo(dateNow) >= 0){
          if(!listId.contains(r.productId)){
            sorted[r.cookBefore] = (sorted[r.cookBefore] ?? [])..add(r);
          }
          listId.add(r.productId);
        }
      }
    });
    final keys = sorted.keys.toList()
      ..sort(
        (first, second) => first.compareTo(second),
      );
    return {for (var key in keys) sorted[key].first.dateTitle: sorted[key]};
  }

  Future<void> _openRecipeDetails(Recipe recipe) async {
    final isMoved = await _navigator.pushNamed<bool>(
      AppRouter.recipeDetail,
      arguments: Pair(recipe, false),
    );
    if (isMoved ?? false) {
      _messageController.show(msg: recipesDoneSnack, msgType: MsgType.common);
    }
  }

  Future<void> _likeRecipe(String productId) async{
    await _recipesManager.likeRecipe(productId);
    // reloadData();
  }

  Future<void> _unlikeRecipe(String productId) async {
    await _recipesManager.unlikeRecipe(productId);
    // reloadData();
  }

  // Future<void> changeLikeStatusTap(String productId, bool isLike) async {
  //   // await isLoadingState.accept(true);
  //   if (isLike) {
  //     await _recipesManager.unlikeRecipe(productId);
  //   } else {
  //     await _recipesManager.likeRecipe(productId);
  //   }
  // }
}
