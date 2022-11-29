// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/domain/order/order_wrapper.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/city/city_manager.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/order/order_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_base_wm.dart';

/// [WidgetModel] для <SelectDeliveryDateScreen>
class SelectDeliveryDateScreenWidgetModel extends CreateOrderBaseWidgetModel {
  SelectDeliveryDateScreenWidgetModel(
    WidgetModelDependencies dependencies,
    NavigatorState navigator,
    OrderDialogController orderDialogController,
    this._orderManager,
    this._cityManager,
    this._analyticsInteractor,
  ) : super(
          dependencies,
          navigator,
          orderDialogController,
        );

  final OrderManager _orderManager;
  final CityManager _cityManager;
  final AnalyticsInteractor _analyticsInteractor;

  final dateState = EntityStreamedState<List<DeliveryDate>>();
  final selectedDeliveryDateState = StreamedState<DeliveryDate>();
  final selectedIntervalState = StreamedState<DeliveryTimeInterval>();

  final selectDateAction = Action<DeliveryDate>();
  final selectIntervalAction = Action<DeliveryTimeInterval>();
  final acceptDateAction = Action<void>();

  final reloadAction = Action<void>();

  @override
  void onLoad() {
    super.onLoad();

    subscribe<DeliveryDate>(selectedDeliveryDateState.stream, (date) {
      if (date == null || date.time == null || date.time.isEmpty) {
        /// Очищаем для упрощения проверки
        selectedIntervalState.accept();
        return;
      }
      selectedIntervalState.accept(date.time.first);
    });

    subscribe<EntityState<List<DeliveryDate>>>(dateState.stream, (entity) {
      if ((entity.isLoading ?? true) || (entity.hasError ?? true)) return;
      selectedDeliveryDateState.accept(entity.data.first);
    });

    _loadDate();
  }

  @override
  void onBind() {
    super.onBind();
    bind(selectDateAction, selectedDeliveryDateState.accept);
    bind(selectIntervalAction, selectedIntervalState.accept);
    bind<void>(reloadAction, (_) => _loadDate());
    bind<void>(acceptDateAction, (_) => _openNextScreen());
  }

  void _loadDate() {
    final cityId = _orderManager.orderWrapperState.value?.address?.cityId ??
        _cityManager.currentCityId;
    if (cityId == null) return;
    doFutureHandleError(
      _orderManager.getDeliveryDate(cityId.toString()),
      dateState.content,
      onError: dateState.error,
    );
  }

  void _openNextScreen() {
    _analyticsInteractor.events.trackDateAdded();
    AppMetrica.reportEvent('date_added');
    if (selectedDeliveryDateState.value == null ||
        selectedIntervalState.value == null) {
      handleError(MessagedException(createOrderNeedToSelectDate));
      return;
    }
    final oldWrapper =
        _orderManager.orderWrapperState.value ?? const OrderWrapper();
    _orderManager.orderWrapperState.accept(
      oldWrapper.copyWith(
        deliveryDate: selectedDeliveryDateState.value,
        deliveryTimeInterval: selectedIntervalState.value,
      ),
    );
    navigator.pushNamed(AppRouter.createOrderSelectPayment);
  }
}
