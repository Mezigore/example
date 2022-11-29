import 'package:flutter/widgets.dart' hide Action;
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:uzhindoma/domain/user/update_profile.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/base/material_message_controller.dart';
import 'package:uzhindoma/ui/common/order_dialog_controller.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/base/create_order_base_wm.dart';

// ignore_for_file: prefer_mixin

/// WidgetModel для <UserInfoScreen>
class UserInfoScreenWidgetModel extends CreateOrderBaseWidgetModel
    with WidgetsBindingObserver {
  UserInfoScreenWidgetModel(
    surf_mwwm.WidgetModelDependencies dependencies,
    NavigatorState navigator,
    OrderDialogController dialogController,
    this._userManager,
    this._analyticsInteractor,
    this._messageController,
  ) : super(
          dependencies,
          navigator,
          dialogController,
        );

  final UserManager _userManager;
  final AnalyticsInteractor _analyticsInteractor;
  final surf_mwwm.MessageController _messageController;

  final formKey = GlobalKey<FormState>();

  final nameController = surf_mwwm.TextEditingAction();
  final lastNameController = surf_mwwm.TextEditingAction();
  final emailController = surf_mwwm.TextEditingAction();
  final phoneController = surf_mwwm.TextEditingAction();

  final scrollController = ScrollController();

  final nameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();

  final nextAction = surf_mwwm.Action<void>();
  final onChangePhoneAction = surf_mwwm.Action<void>();

  /// Состояние валидности номера телефона
  final keyBoardOnScreenState = surf_mwwm.StreamedState<bool>(false);

  /// Состояние автопроверки формы. На старте отключено
  final autovalidateModeState =
  surf_mwwm.StreamedState<AutovalidateMode>(AutovalidateMode.disabled);

  @override
  void onLoad() {
    super.onLoad();

    subscribe<surf_mwwm.EntityState<UserInfo>>(
      _userManager.userState.stream,
      (state) {
        if (!(state.isLoading ?? false) && !(state.hasError ?? false)) {
          _initInfo();
        }
      },
    );

    WidgetsBinding.instance.addObserver(this);
    emailFocusNode.addListener(
      () {
        if (emailFocusNode.hasFocus) {
          Future.delayed(
            const Duration(milliseconds: 200),
            () => scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeOutCubic,
            ),
          );
        }
      },
    );
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(onChangePhoneAction, (_) => _openReplacePhoneNumberScreen());
    bind<void>(nextAction, (_) => _nextStep());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    scrollController.dispose();
    nameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    keyBoardOnScreenState.accept(
      WidgetsBinding.instance.window.viewInsets.bottom > 0,
    );
  }

  void _initInfo() {
    final user = _userManager.userState.value?.data;
    if (user == null) return;
    nameController.controller.text = user.name;
    lastNameController.controller.text = user.lastName;
    phoneController.controller.text = user.phone;
    emailController.controller.text = user.email;
  }

  void _openReplacePhoneNumberScreen() {
    navigator.pushNamed(AppRouter.replacementPhoneNumber);
  }

  /// Валидация текстовых полей на пустоту
  String validateField(String value) {
    return value.isEmpty ? '' : null;
  }

  void _nextStep() {
    final currentUser = _userManager.userState.value?.data;

    if (currentUser == null) return;

    if ((nameController.value?.isNotEmpty ?? false) &&
        (lastNameController.value?.isNotEmpty ?? false) &&
        (emailController.value?.isNotEmpty ?? false)) {
      if(formKey.currentState.validate()) {
        _updateUser();
      } else {
        autovalidateModeState.accept(AutovalidateMode.onUserInteraction);
      }
    } else {
      formKey.currentState.validate();
      autovalidateModeState.accept(AutovalidateMode.onUserInteraction);

      _messageController.show(
        msg: errorEmptyFields,
        msgType: MsgType.commonError,
      );
    }
  }

  void _updateUser() {
    doFutureHandleError<void>(
      _userManager.updateUserInfo(
        UpdateProfile(
          name: nameController.value,
          lastName: lastNameController.value,
          email: emailController.value,
        ),
      ),
      (_) => _openNextScreen(),
    );
  }

  void _openNextScreen() {
    _analyticsInteractor.events.trackProfileAdded();
    if (!_userManager.hasAddresses) {
      navigator.pushReplacementNamed(AppRouter.createOrderCreateAddress);
    } else {
      navigator.pushReplacementNamed(AppRouter.createOrderSelectAddress);
    }
  }
}
