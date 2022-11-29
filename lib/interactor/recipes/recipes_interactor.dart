import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/recipes/repository/recipes_repository.dart';
import 'package:uzhindoma/util/future_utils.dart';

/// Репозиторий для работы с рецептами пользователя
class RecipesInteractor {
  RecipesInteractor(this._repository);

  final RecipesRepository _repository;

  /// Получение новых рецептов пользователя
  Future<List<Recipe>> getActualRecipes() {
    return checkMapping(_repository.getActualRecipes());
  }

  /// Получение всех рецептов пользователя
  Future<List<Recipe>> getAllRecipes() {
    return checkMapping(_repository.getAllRecipes());
  }

  /// Получение любимых рецептов пользователя
  Future<List<Recipe>> getLikeRecipes() {
    return checkMapping(_repository.getLikeRecipes());
  }

  /// Оценка блюд из заказа
  Future<void> rateRecipe(
    String id,
    List<OrdersHistoryRating> ordersHistoryRatings,
  ) {
    return checkMapping(_repository.rateRecipe(id, ordersHistoryRatings));
  }

  /// Изменение статуса рецепта
  // ignore: avoid_positional_boolean_parameters
  Future<void> moveRecipeToArchive(String recipeId) =>
      _repository.changeRecipeStatus(
        recipeId,
        true,
      );

  /// добавить в лайкнутые
  Future<void> likeRecipes(String productId) =>
      _repository.changeLikeStatus(
        productId,
      );

  /// удалить из лайкнутых
  Future<void> unlikeRecipes(String productId) =>
      _repository.changeUnlikeStatus(
        productId,
      );
}
