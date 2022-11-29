import 'dart:async';

// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:mwwm/mwwm.dart';
import 'package:surf_mwwm/surf_mwwm.dart' as surf_mwwm;
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/interactor/auth/auth_manager.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/screen/confirmation/confirmation_screen.dart';
import 'package:uzhindoma/util/const.dart';
import 'package:uzhindoma/util/date_formatter.dart';

/// [WidgetModel] for [ConfirmationScreen]
class ConfirmationWidgetModel extends WidgetModel {
  ConfirmationWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this.scaffoldKey, {
    @required PhoneNumber phoneNumber,
    @required AuthManager authManager,
    @required UserManager userManager,
  })  : _phoneNumber = phoneNumber,
        _authManager = authManager,
        _userManager = userManager,
        assert(phoneNumber != null),
        super(dependencies);

  final PhoneNumber _phoneNumber;
  final AuthManager _authManager;
  final UserManager _userManager;
  final GlobalKey<ScaffoldState> scaffoldKey;

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

  /// Для прослушивания ввода
  final textFieldController = surf_mwwm.TextEditingAction();

  /// Состояние экрана
  final screenBehaviorState = surf_mwwm.EntityStreamedState<void>();

  String get phoneNumber =>
      '$prefixPhoneNumberText ${_phoneNumber.uiPhoneNumber}';

  final NavigatorState _navigator;

  /// Таймер для отсчета времени для следующего запроса
  Timer _timer;

  @override
  void onLoad() {
    super.onLoad();
    screenBehaviorState.content();
    isRequestLockedState.accept(false);
  }

  @override
  void onBind() {
    super.onBind();
    subscribe<String>(textFieldController.stream, _handleCode);
    subscribe<void>(requestAgainAction.stream, (_) => _requestAgainCode());
    subscribe<void>(
      changeNumberAction.stream,
      (_) => _openScreen(AppRouter.authScreen),
    );
    subscribe<DateTime>(
      _authManager.requestCodeLockedState.stream,
      _handleLock,
    );
  }

  void _handleCode(String code) {
    codeState.accept(code);

    /// Сброс состояния ошибки после ввода нового кода
    if (code.isNotEmpty && (screenBehaviorState.value?.hasError ?? true)) {
      screenBehaviorState.content();
    }

    /// Отправка кода
    if (code.length == 4 && !screenBehaviorState.value.isLoading) {
      screenBehaviorState.loading();
      doFutureHandleError<void>(
        _authManager.checkCode(
          _phoneNumber.validNumber,
          code,
        ),
        (_) {
          doFutureHandleError<void>(
            _userManager.loadUserInfo(),
            (_) {
              final isNew = _userManager.userState.value?.data?.isNew ?? false;
              AppMetrica.reportEventWithMap(
                  'auth_success', <String, bool>{'is_new': isNew});
              _authManager.reportEventAuthSuccess();
            },
            onError: (_) {},
          );
          _openScreen(AppRouter.root);
        },
        onError: (e) {
          textFieldController.controller.text = emptyString;
          return screenBehaviorState.error();
        },
      );
    }
  }

  void _requestAgainCode() {
    textFieldController.controller.text = emptyString;
    screenBehaviorState.accept(surf_mwwm.EntityState.loading());
    doFutureHandleError<void>(
      _authManager.sendCode(_phoneNumber.validNumber),
      (_) => screenBehaviorState.content(),
      onError: (e) {
        if (e is DioError &&
            (e.type == DioErrorType.connectTimeout ||
                e.type == DioErrorType.receiveTimeout ||
                e.type == DioErrorType.other)) {
          //Достаточно снека
          screenBehaviorState.content();
        } else {
          return screenBehaviorState.error(e);
        }
      },
    );
  }

  void _handleLock(DateTime dateTime) {
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
}
