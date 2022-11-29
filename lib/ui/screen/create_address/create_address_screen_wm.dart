import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';

/// [WidgetModel] для <CreateAddressScreen>
class CreateAddressScreenWidgetModel extends WidgetModel {
  CreateAddressScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
  ) : super(dependencies);

  final UserManager _userManager;
  final NavigatorState _navigator;

  /// Адресс прошел валидацию, нужно его обработать
  final acceptAddressAction = Action<NewAddress>();

  /// Состояние загрузки
  final isLoadingState = StreamedState<bool>(false);

  @override
  void onBind() {
    super.onBind();
    bind(acceptAddressAction, _createAddress);
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

  void _createAddress(NewAddress address) {
    isLoadingState.accept(true);
    doFutureHandleError<void>(
      _userManager.addAddress(address),
      (_) {
        isLoadingState.accept(false);
        _navigator.pop(true);
      },
      onError: (_) {
        isLoadingState.accept(false);
      },
    );
  }
}
