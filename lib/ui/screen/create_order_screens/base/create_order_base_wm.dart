import 'package:flutter/material.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_route.dart';

/// Стандартная [WidgetModel] для всех экранов создания заказа
/// с общими методами
class CreateOrderBaseWidgetModel extends WidgetModel {
  CreateOrderBaseWidgetModel(
    WidgetModelDependencies baseDependencies,
    this.navigator,
    this.orderDialogController,
  ) : super(baseDependencies);

  final NavigatorState navigator;

  /// DialogController с диалогами для экранов оформления заказа
  final OrderDialogController orderDialogController;
  WidgetModelDependencies dependencies;

  /// Закрытие экрана заказа
  final cancelOrderAction = Action<void>();

  /// Предыдущий шаг
  final previousStepAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    bind<void>(cancelOrderAction, (_) => closeOrder());
    bind<void>(previousStepAction, (_) => back());
  }

  Future<void> closeOrder() async {
    final needClose = await orderDialogController.showAcceptBottomSheet(
      createOrderCloseSheetTitle,
      subtitle: createOrderCloseSheetSubtitle,
      cancelText: createOrderCloseSheetCancel,
      agreeText: createOrderCloseSheetAccept,
    );
    if (needClose) {
      navigator.popUntil((route) => route is! CreateOrderMaterialRoute);
    }
  }

  void back() {
    navigator.pop();
  }
}
