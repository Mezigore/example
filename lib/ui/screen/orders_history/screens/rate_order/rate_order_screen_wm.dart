// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/order_from_history.dart';
import 'package:uzhindoma/domain/order/orders_history_raiting.dart';
import 'package:uzhindoma/domain/order/rating_reason.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';

/// [WidgetModel] для <RateOrderScreen>
class RateOrderScreenWidgetModel extends WidgetModel {
  RateOrderScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._orderDialogController,
    this.originalOrder,
    this._orderManager,
  )   : orderState = StreamedState<OrderFromHistory>(originalOrder),
        super(dependencies);

  /// Поток с измененным заказом
  final StreamedState<OrderFromHistory> orderState;
  final OrderDialogController _orderDialogController;

  final OrderManager _orderManager;

  /// Заказ для оценивания
  final OrderFromHistory originalOrder;

  final NavigatorState _navigator;

  final _changes = <String, OrdersHistoryRating>{};

  /// Изменение оценки
  final changeRatingAction = Action<OrdersHistoryRating>();

  /// Поток с информацией есть ли изменения в оценке
  final hasChangesState = StreamedState<bool>(false);

  /// Идет ли обновление заказа
  final loadingState = StreamedState<bool>(false);

  /// Событие сохранить изменения рейтинга
  final saveRatingAction = Action<void>();

  @override
  void onBind() {
    super.onBind();
    bind(changeRatingAction, _onChangeRating);
    bind<void>(saveRatingAction, (_) => _saveChanges());
    subscribe(orderState.stream, _checkForChanges);
  }

  Future<void> _onChangeRating(OrdersHistoryRating newRating) async {
    final previousRating = _changes[newRating.id];
    OrdersHistoryRating rating = previousRating?.merge(newRating) ?? newRating;
    final oldOrder = orderState.value;
    if (oldOrder == null) return;
    try {
      final previousRating = _changes[rating.id];

      if (rating.itemRating != null &&
          rating.itemRating > 0 &&
          rating.itemRating <= 3 &&
          previousRating?.reason == null) {
        final reason =
            await _orderDialogController.showOrderLowRateReasonPicker([
          RatingReason.taste,
          RatingReason.cooking,
          RatingReason.quality,
          RatingReason.other,
        ]);
        if (reason != null) {
          rating = rating.copyWith(reason: reason);
        }
      }
      final newOrder = oldOrder.rate([rating]);
      await orderState.accept(newOrder);
      _changes[rating.id] = rating;
    } on UnavailableActionException catch (_) {
      //Не должно быть такого по идее
    }
  }

  void _checkForChanges(OrderFromHistory newOrder) {
    for (int i = 0; i < newOrder.itemsFromHistory.length; i++) {
      if (newOrder.itemsFromHistory[i].id !=
          originalOrder.itemsFromHistory[i].id) {
        /// По какой то причине не совпало, неконсистентное состояние, лучше зайти заново
        hasChangesState.accept(false);
        return;
      }
      if (newOrder.itemsFromHistory[i].recipeRating !=
              originalOrder.itemsFromHistory[i].recipeRating ||
          newOrder.itemsFromHistory[i].itemRating !=
              originalOrder.itemsFromHistory[i].itemRating) {
        hasChangesState.accept(true);
        return;
      }
    }
    if (newOrder.extraItemsFromHistory != null) {
      for (int i = 0; i < newOrder.extraItemsFromHistory.length; i++) {
        if (newOrder.extraItemsFromHistory[i].id !=
            originalOrder.extraItemsFromHistory[i].id) {
          /// По какой то причине не совпало, неконсистентное состояние, лучше зайти заново
          hasChangesState.accept(false);
          return;
        }
        if (newOrder.extraItemsFromHistory[i].itemRating !=
            originalOrder.extraItemsFromHistory[i].itemRating) {
          hasChangesState.accept(true);
          return;
        }
      }
    }
  }

  void _saveChanges() {
    loadingState.accept(true);
    AppMetrica.reportEvent('order_rate_save');
    doFutureHandleError<void>(
      _orderManager.rateOrder(originalOrder.id, _changes.values.toList()),
      (_) => _navigator.pop(),
      onError: (_) => loadingState.accept(false),
    );
  }
}
