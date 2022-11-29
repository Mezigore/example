
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/ui/screen/main/di/main_screen_component.dart';
import 'package:uzhindoma/ui/screen/main/main_screen_wm.dart';
import 'package:uzhindoma/ui/screen/main/widget/app_bar/main_app_bar.dart';
import 'package:uzhindoma/ui/screen/main/widget/drawer/main_drawer_widget.dart';
import 'package:uzhindoma/ui/screen/main/widget/menu/menu.dart';
import 'package:uzhindoma/ui/screen/main/widget/menu/menu_error.dart';
import 'package:uzhindoma/ui/screen/main/widget/menu/menu_loader.dart';
import 'package:uzhindoma/ui/screen/main/widget/section_scroll/section.dart';
import 'package:uzhindoma/ui/widget/cart/cart_button.dart';

/// Основной экран
class MainScreen extends MwwmWidget<MainScreenComponent> {
  MainScreen({Key key})
      : super(
    widgetModelBuilder: createMainScreenWidgetModel,
    dependenciesBuilder: (context) => MainScreenComponent(context),
    widgetStateBuilder: () => _MainScreenState(),
    key: key,
  );
}

class _MainScreenState extends WidgetState<MainScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final EdgeInsets padding = data.padding;

    return WillPopScope(
      onWillPop: () {
        if (Platform.isIOS) return Future.value(true);
        wm.closeAction();
        return Future.value(false);
      },
      child: Scaffold(
        key: Injector
            .of<MainScreenComponent>(context)
            .component
            .scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
        drawer: MainDrawerWidget(),
        body: Stack(
          children: [
            Column(
              children: [
                const SafeArea(
                  child: SizedBox(height: MainScreenAppBar.appBarHeight),
                ),
                Expanded(
                  child: EntityStateBuilder<List<Section<CategoryItem>>>(
                    streamedState: wm.menuState,
                    child: (_, list) =>
                        MenuWidget(
                          list: list,
                          selectCardAction: wm.selectCardAction,
                          selectCardForYouAction: wm.selectCardForYouAction,
                        ),
                    errorChild: MenuError(
                      onUpdate: wm.updateMenuAction,
                    ),
                    loadingChild: const MenuLoader(),
                  ),
                ),
                EntityStateBuilder<List<Section<CategoryItem>>>(
                  streamedState: wm.menuState,
                  child: (_, list) =>
                      Padding(
                        padding: EdgeInsets.only(bottom: padding.bottom),
                        child: CartButton(),
                      ),
                  errorChild: const SizedBox.shrink(),
                  loadingChild: const SizedBox.shrink(),
                ),
              ],
            ),
            // легкий хак чтобы не воротить открытие отдельного роута
            // при раскрытии аппбара
            MainScreenAppBar(
              appBarState: wm.appBarState,
              currentWeekState: wm.currentWeekState,
              changeCurrentWeek: wm.changeCurrentWeek,
            ),
          ],
        ),
      ),
    );
  }
}

