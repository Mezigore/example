// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';

/// [WidgetModel] для <CompletedOrdersTab>
class CompletedOrdersTabWidgetModel extends WidgetModel with ReloadMixin {
  CompletedOrdersTabWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._orderManager,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final OrderManager _orderManager;

  /// Открыть экран оценивания заказа
  final rateOrderAction = Action<OrderFromHistory>();

  EntityStreamedState<List<OrderFromHistory>> get ordersState =>
      _orderManager.historyState;

  @override
  void onLoad() {
    super.onLoad();
    if ((ordersState.value?.hasError ?? true) ||
        ordersState.value?.data == null) {
      reloadData();
    }
  }

  @override
  void onBind() {
    super.onBind();
    bind(rateOrderAction, _openRateScreen);
  }

  void _openRateScreen(OrderFromHistory order) {
    _navigator.pushNamed(AppRouter.rateOrderScreen, arguments: order);
    AppMetrica.reportEvent('order_rate');
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _orderManager.loadHistoryOrderList(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }
}
