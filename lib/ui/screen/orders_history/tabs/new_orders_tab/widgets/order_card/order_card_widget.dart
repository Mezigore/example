import 'package:flutter/material.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_status.dart';
import 'package:uzhindoma/domain/order/payment_type.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/new_order_title.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/order_card/di/order_card_widget_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/order_card/order_card_widget_wm.dart';
import 'package:uzhindoma/ui/widget/product/product_image.dart';

/// Карточка нового заказа
class NewOrderCardWidget extends MwwmWidget<OrderCardWidgetComponent> {
  NewOrderCardWidget({
    Key key,
    @required NewOrder order,
  })  : assert(order != null),
        super(
          key: key,
          widgetStateBuilder: () => _OrderCardWidgetState(),
          dependenciesBuilder: (context) => OrderCardWidgetComponent(context),
          widgetModelBuilder: (context) => createOrderCardWidgetWidgetModel(
            context,
            order,
          ),
        );
}

class _OrderCardWidgetState extends WidgetState<OrderCardWidgetWidgetModel> {
  bool get isCanceled => wm.newOrder.status == OrderStatus.canceled;

  double get opacity => isCanceled ? 0.5 : 1;

  @override
  Widget build(BuildContext context) {
    final needForCanceled = wm.newOrder.status == OrderStatus.canceled &&
        (wm.newOrder.canBeRestored ?? false);
    final needForNotCanceled = wm.newOrder.status != OrderStatus.canceled &&
        (wm.newOrder.changeConditions?.changesList?.isNotEmpty ?? false);
    final needButton = needForCanceled || needForNotCanceled;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: wm.cardTapAction,
      child: Container(
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Opacity(
                opacity: opacity,
                child: _Images(
                  urls: wm.urls,
                  moreCount: wm.moreDishes,
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: NewOrderTitle(
                  opacity: opacity,
                  title: wm.newOrder.orderNumberTitle,
                  dateTitle: wm.newOrder.orderDateTitle,
                  status: wm.newOrder.status,
                  onDeleteTap: () {wm.deleteTapAction(context);},
                ),
              ),
              Opacity(
                opacity: opacity,
                child: _Row(
                  title: orderDeliveryTitle,
                  info: wm.newOrder.deliveryDateTitle,
                  infoSubtitle: wm.newOrder.deliveryTime.title,
                ),
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: opacity,
                child: _Row(
                  title: orderAddressTitle,
                  info: wm.newOrder.deliveryAddress.name,
                  infoSubtitle: wm.newOrder.deliveryAddress.cityName,
                ),
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: opacity,
                child: _Row(
                  title: orderPaymentTitle,
                  info: wm.newOrder.orderSumm.priceWithDiscountTitle,
                  infoSubtitle: wm.newOrder.paymentType.title,
                ),
              ),
              const SizedBox(height: 16),
              Visibility(
                replacement: const SizedBox(),
                visible: wm.newOrder.noPaperRecipe != null,
                child: Opacity(
                  opacity: opacity,
                  child: _Row(
                    title: recipeTypeTitle,
                    info: wm.newOrder.noPaperRecipe ? noPaperRecipe : paperRecipe,
                    infoSubtitle: recipeType,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (needButton)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: wm.cardBtnTapAction,
                      child: Text(isCanceled ? orderRestore : orderChange),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Images extends StatelessWidget {
  const _Images({
    Key key,
    @required this.urls,
    this.moreCount,
  })  : assert(urls != null),
        super(key: key);

  /// Ссылки
  final List<String> urls;

  /// Сколько блюд еще осталось
  final int moreCount;

  @override
  Widget build(BuildContext context) {
    if (urls.isEmpty) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: SizedBox(
        height: 112,
        child: Stack(
          children: [
            Row(
              children: urls
                  .map(
                    (url) => Expanded(
                      child: SizedBox(
                        height: 112,
                        child: ProductImageWidget(urlImage: url),
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (moreCount != null && moreCount != 0)
              Row(
                children: [
                  Expanded(
                    flex: urls.length - 1,
                    child: const SizedBox.shrink(),
                  ),
                  Expanded(
                    child: Container(
                      color: iconColor,
                      alignment: Alignment.center,
                      child: Text('+$moreCount', style: textMedium24White),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    Key key,
    this.title,
    this.info,
    this.infoSubtitle,
  }) : super(key: key);

  final String title;
  final String info;
  final String infoSubtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            alignment: Alignment.topLeft,
            child: Text(title, style: textMedium14),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: textRegular14,
                ),
                if (infoSubtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    infoSubtitle,
                    style: textRegular12Secondary,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
