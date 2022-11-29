import 'package:flutter/material.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/actual/actual_recipes_tab.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/like_recipe_tab.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/old/old_recipes_tab.dart';

/// Экран с табами рецептов
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final tabs = TabBarView(
    children: [
      ActualRecipesTab(),
      OldRecipesTab(),
      LikeRecipesTab(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.children.length,
      child: Scaffold(
        appBar: const DefaultAppBar(
          leadingIcon: Icons.arrow_back_ios,
          title: recipesMainDrawerWidgetText,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                labelStyle: textMedium12,
                unselectedLabelColor: textColorHint,
                labelColor: textColorAccent,
                labelPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3.0,
                    color: textColorAccent,
                  ),
                ),
                tabs: const [
                  Tab(text: recipesActualTitle),
                  Tab(text: recipesOldTitle),
                  Tab(text: recipesLikeTitle),
                ],
              ),
            ),
            Expanded(
              child: tabs,
            ),
          ],
        ),
      ),
    );
  }
}
