import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/common/widgets/placeholder/skeleton.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/recipes/empty_tab.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/actual/actual_recipes_tab_wm.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/actual/di/actual_recipes_tab_component.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_loader.dart';
import 'package:uzhindoma/ui/screen/recipes/widgets/recipe_tile.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Таб с актуальными рецептами
class ActualRecipesTab extends MwwmWidget<ActualRecipesTabComponent> {
  ActualRecipesTab({Key key})
      : super(
          widgetModelBuilder: createActualRecipesTabWidgetModel,
          dependenciesBuilder: (context) => ActualRecipesTabComponent(context),
          widgetStateBuilder: () => _ActualRecipesTabState(),
          key: key,
        );
}

class _ActualRecipesTabState extends WidgetState<ActualRecipesTabWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<Map<String, List<Recipe>>>(
      streamedState: wm.actualRecipesState,
      loadingChild: _Loader(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      child: (_, map) {
        if (map.isEmpty) return const RecipeEmptyTab();
        return SwipeRefresh.adaptive(
          onRefresh: wm.reloadAction,
          stateStream: wm.reloadState.stream,
          children: map.keys
              .map((e) => _DateList(
                    title: e,
                    recipes: map[e],
            wmTap: wm,
                  ))
              .toList(),
        );
      },
    );
  }
}

class _DateList extends StatelessWidget {
  const _DateList({
    Key key,
    @required this.title,
    @required this.recipes,
    @required this.wmTap,
  })  : assert(title != null),
        assert(recipes != null),
        super(key: key);

  final String title;
  final List<Recipe> recipes;
  final ActualRecipesTabWidgetModel wmTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
            bottom: 8.0,
            right: 20.0,
            left: 20.0,
          ),
          child: Text(
            title,
            style: textMedium24,
          ),
        ),
        ...List.generate(
          recipes.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(color: dividerLightColor, height: 1),
              );
            }
            return RecipeTile(
              recipe: recipes[index ~/ 2],
              isArchived: false,
              isShowLikeBtn: true,
              wmTapActual: wmTap,
              actual: true,
              like: false,
            );
          },
        ),
      ],
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: SkeletonWidget(
            isLoading: true,
            width: 152,
            height: 20,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 8, bottom: 12),
          child: SkeletonWidget(
            isLoading: true,
            height: 20,
            width: 216,
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
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
          ),
        ),
      ],
    );
  }
}
