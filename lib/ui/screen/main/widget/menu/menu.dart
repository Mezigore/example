import 'package:flutter/material.dart' hide Action, MenuItem;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/catalog/menu/category_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/common/widgets/image/loading_network_image.dart';
import 'package:uzhindoma/ui/common/widgets/menu_item_button/menu_for_you_button_widget.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/main/widget/banner/banner_gallery.dart';
import 'package:uzhindoma/ui/screen/main/widget/cards/dish_card.dart';
import 'package:uzhindoma/ui/screen/main/widget/new_banners/new_banners_gallery.dart';
import 'package:uzhindoma/ui/screen/main/widget/section_scroll/section.dart';
import 'package:uzhindoma/ui/screen/main/widget/section_scroll/section_list_view.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/ui/widget/product/product_info.dart';

/// Виджет отображения меню
class MenuWidget extends StatefulWidget {
  MenuWidget({
    Key key,
    @required this.selectCardAction,
    @required this.selectCardForYouAction,
    @required this.list,
  })  : assert(list != null && list.isNotEmpty),
        assert(selectCardAction != null),
        super(key: key);

  final List<Section<CategoryItem>> list;

  final Action<MenuItem> selectCardAction;
  final Action<MenuItem> selectCardForYouAction;

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return SectionListView<CategoryItem>(
      sections: widget.list,
      contentBuilder: _buildSection,
      headerTitleBuilder: sectionTitleContentBuilder,
      headerColor: backgroundColor,
      headerElevation: 0.0,
      headerHeight: 62.0,
      headerSideSpace: 20.0,
    );
  }

  Widget _buildSection(BuildContext context, Section<CategoryItem> section) {
    return Column(
      children: [
        if(section.name == widget.list[0].name)...[
          NewBannersGallery(),
        ],
        BannerGallery(),
        ...section.items
            .map(
              (category) => _CategoryWidget(
                category: category,
                selectCardAction: widget.selectCardAction,
                selectCardForYouAction: widget.selectCardForYouAction,
              ),
            )
            .toList(),
      ],
    );
  }

  Widget sectionTitleContentBuilder(
    BuildContext context,
    String title, {
    bool isSelected,
  }) {
    return Center(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: isSelected
            ? BoxDecoration(
                color: mainScreenSectionTitleSelected,
                borderRadius: BorderRadius.circular(16.0),
              )
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Text(title, style: textRegular14),
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  const _CategoryWidget({
    Key key,
    @required this.selectCardAction,
    @required this.selectCardForYouAction,
    @required this.category,
  })  : assert(category != null),
        super(key: key);

  final CategoryItem category;
  final Action<MenuItem> selectCardAction;
  final Action<MenuItem> selectCardForYouAction;

  @override
  Widget build(BuildContext context) {
    if (category is OutOfStockCategory) {
      return _OutOfStockCategoryWidget(
          category: category as OutOfStockCategory);
    }

    if (category.code == 'foryou') {
      return _ForYouCategoryWidget(
        category: category,
        selectCardForYouAction: selectCardForYouAction,
      );
    }

    return _CommonCategoryWidget(
      category: category,
      selectCardAction: selectCardAction,
    );
  }
}

class _CommonCategoryWidget extends StatelessWidget {
  const _CommonCategoryWidget({
    Key key,
    @required this.category,
    @required this.selectCardAction,
  })  : assert(category != null),
        super(key: key);

  final CategoryItem category;
  final Action<MenuItem> selectCardAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (category.description != null && category.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              40.0,
              60.0,
              40.0,
              40.0,
            ),
            child: Column(
              children: [
                if (category.iconUrl != null && category.iconUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: LoadingNetworkImage(
                      imageUrl: category.iconUrl,
                      height: 32,
                      width: 32,
                    ),
                  ),
                Text(
                  category.description,
                  style: textRegular14Hint,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        if (!category.showCategoryName)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              category.name,
              style: textMedium32.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        ...category.products
            .map(
              (menuItem) => DishCard(
                isBigCards: category.isBigCards,
                categoryName: category.name,
                menuItem: menuItem,
                selectCardAction: selectCardAction,
              ),
            )
            .toList(),
      ],
    );
  }
}

class _OutOfStockCategoryWidget extends StatelessWidget {
  const _OutOfStockCategoryWidget({
    Key key,
    @required this.category,
  })  : assert(category != null),
        super(key: key);

  final CategoryItem category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (category.description != null && category.description.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              40.0,
              60.0,
              40.0,
              35.0,
            ),
            child: Column(
              children: [
                if (category.iconUrl != null && category.iconUrl.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: LoadingNetworkImage(
                      imageUrl: category.iconUrl,
                      height: 32,
                      width: 32,
                    ),
                  ),
                Text(
                  category.description,
                  style: textRegular14Hint,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            bottom: 20.0,
          ),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            shrinkWrap: true,
            children: category.products
                .map(
                  (product) => _OutOfStockItem(item: product),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _OutOfStockItem extends StatelessWidget {
  const _OutOfStockItem({
    Key key,
    @required this.item,
  })  : assert(item != null),
        super(key: key);

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProductImageWidget(
          urlImage: item.previewImg,
          boxFit: BoxFit.cover,
          color: whiteTransparent,
        ),
      ),
    );
  }
}

class _ForYouCategoryWidget extends StatelessWidget {
  const _ForYouCategoryWidget({
    Key key,
    @required this.category,
    @required this.selectCardForYouAction,
  })  : assert(category != null),
        super(key: key);

  final CategoryItem category;
  final Action<MenuItem> selectCardForYouAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Text(
            category.description,
            style: textMedium20,
          ),
        ),
        SizedBox(
          height: 258,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            itemCount: category.products.length,
            separatorBuilder: (_, i) {
              return const SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, i) {
              return _ForYouItem(
                item: category.products[i],
                selectCardForYouAction: selectCardForYouAction,
              );
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        MenuForYouButtonWidget(
          cartElements: category.products,
          category: category,
          needAccentColor: true,
        ),
      ],
    );
  }
}

class _ForYouItem extends StatelessWidget {
  const _ForYouItem({
    Key key,
    @required this.item,
    @required this.selectCardForYouAction,
  })  : assert(item != null),
        super(key: key);

  final MenuItem item;
  final Action<MenuItem> selectCardForYouAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => selectCardForYouAction.accept(item),
      child: Container(
        width: 254,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 8), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ImageWidget(imageUrl: item.previewImg),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                item.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textRegular14Hint,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ProductInfoWidget(
                cookingTime: item.properties.cookTimeUi,
                portion: item.properties.portionUi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: ProductImageWidget(
          urlImage: imageUrl,
        ),
      ),
    );
  }
}
