import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/recipes/tabs/like/like_recipe_tab_wm.dart';

import '../promo_screen_wm.dart';

/// [Component] для <LikeRecipesTab>
class PromoScreenComponent implements Component {
  PromoScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController.from(context);
    dialogController = DefaultDialogController.from(context);
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

  AppComponent parent;
  MessageController messageController;
  DialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

PromoScreenWidgetModel createPromoScreenWidgetModel(
    BuildContext context,
    ) {
  final component = Injector.of<PromoScreenComponent>(context).component;

  return PromoScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.parent.promoManager,
    component.parent.cartManager,
    component.parent.analyticsInteractor,
  );
}