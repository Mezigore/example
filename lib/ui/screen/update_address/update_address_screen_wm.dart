import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/base/default_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// [WidgetModel] для <UpdateAddressScreen>
class UpdateAddressScreenWidgetModel extends WidgetModel {
  UpdateAddressScreenWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
    this.addressId,
    this._dialogController,
  ) : super(dependencies);

  final int addressId;
  final UserManager _userManager;
  final NavigatorState _navigator;
  final DefaultDialogController _dialogController;

  final deleteAddressAction = Action<void>();

  /// Адресс прошел валидацию, нужно его обработать
  final acceptAddressAction = Action<NewAddress>();

  /// Состояние загрузки
  final isLoadingState = StreamedState<bool>(false);

  @override
  void onBind() {
    super.onBind();
    bind(acceptAddressAction, _updateAddress);
    bind<void>(deleteAddressAction, (_) => _deleteAddress());
  }

  void _updateAddress(NewAddress address) {
    isLoadingState.accept(true);
    doFutureHandleError<void>(
      _userManager.updateAddress(addressId, address),
      (_) {
        isLoadingState.accept(false);
        _navigator.pop(true);
      },
      onError: (_) {
        isLoadingState.accept(false);
      },
    );
  }

  Future<void> _deleteAddress() async {
    final deleteAgreement = await _dialogController.showAcceptBottomSheet(
      addressDeleteDialogTitle,
      agreeText: deleteDialogAgree,
      cancelText: deleteDialogCancel,
    );
    if (!deleteAgreement) return;
    await isLoadingState.accept(true);
    doFutureHandleError<void>(
      _userManager.removeAddress(addressId),
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
