import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/screen/recipes/screens/recipe_detail/recipe_details_screen.dart';

/// Роут для [RecipeDetailsScreen]
class RecipeDetailsScreenRoute extends MaterialPageRoute<bool> {
  RecipeDetailsScreenRoute(
    Recipe recipe, {
    bool isArchived,
  }) : super(
          builder: (ctx) => RecipeDetailsScreen(
            recipe: recipe,
            isArchived: isArchived,
          ),
        );
}
