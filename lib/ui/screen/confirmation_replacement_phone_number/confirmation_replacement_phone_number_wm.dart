import 'dart:async';

import 'package:flutter/widgets.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/screen/confirmation_replacement_phone_number/confirmation_replacement_phone_number_screen.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// [WidgetModel] for [ConfirmationReplacementPhoneNumberScreen]
class ConfirmationReplacementPhoneNumberWidgetModel extends WidgetModel {
  ConfirmationReplacementPhoneNumberWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator, {
    @required PhoneNumber phoneNumber,
    @required UserManager userManager,
  })  : assert(phoneNumber != null),
        assert(userManager != null),
        _userManager = userManager,
        _phoneNumber = phoneNumber,
        super(dependencies);

  final PhoneNumber _phoneNumber;

  final UserManager _userManager;

  /// Блокируем отправка
  final isRequestLockedState = surf_mwwm.StreamedState<bool>();

  /// Стрим введённого кода
  final codeState = surf_mwwm.StreamedState<String>();

  /// Стрим для оставшегося времени в виде строки
  final timerLockedState = surf_mwwm.StreamedState<String>();

  /// Переотправить запрос на новый код
  final requestAgainAction = surf_mwwm.Action<void>();

  /// Сменить номер. Роут на экран Auth
  final changeNumberAction = surf_mwwm.Action<void>();

  final onBackAction = surf_mwwm.Action<void>();

  /// Для прослушивания ввода
  final textFieldController = surf_mwwm.TextEditingAction();

  /// Состояние экрана
  final screenBehaviuorState = surf_mwwm.StreamedState<surf_mwwm.EntityState<void>>();

  surf_mwwm.EntityStreamedState<UserInfo> get userState => _userManager.userState;

  String get phoneNumber =>
      '$prefixPhoneNumberText ${_phoneNumber.uiPhoneNumber}';

  final NavigatorState _navigator;

  /// Таймер для отсчета времени для следующего запроса
  Timer _timer;

  surf_mwwm.StreamedState<DateTime> get changePhoneRequestLockedState =>
      _userManager.changePhoneRequestLockedState;

  @override
  void onLoad() {
    super.onLoad();
    screenBehaviuorState.accept(surf_mwwm.EntityState.content());
  }

  @override
  void onBind() {
    super.onBind();
    subscribe<String>(textFieldController.stream, _handleCode);
    bind<void>(onBackAction, (_) => _navigator.pop());
    bind<void>(requestAgainAction, (_) => _requestAgainCode());
    bind<void>(
      changeNumberAction,
      (_) => _openScreen(AppRouter.replacementPhoneNumber),
    );

    subscribe<DateTime>(
      changePhoneRequestLockedState.stream,
      _handleLock,
    );
  }

  void _handleCode(String code) {
    codeState.accept(code);
    if (code.length == 4 && !screenBehaviuorState.value.isLoading) {
      screenBehaviuorState.accept(surf_mwwm.EntityState.loading());
      doFutureHandleError<void>(
        _userManager.confirmChangePhone(
          code,
          _phoneNumber.validNumber,
        ),
        (_) => _navigator.pop(),
        onError: (e) => screenBehaviuorState.accept(surf_mwwm.EntityState.error(e)),
      );
    }
  }

  void _handleLock(DateTime dateTime) {
    if (dateTime == null) {
      return;
    }
    final now = DateTime.now();
    final duration = dateTime.difference(now);
    _runTimer(duration.inSeconds.abs());
  }

  void _runTimer(int seconds) {
    int _seconds = seconds;
    _timer?.cancel();
    timerLockedState.accept(formatSecondsToString(_seconds));
    isRequestLockedState.accept(true);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _seconds -= 1;
        timerLockedState.accept(formatSecondsToString(_seconds));
        if (_seconds <= 0) {
          timer?.cancel();
          isRequestLockedState.accept(false);
          timerLockedState.accept(null);
        }
      },
    );
  }

  void _openScreen(String routeName) =>
      _navigator.pushReplacementNamed(routeName);

  void _requestAgainCode() {
    textFieldController.controller.text = emptyString;
    screenBehaviuorState.accept(surf_mwwm.EntityState.loading());
    doFutureHandleError<void>(
      _userManager.changePhone(_phoneNumber.validNumber),
      (_) => screenBehaviuorState.accept(surf_mwwm.EntityState.content()),
      onError: (e) => screenBehaviuorState.accept(surf_mwwm.EntityState.error(e)),
    );
  }
}
