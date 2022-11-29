import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/user_info_screen/user_info_screen_wm.dart';

/// [Component] для <UserInfoScreen>
class UserInfoScreenComponent implements Component {
  UserInfoScreenComponent(BuildContext context) {
    parent = Injector.of<AppComponent>(context).component;

    messageController = MaterialMessageController(scaffoldKey);
    dialogController = OrderDialogController(scaffoldKey);
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
  OrderDialogController dialogController;
  NavigatorState navigator;
  NavigatorState rootNavigator;
  WidgetModelDependencies wmDependencies;
}

UserInfoScreenWidgetModel createUserInfoScreenWidgetModel(
    BuildContext context) {
  final component = Injector.of<UserInfoScreenComponent>(context).component;

  return UserInfoScreenWidgetModel(
    component.wmDependencies,
    component.navigator,
    component.dialogController,
    component.parent.userManager,
    component.parent.analyticsInteractor,
    component.messageController,
  );
}
