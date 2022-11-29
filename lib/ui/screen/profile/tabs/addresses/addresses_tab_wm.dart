import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:uzhindoma/domain/addresses/new_address.dart';
import 'package:uzhindoma/domain/addresses/user_address.dart';
import 'package:uzhindoma/domain/core.dart';
import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/common/reload/reload_mixin.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';

/// [WidgetModel] для <AddressesScreen>
class AddressesTabWidgetModel extends WidgetModel with ReloadMixin {
  AddressesTabWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
  ) : super(dependencies);

  final NavigatorState _navigator;
  final UserManager _userManager;

  /// Перейти на экран добавления нового адреса
  final addNewAddressAction = Action<void>();

  /// Нажатие на адрес
  final addressTapAction = Action<UserAddress>();

  /// Пользователь ввел первый адрес
  final firstAddressAccepted = Action<NewAddress>();

  /// Основные адреса
  final defaultAddressState = StreamedState<List<UserAddress>>();

  /// Дополнительные адреса
  final additionalAddressesState = StreamedState<List<UserAddress>>();

  EntityStreamedState<List<UserAddress>> get addressesListState =>
      _userManager.userAddressesState;

  @override
  void onLoad() {
    super.onLoad();
    _loadAddresses();
    _updateAddressesState();
  }

  @override
  void onBind() {
    super.onBind();
    bind(addressTapAction, _openUpdateAddressScreen);
    bind(firstAddressAccepted, _addFirstAddress);
    bind<void>(addNewAddressAction, (_) => _openAddAddressScreen());
  }

  @override
  void reloadData() {
    _loadAddresses();
  }

  void _loadAddresses() {
    addressesListState.loading();
    doFutureHandleError<void>(
      _userManager.loadUserAddresses(),
      (_) => reloadState.accept(SwipeRefreshState.hidden),
      onError: (_) => reloadState.accept(SwipeRefreshState.hidden),
    );
  }

  void _updateAddressesState() {
    subscribe<EntityState<List<UserAddress>>>(addressesListState.stream,
        (entityState) {
      if (!entityState.hasError &&
          entityState.data != null &&
          entityState.data.isNotEmpty) {
        final allAddresses = entityState.data;
        final defaultAddresses = allAddresses
            .where(
              (address) => address.isDefault,
            )
            .toList();
        final additionalAddresses = allAddresses
            .where(
              (address) => !address.isDefault,
            )
            .toList();

        defaultAddressState.accept(defaultAddresses);
        additionalAddressesState.accept(additionalAddresses);
      }
    });
  }

  void _openUpdateAddressScreen(UserAddress address) {
    _navigator.pushNamed(
      AppRouter.updateAddressScreen,
      arguments: Pair<int, NewAddress>(
        address.id,
        NewAddress.fromUserAddress(address),
      ),
    );
  }

  void _addFirstAddress(NewAddress address) {
    doFuture<void>(
      _userManager.addAddress(address.copyWith(isDefault: true)),
      (_) {
        //DO NOTHING
      },
      onError: (e) {
        if (e is! MessagedException) {
          handleError(MessagedException(errorAddressText));
        } else {
          handleError(e);
        }
      },
    );
  }

  void _openAddAddressScreen() {
    _navigator.pushNamed(AppRouter.addAddressScreen);
  }
}
