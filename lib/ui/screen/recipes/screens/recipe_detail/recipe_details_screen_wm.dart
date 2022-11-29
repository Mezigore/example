import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/interactor/recipes/recipes_manager.dart';
import 'package:wakelock/wakelock.dart';

/// [WidgetModel] для <RecipeDetailsScreen>
class RecipeDetailsScreenWidgetModel extends WidgetModel {
  RecipeDetailsScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.recipe,
    // ignore: avoid_positional_boolean_parameters
    this.isArchived,
    this._recipesManager,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final RecipesManager _recipesManager;
  final Recipe recipe;
  final bool isArchived;

  /// Нажатие на кнопку блюдо готово
  final doneAction = Action<int>();
  final isLoadingState = StreamedState<bool>(false);

  @override
  void onBind() {
    super.onBind();
    bind(doneAction, _onDoneTap);
    Wakelock.enable();
  }

  Future<void> _onDoneTap(int newRating) async {
    await isLoadingState.accept(true);
    await AppMetrica.reportEvent('order_rate_save');
    final List<OrdersHistoryRating> orderRate = [
      OrdersHistoryRating().copyWith(
          recipeRating: newRating,
          id: recipe.productId,
          comment: '',
          itemRating: newRating)
    ];
    await _recipesManager.rateRecipe(recipe.orderId, orderRate);

    await AppMetrica.reportEvent('recipes_done');
    doFutureHandleError<void>(
      _recipesManager.moveRecipeToHistory(recipe.id, recipe.orderId),
      (_) => _navigator.pop(true),
      onError: (_) => isLoadingState.accept(false),
    );
  }
}
