import 'package:flutter/material.dart' hide Action, MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/di/menu_item_for_you_detail_component.dart';
import 'package:uzhindoma/ui/screen/menu_item_details/menu_item_for_you/menu_item_for_you_details_wm.dart';
import 'package:uzhindoma/ui/screen/product_details/product_details_for_you_screen.dart';
import 'package:uzhindoma/ui/widget/cart/cart_button.dart';
import 'package:uzhindoma/util/const.dart';

/// Screen [MenuItemForYouDetailsScreen]
/// PageView для детального просмотра меню
class MenuItemForYouDetailsScreen extends MwwmWidget<MenuItemForYouDetailsComponent> {
  MenuItemForYouDetailsScreen({
    @required List<CategoryItem> listCategoryItem,
    @required MenuItem menuItem,
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createMenuItemDetailsWidgetModel(
            context,
            listCategoryItem: listCategoryItem,
            menuItem: menuItem,
          ),
          dependenciesBuilder: (context) => MenuItemForYouDetailsComponent(context),
          widgetStateBuilder: () => _MenuItemDetailsScreenState(),
        );
}

class _MenuItemDetailsScreenState extends WidgetState<MenuItemForYouDetailsWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarPageView(
        countCategoryState: wm.menuItemForYouDetailsAppbarState,
        closeAction: wm.closeAction,
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          StreamedStateBuilder<List<MenuItem>>(
            streamedState: wm.itemsState,
            builder: (context, items) {
              return items == null
                  ? const SizedBox.shrink()
                  : PageView.builder(
                      controller: wm.pageController,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ProductDetailsForYouScreen(
                          menuItem: items[index],
                        );
                      },
                    );
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CartButton(),
          ),
        ],
      ),
    );
  }
}

/// кастомный appBar для [MenuItemForYouDetailsScreen]
/// отцентрирована по вертикали кнопка закрытия, название категории и
/// индекс просматриваемого продукта в кагерии
class _AppBarPageView extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarPageView({
    Key key,
    @required this.countCategoryState,
    @required this.closeAction,
  })  : assert(closeAction != null),
        assert(countCategoryState != null),
        super(key: key);

  final StreamedState<MenuItemDetailsForYouAppbarDesc> countCategoryState;
  final Action<void> closeAction;

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: closeAction,
              splashRadius: 20,
            ),
          ),
          Expanded(
            child: StreamedStateBuilder<MenuItemDetailsForYouAppbarDesc>(
              streamedState: countCategoryState,
              builder: (context, countCategory) {
                return countCategory == null
                    ? const SizedBox.shrink()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            countCategory.nameCategory,
                            style: textMedium16,
                          ),
                          Text(
                            countCategory.count,
                            style: textRegular12Secondary,
                          ),
                        ],
                      );
              },
            ),
          ),
          const SizedBox(width: 58)
        ],
      ),
    );
  }
}

/// Описание текущего состояния Appbar
class MenuItemDetailsForYouAppbarDesc {
  MenuItemDetailsForYouAppbarDesc({
    @required String nameCategory,
    @required int count,
    @required int allProduct,
  })  : nameCategory = nameCategory ?? emptyString,
        _allProduct = allProduct,
        _count = count;

  /// Название категории
  final String nameCategory;

  /// Текущее значение счетчика
  final int _count;

  /// Всего продуктов в категории
  final int _allProduct;

  /// Возращает текущеий номер выбранного продукта и общее колличество продуктов
  String get count => '$_count/$_allProduct';
}
