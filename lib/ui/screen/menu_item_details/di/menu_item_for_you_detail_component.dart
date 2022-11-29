import 'package:flutter/material.dart' hide MenuItem;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/app/di/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/di/widget_component.dart';
import 'package:uzhindoma/ui/base/error/standard_error_handler.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_details_wm.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_for_you/menu_item_for_you_details_wm.dart';

/// di for [MenuItemDetailsWidgetModel]
class MenuItemForYouDetailsComponent extends WidgetComponent {
  MenuItemForYouDetailsComponent(BuildContext context) : super(context) {
    final parent = Injector.of<AppComponent>(context).component;
    _navigator = Navigator.of(context);
    _messageController = MaterialMessageController(scaffoldKey);
    _dialogController = DefaultDialogController(scaffoldKey);

    _wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        _messageController,
        _dialogController,
        parent.scInteractor,
      ),
    );
  }

  NavigatorState _navigator;
  MessageController _messageController;
  DialogController _dialogController;
  WidgetModelDependencies _wmDependencies;
}

/// builder by TemplateWm
MenuItemForYouDetailsWidgetModel createMenuItemDetailsWidgetModel(
    BuildContext context, {
      @required List<CategoryItem> listCategoryItem,
      @required MenuItem menuItem,
    }) {
  final component = Injector.of<MenuItemForYouDetailsComponent>(context).component;
  return MenuItemForYouDetailsWidgetModel(
    component._wmDependencies,
    component._navigator,
    listCategoryItem: listCategoryItem,
    menuItem: menuItem,
  );
}
