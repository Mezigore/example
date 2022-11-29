import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/orders_history/di/orders_history_screen_component.dart';
import 'package:uzhindoma/ui/screen/orders_history/orders_history_screen_wm.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/completed_orders_tab/completed_orders_tab.dart';
import 'package:uzhindoma/ui/screen/orders_history/tabs/new_orders_tab/new_orders_tab.dart';

/// Экран с историей заказов
class OrdersHistoryScreen extends MwwmWidget<OrdersHistoryScreenComponent> {
  OrdersHistoryScreen({Key key})
      : super(
          widgetModelBuilder: createOrdersHistoryScreenWidgetModel,
          dependenciesBuilder: (context) =>
              OrdersHistoryScreenComponent(context),
          widgetStateBuilder: () => _OrdersHistoryScreenState(),
          key: key,
        );
}

class _OrdersHistoryScreenState
    extends WidgetState<OrdersHistoryScreenWidgetModel> {
  final tabs = TabBarView(
    children: [
      NewOrdersTab(),
      CompletedOrdersTab(),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
        length: tabs.children.length,
        child: Scaffold(
          key: Injector.of<OrdersHistoryScreenComponent>(context)
              .component
              .scaffoldKey,
          appBar: const DefaultAppBar(
            title: orderHistoryAppBarTitle,
            leadingIcon: Icons.arrow_back_ios,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TabBar(
                  labelStyle: textMedium12,
                  unselectedLabelColor: textColorHint,
                  labelColor: textColorAccent,
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3.0,
                      color: textColorAccent,
                    ),
                  ),
                  tabs: const [
                    Tab(text: orderHistoryNewTabTitle),
                    Tab(text: orderHistoryCompletedTabTitle),
                  ],
                ),
              ),
              Expanded(
                child: tabs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
