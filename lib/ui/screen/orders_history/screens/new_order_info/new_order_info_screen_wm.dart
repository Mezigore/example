import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/screen/orders_history/widgets/delete_error.dart';

import '../../../../common/order_dialog_controller.dart';

/// [WidgetModel] для <NewOrderInfoScreen>
class NewOrderInfoScreenWidgetModel extends WidgetModel {
  NewOrderInfoScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._dialogController,
    this.order,
    this._orderManager,
  ) : super(dependencies);

  final NewOrder order;
  final NavigatorState _navigator;
  final OrderManager _orderManager;
  final OrderDialogController _dialogController;

  final deleteAction = Action<void>();
  final closeAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    bind<void>(closeAction, (_) => _closeScreen());
    bind<void>(deleteAction, (context) => _deleteOrder(context as BuildContext));
  }

  void _closeScreen() {
    _navigator.pop();
  }

  void _deleteOrder(BuildContext context) async {
    // doFutureHandleError<void>(
    //   _orderManager.cancelOrder(order.id),
    //   (_) => _closeScreen(),
    // );
    final reason = await _dialogController.showCancelOrderBottomSheet();
    if (reason.isNotEmpty) {
      final String result = await _orderManager.cancelOrder(order.id, reason);
      if (result == 'success') {
        await _orderManager.loadActualOrderList();
        _closeScreen();
      }
      if (result != null && result != 'success') {
        DeleteError.showWarningWithWhatsApp(context: context);
      }
    }
    // final String result = await _orderManager.cancelOrder(order.id);
    // if (result == 'success') _closeScreen();
    // if (result != null && result != 'success') {
    // DeleteError.showWarningWithWhatsApp(context: context);
    // }
  }
}
