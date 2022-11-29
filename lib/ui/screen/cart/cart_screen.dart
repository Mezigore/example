import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/cart/cart.dart';
import 'package:uzhindoma/domain/cart/cart_item.dart';
import 'package:uzhindoma/domain/cart/extra_item.dart';
import 'package:uzhindoma/domain/catalog/menu/menu_item.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/svg_icon_button.dart';
import 'package:uzhindoma/ui/res/assets.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/cart/cart_placeholder.dart';
import 'package:uzhindoma/ui/screen/cart/cart_wm.dart';
import 'package:uzhindoma/ui/screen/cart/di/cart_component.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_add_to_order.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_discount_info.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_no_paper/cart_no_paper.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_order_button/cart_create_order_button.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_price_loader.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_price_widget.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_size_info.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/extra_cart_item.dart';
import 'package:uzhindoma/ui/widget/cart_item_widget/cart_item_widget.dart';
import 'package:uzhindoma/util/const.dart';

/// Screen [CartScreen]
class CartScreen extends MwwmWidget<CartComponent> {
  CartScreen({
    Key key,
    Route cartRoute,
  }) : super(
          key: key,
          widgetModelBuilder: (context) => createCartWm(context, cartRoute),
          dependenciesBuilder: (context) => CartComponent(context),
          widgetStateBuilder: () => _CartScreenState(),
        );
}

class _CartScreenState extends WidgetState<CartWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<CartComponent>(context).component.scaffoldKey,
      appBar: DefaultAppBar(
        title: cartTitleCardText,
        leadingIcon: Icons.arrow_back_ios,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgIconButton(
                icCart,
                onTap: wm.clearCartAction,
              ),
            ),
          ),
        ],
      ),
      body: EntityStateBuilder<Cart>(
        streamedState: wm.cartState,
        loadingChild: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CartPlaceholder(),
        ),
        loadingBuilder: (_, data) {
          return _Cart(
            cart: data,
            isLoading: true,
          );
        },
        errorBuilder: (_, data, e) {
          return _Cart(
            cart: data,
            onCardTap: wm.onItemTapAction,
            onExtraItemDelete: wm.extraItemDeleteAction,
          );
        },
        child: (context, data) {
          return _Cart(
            cart: data,
            onCardTap: wm.onItemTapAction,
            onExtraItemDelete: wm.extraItemDeleteAction,
          );
        },
      ),
    );
  }
}

class _Cart extends StatelessWidget {
  const _Cart({
    Key key,
    this.cart,
    this.onCardTap,
    this.onExtraItemDelete,
    this.isLoading = false,
  }) : super(key: key);

  final Cart cart;
  final bool isLoading;
  final ValueSetter<CartItem> onCardTap;
  final ValueSetter<ExtraItem> onExtraItemDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: _CommonDishesList(
              cart: cart,
              onTap: onCardTap,
              isLoading: isLoading,
              onExtraDelete: onExtraItemDelete,
            ),
          ),
        ),
        CartCreateOrderButton(),
      ],
    );
  }
}

class _CommonDishesList extends StatefulWidget {
  const _CommonDishesList({
    Key key,
    @required this.cart,
    this.onTap,
    this.onExtraDelete,
    this.isLoading = false,
  })  : assert(cart != null),
        super(key: key);

  final Cart cart;
  final bool isLoading;
  final ValueChanged<CartItem> onTap;
  final ValueChanged<ExtraItem> onExtraDelete;

  @override
  __CommonDishesListState createState() => __CommonDishesListState();
}

class __CommonDishesListState extends State<_CommonDishesList> {
  List<CartItem> commonDishes;
  List<CartItem> extraDishes;

  @override
  void initState() {
    super.initState();
    _separateDishes();
  }

  @override
  void didUpdateWidget(covariant _CommonDishesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(_separateDishes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            cartListTitle,
            style: textMedium24,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.cart.weekItem.uiName == null
                ? emptyString
                : '$cartWeekPrefix${widget.cart.weekItem.uiName}',
            style: textRegular14Secondary,
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Divider(thickness: 1, color: dividerLightColor),
        ),
        ...commonDishes.map(
          (dish) => CartItemWidget(
            key: ValueKey(dish.id),
            item: dish,
            isLoading: widget.isLoading,
            onTap: () => widget.onTap?.call(dish),
          ),
        ),
        ...extraDishes.map(
              (dish) => CartItemWidget(
            key: ValueKey(dish.id),
            item: dish,
            isLoading: widget.isLoading,
            onTap: () => widget.onTap?.call(dish),
          ),
        ),
        if (widget.cart.extraItems?.isNotEmpty ?? false)
          ...widget.cart.extraItems.map(
                (item) => ExtraCartItemWidget(
              key: ValueKey(item.id),
              item: item,
              onDeletePress: () => widget.onExtraDelete?.call(item),
            ),
          ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Divider(thickness: 1, color: dividerLightColor),
        ),
        CartNoPaper(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Divider(thickness: 1, color: dividerLightColor),
        ),
        ///Блок Рекомендации
        if(widget.cart.recommendationItem != null)...[
          CartAddToOrder(recommend: widget.cart.recommendationItem,),
          const SizedBox(height: 30,),
        ],
        if(widget.cart.promoname == null)...[
          _CartSize(
            cart: widget.cart,
            isLoading: widget.isLoading,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Divider(thickness: 1, color: dividerLightColor),
          ),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget.isLoading
              ? const CartSumLoader()
              : CartSumWidget(
                  fullPrice: widget.cart.totalPriceText,
                  discount: widget.cart.discountText,
                  discountSumm: widget.cart.discountSummText,
                  discountCountSumm: widget.cart.discountCountSummText,
                  priceWithDiscount: widget.cart.discountPriceText,
                  count: widget.cart.countDinnersText,
                ),
        ),
        const SizedBox(height: 36),
      ],
    );
  }

  void _separateDishes() {
    commonDishes = widget.cart.menu
            ?.where((item) => item.type != MenuItemType.extra)
            ?.toList() ??
        [];
    extraDishes = widget.cart.menu
            ?.where((item) => item.type == MenuItemType.extra)
            ?.toList() ??
        [];
  }
}

class _CartSize extends StatelessWidget {
  const _CartSize({
    Key key,
    this.cart,
    this.isLoading = false,
  }) : super(key: key);
  final Cart cart;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // if (cart.currentCount == cart.maxCount || cart.hintText == null) {
    //   return const SizedBox();
    // }
    return Container(
      // alignment: Alignment.center,
      height: cart.currentCount > 4 ? 214 : 240,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          if (!(isLoading ?? false))
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Ваши скидки',
                style: textMedium18,
              ),
            ),
          if (!(isLoading ?? false))
            DiscountWidget(
              // minCount: cart.minCount,
              // maxCount: cart.maxCount,
              // currentCount: cart.currentCount,
              discount: cart.discount,
            ),
          if (!(isLoading ?? false)) const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Divider(thickness: 1, color: dividerLightColor),
          ),
          if (!(isLoading ?? false))
            DiscountSizeWidget(
              minCount: cart.minCount,
              maxCount: cart.maxCount,
              currentCount: cart.currentCount,
            ),
          if(cart.currentCount <= 4)...[
            if (!(isLoading ?? false)) const SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child:  Text(
                'Выбрать еще ужины для скидки 17%',
                style: textRegular12Blue,
              ),
            ),
          ],
        ],
      ),
    );
  }
}