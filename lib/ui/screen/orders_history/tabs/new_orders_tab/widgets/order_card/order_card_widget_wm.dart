import 'dart:developer';

import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/domain/order/new_order.dart';
import 'package:uzhindoma/domain/order/order_change_enum.dart';
import 'package:uzhindoma/domain/order/order_status.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/business_string.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/orders_history/widgets/delete_error.dart';

/// [WidgetModel] для <OrderCardWidget>
class OrderCardWidgetWidgetModel extends WidgetModel {
  OrderCardWidgetWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.newOrder,
    this._dialogController,
    this._orderManager,
  ) : super(dependencies);

  /// Заказ
  final NewOrder newOrder;
  final OrderManager _orderManager;
  final OrderDialogController _dialogController;

  final NavigatorState _navigator;

  /// ссылки с изображениями
  final List<String> urls = [];

  /// Если еще блюда помимо тех, что на картинке
  int moreDishes = 0;

  /// Нажатие на кнопку на карточке
  final cardBtnTapAction = Action<void>();

  /// Отмена заказа
  final deleteTapAction = Action<void>();

  /// Нажатие на карточку
  final cardTapAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    if (newOrder.boughtItems != null) {
      if (newOrder.boughtItems.length > 3) {
        urls.addAll(
          newOrder.boughtItems.sublist(0, 3).map((i) => i.previewImg),
        );
        moreDishes = newOrder.boughtItems.length - 3;
      } else {
        urls.addAll(newOrder.boughtItems.map((i) => i.previewImg));
      }
    }
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(deleteTapAction, (context) => _cancelOrder(context as BuildContext));
    bind<void>(cardBtnTapAction, (_) => _onBtnTap());
    bind<void>(cardTapAction, (_) => _openInfoScreen());
  }

  Future<void> _cancelOrder(BuildContext context) async {
    if (newOrder.status == OrderStatus.paid) {
      final isAccepted = await _dialogController.showAcceptBottomSheet(
        orderCancelPaidTitle,
        cancelText: orderCancelPaidCancel,
        agreeText: orderCancelPaidAccept,
      );
      if ((isAccepted ?? false) && await launcher.canLaunch(phone)) {
        await launcher.launch(phone);
      }
      return;
    }
    if (newOrder.status == OrderStatus.confirmed) {
      final reason = await _dialogController.showCancelOrderBottomSheet();
      if (reason.isNotEmpty) {
        final String result = await _orderManager.cancelOrder(newOrder.id, reason);
        if (result == 'success') await _orderManager.loadActualOrderList();
        if (result != null && result != 'success') {
          DeleteError.showWarningWithWhatsApp(context: context);
        }
      }
    }
    return;
  }

  Future<void> _onBtnTap() async {
    if (newOrder.status == OrderStatus.confirmed ||
        newOrder.status == OrderStatus.paid) {
      final changeList = newOrder.changeConditions.changesList;
      if (newOrder.status == OrderStatus.paid) {
        changeList.remove(OrderChanges.changePaymentType);
      }
      final changeType =
          await _dialogController.showOrderChangesPicker(changeList);
      if (changeType != null) {
        final isChanged = await _navigator.pushNamed<bool>(
          AppRouter.changeOrder,
          arguments: Pair(changeType, newOrder),
        );
        if (isChanged ?? false) {
          doFutureHandleError<void>(
            _orderManager.loadActualOrderList(),
            (_) {
              //DO NOTHING
            },
          );
        }
      }
      return;
    }
    if (newOrder.status == OrderStatus.canceled) {
      doFutureHandleError<void>(
        _orderManager.restoreOrder(newOrder.id),
        (_) {
          doFutureHandleError<void>(
            _orderManager.loadActualOrderList(),
            (_) {
              //DO NOTHING
            },
          );
        },
      );
    }
  }

  void _openInfoScreen() {
    _navigator.pushNamed(AppRouter.newOrderInfo, arguments: newOrder);
  }
}
