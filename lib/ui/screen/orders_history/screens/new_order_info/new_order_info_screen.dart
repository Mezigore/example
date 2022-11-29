import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/cart/widgets/cart_price_widget.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/new_order_info/di/new_order_info_screen_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/new_order_info/new_order_info_screen_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/new_order_title.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';
import 'package:uzhindoma/util/const.dart';

/// Экран для просмотра информации о заказе
class NewOrderInfoScreen extends MwwmWidget<NewOrderInfoScreenComponent> {
  NewOrderInfoScreen({
    Key key,
    @required NewOrder order,
  })  : assert(order != null),
        super(
          key: key,
          widgetStateBuilder: () => _NewOrderInfoScreenState(),
          dependenciesBuilder: (context) => NewOrderInfoScreenComponent(
            context,
          ),
          widgetModelBuilder: (context) => createNewOrderInfoScreenWidgetModel(
            context,
            order,
          ),
        );
}

class _NewOrderInfoScreenState
    extends WidgetState<NewOrderInfoScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<NewOrderInfoScreenComponent>(context)
          .component
          .scaffoldKey,
      appBar: const DefaultAppBar(
        title: orderInfoTitle,
        leadingIcon: Icons.arrow_back_ios,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 32),
              child: NewOrderTitle(
                opacity: 1,
                title: wm.order.orderNumberTitle,
                dateTitle: wm.order.orderDateTitle,
                onDeleteTap: () {wm.deleteAction(context);},
                status: wm.order.status,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                final item = wm.order.boughtItems[index];
                return _ItemTile(
                  name: item.name,
                  url: item.previewImg,
                  price: item.priceTitle,
                  discountPrice: item.discountPriceTitle,
                );
              },
              childCount: wm.order.boughtItems.length,
            ),
          ),
          if (wm.order.boughtExtraItems != null)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final item = wm.order.boughtExtraItems[index];
                  return _ItemTile(
                    name: item.name,
                    url: item.previewImg,
                    price: item.priceTitle,
                  );
                },
                childCount: wm.order.boughtExtraItems.length,
              ),
            ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CartSumWidget(
                    fullPrice: wm.order.orderSumm.fullPriceTitle,
                    priceWithDiscount:
                        wm.order.orderSumm.priceWithDiscountTitle,
                    discount: wm.order.orderSumm.discountTitle,
                  ),
                  const SizedBox(height: 48),
                  SafeArea(
                    left: false,
                    right: false,
                    child: SizedBox(
                      height: btnHeight,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: wm.closeAction,
                        child: const Text(orderInfoBackToList),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Виджет для отображения одного блюда в корзине
class _ItemTile extends StatelessWidget {
  const _ItemTile({
    Key key,
    @required this.name,
    @required this.url,
    @required this.price,
    this.discountPrice,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  })  : assert(name != null),
        assert(url != null),
        assert(price != null),
        super(key: key);

  final String name;
  final String url;
  final String price;
  final String discountPrice;

  /// Отступы карточки
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ImageWidget(imageUrl: url),
                    const SizedBox(width: 16),
                    _InfoProductExtraWidget(
                      name: name,
                      price: price,
                      discountPrice: discountPrice,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: dividerLightColor,
          ),
        ],
      ),
    );
  }
}

class _ImageWidget extends StatelessWidget {
  const _ImageWidget({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: ProductImageWidget(
          urlImage: imageUrl,
          boxFit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class _InfoProductExtraWidget extends StatelessWidget {
  const _InfoProductExtraWidget({
    Key key,
    @required this.name,
    @required this.price,
    this.discountPrice,
  })  : assert(name != null),
        assert(price != null),
        super(key: key);
  final String name;
  final String price;
  final String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TitleProduct(title: name),
          SizedBox(
            height: 40,
            child: _CartItemPrice(
              price: price,
              discountPrice: discountPrice,
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleProduct extends StatelessWidget {
  const _TitleProduct({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: textRegular14,
    );
  }
}

class _CartItemPrice extends StatelessWidget {
  const _CartItemPrice({
    Key key,
    @required this.price,
    this.discountPrice,
  })  : assert(price != null),
        super(key: key);

  final String price;
  final String discountPrice;

  bool get _hasDiscount => discountPrice != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _hasDiscount ? discountPrice : price,
          style: textMedium18,
        ),
        if (_hasDiscount)
          Text(
            price,
            style: textRegular14Hint.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}
