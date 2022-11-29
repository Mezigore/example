import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/recipes/recipes_manager.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';

/// [WidgetModel] для <LikeRecipesTab>
class LikeRecipesTabWidgetModel extends WidgetModel with ReloadMixin {
  LikeRecipesTabWidgetModel(
      WidgetModelDependencies dependencies,
      this._navigator,
      this._recipesManager,
      ) : super(dependencies);

  //ignore: unused_field
  final NavigatorState _navigator;
  final RecipesManager _recipesManager;

  /// Нажатие на кнопку лайка
  final likeAction = Action<String>();
  final unlikeAction = Action<String>();

  final likeRecipesState = EntityStreamedState<List<Recipe>>();
  // EntityStreamedState<List<Recipe>> get likeRecipesState =>
  //     _recipesManager.likeRecipesState;

  @override
  void onLoad() {
    super.onLoad();
    subscribe<EntityState<List<Recipe>>>(
        _recipesManager.likeRecipesState.stream, (entity) {
      likeRecipesState.accept(
        EntityState(
          data: entity.data,
          isLoading: entity.isLoading,
          hasError: entity.hasError,
        ),
      );
    });
    if (likeRecipesState.value?.data == null) reloadData();

    // if (likeRecipesState.value?.data == null || likeRecipesState.value.data.isEmpty) reloadData();
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(likeAction, (productId) => _likeRecipe(productId as String));
    bind<void>(unlikeAction, (productId) => _unlikeRecipe(productId as String));
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _recipesManager.loadLikeRecipes(),
          (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }

  Future<void> _likeRecipe(String productId) async{
    await _recipesManager.likeRecipe(productId);
    // reloadData();
  }

  Future<void> _unlikeRecipe(String productId) async {
    await _recipesManager.unlikeRecipe(productId);
    // reloadData();
  }
}
