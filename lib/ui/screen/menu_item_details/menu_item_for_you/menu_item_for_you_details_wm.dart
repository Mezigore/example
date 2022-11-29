import 'package:flutter/widgets.dart' hide Action, MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';

import 'menu_item_for_you_details_screen.dart';

/// [WidgetModel] for MenuItemDetailsScreen
class MenuItemForYouDetailsWidgetModel extends WidgetModel {
  MenuItemForYouDetailsWidgetModel(
      WidgetModelDependencies dependencies,
      this._navigator, {
        @required List<CategoryItem> listCategoryItem,
        @required MenuItem menuItem,
      })  : _listCategoryItem = listCategoryItem,
        _menuItem = menuItem,
        super(dependencies);

  final NavigatorState _navigator;

  /// Для appBar несёт в себе название категории,
  /// текущее значение счётчика и колличество продуктов в категории
  final menuItemForYouDetailsAppbarState = StreamedState<MenuItemDetailsForYouAppbarDesc>();

  /// Все категории с продуктами
  final List<CategoryItem> _listCategoryItem;

  /// выбранный item в главном меню
  final MenuItem _menuItem;

  /// все продукты в одном списке
  final itemsState = StreamedState<List<MenuItem>>();

  /// Текущий просматриваемый MenuItem
  int _currentPage;

  /// Вернуться на предыдущий виджет
  final closeAction = Action<void>();

  /// Контроллер за [PageView]
  PageController _pageController;

  PageController get pageController => _pageController;

  @override
  void onLoad() {
    super.onLoad();
    _init();
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(closeAction, (_) => _navigator.pop());
  }

  void _init() {
    final List<MenuItem> items = _initItems(_listCategoryItem);
    final index = items.indexOf(_menuItem);

    _pageController = PageController(initialPage: index)
      ..addListener(_onPageControllerChange);

    itemsState.accept(items);
    _onPageChange(index);
  }

  /// Объединяем все MenuItem в категориях
  List<MenuItem> _initItems(List<CategoryItem> listCategoryItem) {
    final items = <MenuItem>[];

    for (final categoryItem in listCategoryItem) {
      // if(categoryItem.code != 'foryou'){
      items.addAll(categoryItem.products);
      // }
    }

    return items;
  }

  void _onPageControllerChange() {
    final index = pageController.page.round();
    if (index != _currentPage) {
      _onPageChange(index);
    }
  }

  void _onPageChange(int page) {
    _currentPage = page;

    final productCountInCategory = _getAppBarDesc(
      listCategoryItem: _listCategoryItem,
      menuItem: itemsState.value[page],
    );

    menuItemForYouDetailsAppbarState.accept(productCountInCategory);
  }

  /// Ищем в списке выбранный продукт
  MenuItemDetailsForYouAppbarDesc _getAppBarDesc({
    @required List<CategoryItem> listCategoryItem,
    @required MenuItem menuItem,
  }) {
    for (final categoryItem in listCategoryItem) {
      for (int i = 0; categoryItem.products.length > i; i++) {
        if (menuItem.id == categoryItem.products[i].id) {
          return MenuItemDetailsForYouAppbarDesc(
            nameCategory: categoryItem.name,
            count: i + 1,
            allProduct: categoryItem.products.length,
          );
        }
      }
    }
    throw NotFoundException('MenuItem not found');
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
