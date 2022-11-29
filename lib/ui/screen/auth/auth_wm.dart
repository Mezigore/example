// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as Mwwm;
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/screen/auth/auth_screen.dart';
import 'package:uzhindoma/util/clean_phone_number.dart';
import 'package:uzhindoma/util/validate_data.dart';

/// [WidgetModel] for [AuthScreen]
class AuthWidgetModel extends WidgetModel {
  AuthWidgetModel(
    WidgetModelDependencies dependencies, {
    @required NavigatorState navigator,
    @required AuthManager authManager,
  })  : _navigator = navigator,
        _authManager = authManager,
        super(dependencies);

  final NavigatorState _navigator;
  final AuthManager _authManager;

  /// Состояние экрана
  final screenBehaviuorState = Mwwm.EntityStreamedState<void>();

  /// Состояние валидности номера телефона
  /// null - ошибок нет
  /// иначе - текст ошибки
  final phoneValidState = Mwwm.StreamedState<String>();

  final canLoginState = Mwwm.StreamedState<bool>(false);

  /// Отправить смс код
  final sendCode = Mwwm.Action<void>();

  /// Контроллер
  final phoneController = Mwwm.TextEditingAction();
  final phoneFocusNode = FocusNode();

  @override
  void onLoad() {
    super.onLoad();
    _init();
  }

  void _init() {
    screenBehaviuorState.content();
  }

  @override
  void onBind() {
    super.onBind();
    subscribe<void>(sendCode.stream, (_) => _sendCode());

    subscribe<String>(
      phoneController.stream,
      (phone) {
        if (phone?.length == formatPhoneLength) {
          final phoneError = validatePhoneNumber(phone);
          phoneValidState.accept(phoneError);
          canLoginState.accept(phoneError == null);
        } else {
          canLoginState.accept(false);
        }
      },
    );
    phoneFocusNode.addListener(_phoneFocusListener);
  }

  @override
  void dispose() {
    phoneFocusNode
      ..removeListener(_phoneFocusListener)
      ..dispose();
  }

  Future<void> _sendCode() async {
    await screenBehaviuorState.loading();

    // убираем лишнии символы из номера
    final phoneNumber = cleanPhoneNumber(phoneController.value);

    doFutureHandleError<void>(
      _authManager.sendCode(phoneNumber),
      (_) {
        AppMetrica.reportEvent('sms_code_sent');
        _navigator.pushReplacementNamed(AppRouter.confirmation,
            arguments: PhoneNumber(
              uiPhoneNumber: phoneController.value,
              validNumber: phoneNumber,
            ));
      },
      onError: (e) async {
        await screenBehaviuorState.error(e);
      },
    );
  }

  void _phoneFocusListener() {
    if (!phoneFocusNode.hasFocus) {
      final phoneError = validatePhoneNumber(phoneController.controller.text);
      phoneValidState.accept(phoneError);
      canLoginState.accept(phoneError == null);
    }
  }
}
