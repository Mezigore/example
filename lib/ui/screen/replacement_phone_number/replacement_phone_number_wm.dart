import 'package:flutter/widgets.dart' as widget/* hide Action*/;
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/phone_number.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/screen/replacement_phone_number/replacement_phone_number_screen.dart';
import 'package:uzhindoma/util/clean_phone_number.dart';
import 'package:uzhindoma/util/validate_data.dart';

/// [WidgetModel] for [ReplacementPhoneNumberScreen]
class ReplacementPhoneNumberWidgetModel extends WidgetModel {
  ReplacementPhoneNumberWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
  ) : super(dependencies);

  final UserManager _userManager;

  final widget.NavigatorState _navigator;

  /// Вернуть на предыдущий экран
  final onBackAction = Action<void>();

  /// Контроллер
  final phoneController = TextEditingAction();
  // final phoneController = TextEditingController();
  final phoneFocusNode = widget.FocusNode();

  /// Состояние кнопки Далее
  final validState = StreamedState<String>();

  /// Состояние кнопки Далее
  final acceptButtonState = StreamedState<bool>();

  /// Проверить номер
  final onAcceptButtonAction = Action<void>();

  /// Состояние экрана
  final screenBehaviuorState = StreamedState<EntityState<void>>();

  @override
  void onBind() {
    super.onBind();
    bind<void>(onBackAction, (_) => _navigator.pop());
    subscribe<String>(
      phoneController.stream,
      (phone) {
        if (phone?.length == formatPhoneLength) {
          final phoneError = validatePhoneNumber(phone);
          validState.accept(phoneError);
          acceptButtonState.accept(phoneError == null);
        } else {
          acceptButtonState.accept(false);
        }
      },
    );
    phoneFocusNode.addListener(_phoneFocusListener);
    bind<void>(onAcceptButtonAction, (_) => _changePhone());
  }

  @override
  void onLoad() {
    super.onLoad();
    screenBehaviuorState.accept(EntityState.content());
  }

  void _phoneFocusListener() {
    if (!phoneFocusNode.hasFocus) {
      final phoneError = validatePhoneNumber(phoneController.controller.text);
      validState.accept(phoneError);
      acceptButtonState.accept(phoneError == null);
    }
  }

  void _changePhone() {
    // убираем лишнии символы из номера
    final String phoneNumber = cleanPhoneNumber(
      phoneController.controller.text,
    );
    doFutureHandleError<void>(
      _userManager.changePhone(phoneNumber),
      (_) => _navigator.pushReplacementNamed(
        AppRouter.confirmationReplacementPhoneNumberScreen,
        arguments: PhoneNumber(
          uiPhoneNumber: phoneController.value,
          validNumber: phoneNumber,
        ),
      ),
      onError: (e) => screenBehaviuorState.accept(EntityState.error(e)),
    );
  }
}
