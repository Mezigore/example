import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';

/// [WidgetModel] для <NewOrdersTab>
class NewOrdersTabWidgetModel extends WidgetModel with ReloadMixin {
  NewOrdersTabWidgetModel(
    WidgetModelDependencies dependencies,
    this._orderManager,
  ) : super(dependencies);

  final OrderManager _orderManager;

  EntityStreamedState<List<NewOrder>> get newOrdersState =>
      _orderManager.actualState;

  @override
  void onLoad() {
    super.onLoad();
    if ((newOrdersState.value?.hasError ?? true) ||
        newOrdersState.value?.data == null) {
      reloadData();
    }
  }

  @override
  void reloadData() {
    doFutureHandleError<void>(
      _orderManager.loadActualOrderList(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }
}
