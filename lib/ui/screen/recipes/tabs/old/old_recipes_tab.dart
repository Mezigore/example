import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/recipes/empty_tab.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/old/di/old_recipes_tab_component.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/old/old_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_loader.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_tile.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';


/// Таб со всеми рецептами пользователя
class OldRecipesTab extends MwwmWidget<OldRecipesTabComponent> {
  OldRecipesTab({Key key})
      : super(
          widgetModelBuilder: createOldRecipesTabWidgetModel,
          dependenciesBuilder: (context) => OldRecipesTabComponent(context),
          widgetStateBuilder: () => _OldRecipesTabState(),
          key: key,
        );
}

class _OldRecipesTabState extends WidgetState<OldRecipesTabWidgetModel> {


  void _search(String value){
    wm.searchFun(value: value);
  }

  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<Recipe>>(
      streamedState: wm.oldRecipesState,
      loadingChild: _Loader(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      child: (_, recipes) {
        if (recipes.isEmpty && !wm.search) return const RecipeEmptyTab(isActualTab: false);
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                height: 56,
                // width: 335,
                child: TextField(
                  onChanged: _search,
                    decoration: InputDecoration(
                      hintText: recipesSearchTitle,
                      contentPadding: const EdgeInsets.only(left: 16),
                      suffixIconConstraints: const BoxConstraints(
                        minHeight: 17,
                        minWidth: 17,
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SvgPicture.asset(
                          icSearch,
                        ),
                      ),
                    )
                ),
              ),
            ),
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
                    wmTapOld: wm,
                    actual: false,
                    like: false,
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
