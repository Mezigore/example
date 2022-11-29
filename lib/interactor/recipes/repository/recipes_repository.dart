import 'package:uzhindoma/api/client/recipes/recipes_client.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/order/order_repository/order_mappers.dart';
import 'package:uzhindoma/interactor/recipes/repository/recipes_data_mappers.dart';

/// Репозиторий для работы с рецептами пользователя
class RecipesRepository {
  RecipesRepository(this._client);

  final RecipesClient _client;

  /// Получение новых рецептов пользователя
  Future<List<Recipe>> getActualRecipes() async {
    final data = await _client.getNew();
    return data?.map(mapRecipe)?.toList() ?? [];
  }

  /// Получение всех рецептов пользователя
  Future<List<Recipe>> getAllRecipes() async {
    final data = await _client.getRecipes();
    return data?.map(mapRecipe)?.toList() ?? [];
  }

 /// Получение всех рецептов пользователя
  Future<List<Recipe>> getLikeRecipes() async {
    final data = await _client.getListLikeRecipes();
    return data?.map(mapRecipe)?.toList() ?? [];
  }

  /// Оценка блюд из заказа
  Future<void> rateRecipe(
    String id,
    List<OrdersHistoryRating> ordersHistoryRatings,
  ) {
    return _client.postIdRate(
      id,
      ordersHistoryRatings.map(mapOrdersHistoryRatingData).toList(),
    );
  }

  /// Изменение статуса рецепта
  // ignore: avoid_positional_boolean_parameters
  Future<void> changeRecipeStatus(String recipeId, bool toArchive) async {
    final archiveData = mapArhiveData(toArchive);
    return _client.postRecipesId(recipeId, archiveData);
  }

  /// добавить в лайкнутые
  Future<void> changeLikeStatus(String productId) async {
    return _client.getLikeRecipes(productId);
  }

  /// удалить из лайкнутых
  Future<void> changeUnlikeStatus(String productId) async {
    return _client.getUnlikeRecipes(productId);
  }
}
