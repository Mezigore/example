import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/screen/recipes/empty_tab.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/di/like_recipes_tab_component.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/like_recipe_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_loader.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_tile.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';


/// Таб с любимыми рецептами пользователя
class LikeRecipesTab extends MwwmWidget<LikeRecipesTabComponent> {
  LikeRecipesTab({Key key})
      : super(
    widgetModelBuilder: createLikeRecipesTabWidgetModel,
    dependenciesBuilder: (context) => LikeRecipesTabComponent(context),
    widgetStateBuilder: () => _LikeRecipesTabState(),
    key: key,
  );
}

class _LikeRecipesTabState extends WidgetState<LikeRecipesTabWidgetModel> {


  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<Recipe>>(
      streamedState: wm.likeRecipesState,
      loadingChild: _Loader(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      child: (_, recipes) {
        if (recipes.isEmpty) return const RecipeEmptyTab(isActualTab: false, isLikeTab: true,);
        return Column(
          children: [
            Expanded(
              child: SwipeRefresh.builder(
                onRefresh: wm.reloadAction,
                stateStream: wm.reloadState.stream,
                itemCount: recipes.length * 2 - 1,
                itemBuilder: (_, index) {
                  if (index.isOdd) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: dividerLightColor, height: 1),
                    );
                  }
                  return RecipeTile(
                    recipe: recipes[index ~/ 2],
                    isShowLikeBtn: true,
                    actual: false,
                    wmTapLike: wm,
                    like: true,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      itemBuilder: (_, __) => const Padding(
        padding: EdgeInsets.all(20),
        child: RecipeLoader(),
      ),
      separatorBuilder: (_, __) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Divider(
          thickness: 1,
          color: dividerLightColor,
        ),
      ),
    );
  }
}
