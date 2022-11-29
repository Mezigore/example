import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart' hide Action, MenuItem;
import 'package:flutter/services.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/app/app_version.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/domain/catalog/week_item.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/cart/cart_manager.dart';
import 'package:uzhindoma/interactor/catalog/menu_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/main/widget/section_scroll/section.dart';

import '../../../interactor/app/app_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

const _closeTimerDuration = Duration(seconds: 2);

/// [WidgetModel] для <MainScreen>
class MainScreenWidgetModel extends WidgetModel {
  MainScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._authManager,
    this._navigator,
    this._dialogController,
    this._menuManager,
    this._cartManager,
    this._messageController,
    this._appManager,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final DefaultDialogController _dialogController;
  final MessageController _messageController;

  final AuthManager _authManager;
  final MenuManager _menuManager;
  final CartManager _cartManager;
  final AppManager _appManager;

  final menuState = EntityStreamedState<List<Section<CategoryItem>>>();

  final changeCurrentWeek = Action<WeekItem>();

  final selectCardAction = Action<MenuItem>();
  final selectCardForYouAction = Action<MenuItem>();

  final updateMenuAction = Action<void>();

  /// Закрытие экрана = закрытие приложения
  final closeAction = Action<void>();

  Timer _closeTimer;

  /// Отфильтрованный список [CategoryItem]
  List<CategoryItem> _filteredCategory;
  CategoryItem _filteredCategoryForYou;

  EntityStreamedState<AppVersion> get versionState => _appManager.versionState;

  StreamedState<WeekItem> get currentWeekState => _menuManager.currentWeekState;

  EntityStreamedState<List<WeekItem>> get appBarState =>
      _menuManager.weeksInfoState;

  EntityStreamedState<List<CategoryItem>> get _rawMenuState =>
      _menuManager.menuState;


  @override
  void onLoad(){
    super.onLoad();
    checkActualVersion();
  }

  @override
  void onBind() {
    super.onBind();

    subscribe<EntityState<bool>>(
      _authManager.isLoginState.stream,
      _onAuthChange,
    );
    subscribe<MenuItem>(selectCardAction.stream, _openDetailsScreen);
    subscribe<MenuItem>(selectCardForYouAction.stream, _openDetailsForYouScreen);
    bind<WeekItem>(changeCurrentWeek, _updateWeek);
    bind<void>(closeAction, (_) => _closeApp());
    subscribe(_cartManager.errorStream, handleError);
    subscribe<EntityState<List<CategoryItem>>>(
      _rawMenuState.stream,
          (entityState) {
        menuState.accept(
          EntityState(
            isLoading: entityState.isLoading,
            hasError: entityState.hasError,
            error: entityState?.error?.e as Exception,
            data: entityState.data == null
                ? null
                : _convertCategoryList(entityState.data),
          ),
        );
      },
    );
    subscribe<void>(updateMenuAction.stream, (_) {
      _updateMenu();
    });
  }


  Future<void> checkActualVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final List<String> localVersion = packageInfo.version.split('.');
    final List<String> appStoreVersion = _appManager.versionState.value.data.appStore.split('.');
    final List<String> playMarketVersion = _appManager.versionState.value.data.playMarket.split('.');

    if (Platform.isIOS){
      if(checkVers(local: localVersion, store: appStoreVersion)){
        final Uri _url = Uri.parse('https://apps.apple.com/ru/app/%D1%83%D0%B6%D0%B8%D0%BD-%D0%B4%D0%BE%D0%BC%D0%B0-%D0%BF%D1%80%D0%BE%D0%B4%D1%83%D0%BA%D1%82%D1%8B-%D0%B8-%D1%80%D0%B5%D1%86%D0%B5%D0%BF%D1%82%D1%8B/id1564443317?l=ru');
        await _dialogController.showAlertDialog<bool>(
          message: updateDialogText,
          agreeButtonText: updateDialogAgreeButtonText,
          disagreeButtonText: updateDialogDisagreeButtonText,
          onAgreeClicked: (context){
            launchUrl(_url,mode: LaunchMode.externalApplication,);
          },
          onDisagreeClicked: Navigator.pop,
        );
      }
    }else{
      if(checkVers(local: localVersion, store: playMarketVersion)){
        final Uri _url = Uri.parse('https://play.google.com/store/apps/details?id=ru.app.uzhindoma');
        await _dialogController.showAlertDialog<bool>(
          message: updateDialogText,
          agreeButtonText: updateDialogAgreeButtonText,
          disagreeButtonText: updateDialogDisagreeButtonText,
          onAgreeClicked: (context){
            launchUrl(_url,mode: LaunchMode.externalApplication,);
          },
          onDisagreeClicked: Navigator.pop,
        );
      }
    }
  }

  bool checkVers({List<String> local, List<String> store}){
    if(int.parse(local[0]) < int.parse(store[0])){
      return true;
    }else if(int.parse(local[1]) < int.parse(store[1])){
      return true;
    }else if(int.parse(local[2]) < int.parse(store[2])){
      return true;
    }else{
      return false;
    }
  }

  void _updateMenu() {
    final isMenuAlreadyLoading =
        _menuManager.menuState.value?.isLoading ?? false;

    if (!isMenuAlreadyLoading) {
      doFutureHandleError<void>(_menuManager.loadMenu(), (_) {});
    }
  }

  void _openDetailsScreen(MenuItem menuItem) {
    _navigator.pushNamed(
      AppRouter.menuItemDetailsScreen,
      arguments: Pair<List<CategoryItem>, MenuItem>(
        _filteredCategory,
        menuItem,
      ),
    );
  }
  void _openDetailsForYouScreen(MenuItem menuItem) {
    _navigator.pushNamed(
      AppRouter.menuItemForYouDetailsScreen,
      arguments: Pair<List<CategoryItem>, MenuItem>(
        [_filteredCategoryForYou],
        menuItem,
      ),
    );
  }

  void _onAuthChange(EntityState<bool> state) {
    if (state.hasError || state.data == null || !state.data) {
      _navigator.pushNamedAndRemoveUntil(
        AppRouter.authScreen,
            (_) => false,
      );
    }
  }

  List<Section<CategoryItem>> _convertCategoryList(
      List<CategoryItem> categories,
      ) {
    OutOfStockCategory outOfStockCategory;
    _filteredCategory = _filterCategories(categories);
    _filteredCategoryForYou = _filterCategoriesForYou(categories);

    final outOfStock = categories.firstWhere(
          (category) => category.code == CategoryItem.codeOutOfStock,
      orElse: () => null,
    );

    if (outOfStock != null) outOfStockCategory = OutOfStockCategory(outOfStock);

    return _prepareSections(
      _filteredCategory,
      _filteredCategoryForYou,
      outOfStockCategory,
    );
  }

  List<CategoryItem> _filterCategories(List<CategoryItem> list) {
    final newList = <CategoryItem>[];

    for (final category in list) {
      if (category.code == CategoryItem.codeOutOfStock) {
        continue;
      }if (category.code == CategoryItem.codeForYou) {
        continue;
      }

      final products =
      category?.products?.where((p) => p.isAvailable)?.toList();

      if (products?.isNotEmpty ?? false) {
        newList.add(
          CategoryItem.copy(
            category,
            products: products,
          ),
        );
      }
    }

    return newList;
  }
  CategoryItem _filterCategoriesForYou(List<CategoryItem> list) {
    CategoryItem newList;

    for (final category in list) {
      if (category.code == CategoryItem.codeForYou) {
        final products =
        category?.products?.where((p) => p.isAvailable)?.toList();

        if (products?.isNotEmpty ?? false) {
          newList = CategoryItem.copy(
            category,
            products: products,
          );
          // newList.add(
          //   CategoryItem.copy(
          //     category,
          //     products: products,
          //   ),
          // );
        }
      }
    }

    return newList;
  }

  List<Section<CategoryItem>> _prepareSections(
      List<CategoryItem> categoryList,
      CategoryItem categoryListForYou,
      CategoryItem outOfStock,
      ) {
    final sections = <Section<CategoryItem>>[];

    final sectionsLength = categoryList.length;
    for (var i = 0; i < sectionsLength; i++) {
      final category = categoryList[i];
      final categories = <CategoryItem>[category];

      if (outOfStock != null && i == sectionsLength - 1) {
        categories.add(outOfStock);
      }
      // if (categoryListForYou != null && i == sectionsLength - 1) {
      //   categories.insert(0, categoryListForYou);
      //
      // }


      final section = Section<CategoryItem>(
        category.name,
        categories,
      );

      sections.add(section);
    }

    if (categoryListForYou != null){
      sections.insert(
        0,
        Section<CategoryItem>(
          categoryListForYou.name,
          [categoryListForYou],
        ),
      );
    }

    return sections;
  }

  Future<void> _updateWeek(WeekItem week) async {
    if (week.id == currentWeekState.value?.id) return;
    if (_cartManager.cartState.value?.data?.menu?.isNotEmpty ?? false) {
      final isAccepted = await _dialogController.showAcceptBottomSheet(
        mainScreenChangeWeekTitle,
        agreeText: mainScreenChangeWeekAccept,
        cancelText: mainScreenChangeWeekCancel,
      );

      if (isAccepted ?? false) {
        _cartManager.clearCart();
      } else {
        return;
      }
    }
    _menuManager.currentWeek = week;
  }

  void _closeApp() {
    if (_closeTimer?.isActive ?? false) {
      SystemNavigator.pop();
    } else {
      _messageController.show(msg: closeAppText, msgType: MsgType.common);
      _closeTimer = Timer(_closeTimerDuration, () {});
    }
  }
}
