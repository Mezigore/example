import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_base_wm.dart';

/// [WidgetModel] для <CreateOrderAddressScreen>
class CreateOrderScreenWidgetModel extends CreateOrderBaseWidgetModel {
  CreateOrderScreenWidgetModel(
    WidgetModelDependencies dependencies,
    NavigatorState navigator,
    OrderDialogController orderDialogController,
    this._userManager,
    // ignore: avoid_positional_boolean_parameters
    this._canGoBack,
  ) : super(
          dependencies,
          navigator,
          orderDialogController,
        );

  final UserManager _userManager;
  final bool _canGoBack;

  /// Событие на то, что пользователь ввел валидный адрес
  final addressValidatedAction = Action<NewAddress>();

  @override
  void onBind() {
    super.onBind();
    bind(addressValidatedAction, _addAddress);
  }

  @override
  //ignore: avoid_annotating_with_dynamic
  void handleError(dynamic e) {
    if (e is! MessagedException) {
      super.handleError(MessagedException(errorAddressText));
    } else {
      super.handleError(e);
    }
  }

  @override
  Future<void> closeOrder() async {
    if (_canGoBack ?? false) {
      navigator.pop();
    } else {
      await super.closeOrder();
    }
  }

  void _addAddress(NewAddress address) {
    doFutureHandleError<void>(
      _userManager.addAddress(address),
      (_) {
        if (_canGoBack ?? false) {
          final addresses = _userManager.userAddressesState.value?.data;
          final newAddress = addresses?.firstWhere(
            (e) =>
                e.flat == address.flat &&
                e.floor == address.floor &&
                e.section == address.section,
            orElse: () => null,
          );
          // Нет возможности сразу узнать какой адрес добавили, поэтому ищу п оимени
          // Имя тоже не всегда совпадает, поэтому как повезет
          if (newAddress != null) {
            navigator.pop(newAddress);
          } else {
            navigator.pop();
          }
        } else {
          navigator.pushReplacementNamed(AppRouter.createOrderSelectAddress);
        }
      },
    );
  }
}
