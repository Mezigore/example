import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/di/new_orders_tab_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/new_orders_tab_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/new_order_loader.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/widgets/order_card/order_card_widget.dart';
import 'package:uzhindoma/ui/screen/orders_history/widgets/orders_history_emoty_placeholder.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// таб с новыми заказами
class NewOrdersTab extends MwwmWidget<NewOrdersTabComponent> {
  NewOrdersTab({Key key})
      : super(
          widgetModelBuilder: createNewOrdersTabWidgetModel,
          dependenciesBuilder: (context) => NewOrdersTabComponent(context),
          widgetStateBuilder: () => _NewOrdersTabState(),
          key: key,
        );
}

class _NewOrdersTabState extends WidgetState<NewOrdersTabWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<NewOrder>>(
      streamedState: wm.newOrdersState,
      loadingChild: _LoaderPlaceholder(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      child: (context, orders) {
        if (orders == null || orders.isEmpty) {
          return const EmptyPlaceholder();
        } else {
          return SwipeRefresh.builder(
            stateStream: wm.reloadState.stream,
            onRefresh: wm.reloadAction,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: NewOrderCardWidget(order: orders[index]),
              );
            },
            itemCount: orders.length,
          );
        }
      },
    );
  }
}

class _LoaderPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        children: List.generate(
          2,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: NewOrderLoader(),
          ),
        ),
      ),
    );
  }
}
