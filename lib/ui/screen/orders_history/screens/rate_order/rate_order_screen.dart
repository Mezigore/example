import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/animations.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/di/rate_order_screen_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/rate_order_screen_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/screens/rate_order/widgets/rate_card_widget.dart';

/// Экран оценки заказа
class RateOrderScreen extends MwwmWidget<RateOrderScreenComponent> {
  RateOrderScreen({
    Key key,
    OrderFromHistory order,
  }) : super(
          key: key,
          widgetStateBuilder: () => _RateOrderScreenState(),
          dependenciesBuilder: (context) => RateOrderScreenComponent(context),
          widgetModelBuilder: (context) => createRateOrderScreenWidgetModel(
            context,
            order,
          ),
        );
}

class _RateOrderScreenState extends WidgetState<RateOrderScreenWidgetModel>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<RateOrderScreenComponent>(context).component.scaffoldKey,
      appBar: const DefaultAppBar(
        title: rateScreenTitle,
        leadingIcon: Icons.close,
      ),
      body: StreamedStateBuilder<bool>(
        streamedState: wm.loadingState,
        builder: (_, isLoading) => AbsorbPointer(
          absorbing: isLoading ?? true,
          child: Column(
            children: [
              Expanded(
                child: StreamedStateBuilder<OrderFromHistory>(
                  streamedState: wm.orderState,
                  builder: (_, order) => CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (_, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            child: RateCardWidget(
                              key: ValueKey(order.itemsFromHistory[index].id),
                              onChangeRating: wm.changeRatingAction,
                              item: order.itemsFromHistory[index],
                              isEnabled: !wm.originalOrder
                                  .itemsFromHistory[index].isRated,
                            ),
                          ),
                          childCount: order.itemsFromHistory.length,
                        ),
                      ),
                      if (order.extraItemsFromHistory != null)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              child: RateCardWidget(
                                key: ValueKey(
                                    order.extraItemsFromHistory[index]),
                                onChangeRating: wm.changeRatingAction,
                                item: order.extraItemsFromHistory[index],
                                isEnabled: !wm.originalOrder
                                    .extraItemsFromHistory[index].isRated,
                              ),
                            ),
                            childCount: order.extraItemsFromHistory.length,
                          ),
                        ),
                      const SliverToBoxAdapter(child: SizedBox(height: 36)),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: fastAnimation,
                vsync: this,
                child: StreamedStateBuilder<bool>(
                  streamedState: wm.hasChangesState,
                  builder: (_, hasChanges) {
                    if (!(hasChanges ?? false)) {
                      return const SizedBox(
                        width: double.infinity,
                        height: 0,
                      );
                    }
                    return SafeArea(
                      right: false,
                      left: false,
                      child: StreamedStateBuilder<bool>(
                        streamedState: wm.loadingState,
                        builder: (_, isLoading) => AcceptButton(
                          isLoad: isLoading,
                          callback: wm.saveRatingAction,
                          text: saveTitle,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
