import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/domain/recipes/recipe.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';

// ignore: always_use_package_imports
import '../recipe_details_screen_wm.dart';

/// [Component] для <RecipeDetailsScreen>
class RecipeDetailsScreenComponent implements Component {
  RecipeDetailsScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    navigator = Navigator.of(context);
    rootNavigator = Navigator.of(context, rootNavigator: true);

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        dialogController,
        parent.scInteractor,
      ),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AppComponent parent;
  MessageController messageController;
  DialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

RecipeDetailsScreenWidgetModel createRecipeDetailsScreenWidgetModel(
  BuildContext context,
  Recipe recipe,
  // ignore: avoid_positional_boolean_parameters
  bool isArchived,
) {
  final component =
      Injector.of<RecipeDetailsScreenComponent>(context).component;

  return RecipeDetailsScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    recipe,
    isArchived,
    component.parent.recipesManager,
  );
}
