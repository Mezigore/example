import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uzhindoma/api/data/common/info_message.dart';
import 'package:uzhindoma/api/data/order/orders_history_rating.dart';
import 'package:uzhindoma/api/data/recipes/arhive.dart';
import 'package:uzhindoma/api/data/recipes/recipe.dart';
import 'package:uzhindoma/interactor/common/urls.dart';

part 'recipes_client.g.dart';

@RestApi()
abstract class RecipesClient {
  factory RecipesClient(Dio dio, {String baseUrl}) = _RecipesClient;

  /// Получение новых рецептов пользователя
  @GET(RecipesUrls.newRecipes)
  Future<List<RecipeData>> getNew();

  /// Получение всех рецептов пользователя
  @GET(RecipesUrls.recipes)
  Future<List<RecipeData>> getRecipes();

  /// Получение всех рецептов пользователя
  @GET(RecipesUrls.likeRecipes)
  Future<List<RecipeData>> getListLikeRecipes();

  /// Проставление оценок блюд для заказа
  @POST(OrderUrls.idRate)
  Future<InfoMessageData> postIdRate(
    @Path() String id,
    @Body() List<OrdersHistoryRatingData> ordersHistoryRaitings,
  );

  /// Изменение статуса рецепта
  @POST(RecipesUrls.recipeById)
  Future<InfoMessageData> postRecipesId(
    @Path() String id,
    @Body() ArhiveData arhive,
  );

  /// добавить в лайкнутые
  @GET(RecipesUrls.recipeLike)
  Future<void> getLikeRecipes(
    @Path() String id,
  );

  /// удалить из лайкнутых
  @GET(RecipesUrls.recipeUnlike)
  Future<void> getUnlikeRecipes(
    @Path() String id,
  );
}
