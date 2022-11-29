import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/completed_orders_tab/completed_orders_tab_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/completed_orders_tab/di/completed_orders_tab_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/completed_orders_tab/widgets/complete_order_loader.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/completed_orders_tab/widgets/completed_order.dart';
import 'package:uzhindoma/ui/screen/orders_history/widgets/orders_history_emoty_placeholder.dart';
import 'package:uzhindoma/ui/widget/error/error.dart';

/// Таб с завершенными заказами
class CompletedOrdersTab extends MwwmWidget<CompletedOrdersTabComponent> {
  CompletedOrdersTab({Key key})
      : super(
          widgetModelBuilder: createCompletedOrdersTabWidgetModel,
          dependenciesBuilder: (context) =>
              CompletedOrdersTabComponent(context),
          widgetStateBuilder: () => _CompletedOrdersTabState(),
          key: key,
        );
}

class _CompletedOrdersTabState
    extends WidgetState<CompletedOrdersTabWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return EntityStateBuilder<List<OrderFromHistory>>(
      streamedState: wm.ordersState,
      loadingChild: _LoaderPlaceholder(),
      errorChild: ErrorStateWidget(onReloadAction: wm.reloadAction),
      child: (_, orders) {
        if (orders == null || orders.isEmpty) return const EmptyPlaceholder();
        return SwipeRefresh.builder(
          onRefresh: wm.reloadAction,
          stateStream: wm.reloadState.stream,
          itemCount: orders.length,
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CompletedOrderWidget(
                order: orders[index],
                onRateTap: () => wm.rateOrderAction(orders[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class _LoaderPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: List.generate(
          3,
          (index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: CompletedOrderLoader(),
          ),
        ),
      ),
    );
  }
}
