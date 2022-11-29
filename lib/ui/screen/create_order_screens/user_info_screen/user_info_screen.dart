import 'package:flutter/material.dart';
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/default_app_bar.dart';
import 'package:uzhindoma/ui/common/widgets/input/email_input.dart';
import 'package:uzhindoma/ui/res/colors.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/user_info_screen/di/user_info_screen_component.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/user_info_screen/user_info_screen_wm.dart';
import 'package:uzhindoma/util/const.dart';

/// Экран ввода данных пользователя для заказа
class UserInfoScreen extends MwwmWidget<UserInfoScreenComponent> {
  UserInfoScreen({Key key})
      : super(
          widgetModelBuilder: createUserInfoScreenWidgetModel,
          dependenciesBuilder: (context) => UserInfoScreenComponent(context),
          widgetStateBuilder: () => _UserInfoScreenState(),
          key: key,
        );
}

class _UserInfoScreenState extends WidgetState<UserInfoScreenWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        wm.cancelOrderAction();
        return Future.value(false);
      },
      child: Scaffold(
        key:
            Injector.of<UserInfoScreenComponent>(context).component.scaffoldKey,
        appBar: DefaultAppBar(
          title: createOrderTitle,
          leadingIcon: Icons.close,
          onLeadingTap: wm.cancelOrderAction,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: wm.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: StreamedStateBuilder<AutovalidateMode>(
                    streamedState: wm.autovalidateModeState,
                    builder: (context, state) {
                      return Form(
                        key: wm.formKey,
                        autovalidateMode: state,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 32),
                            Text(createOrderClientTitle, style: textMedium24),
                            const SizedBox(height: 8),
                            Text(createOrderUserInfoDescription,
                                style: textRegular14Secondary),
                            const SizedBox(height: 24),
                            _TextField(
                              validator: wm.validateField,
                              controller: wm.nameController.controller,
                              focusNode: wm.nameFocusNode,
                              keyboardType: TextInputType.name,
                              autoFillHint: AutofillHints.name,
                              label: userDetailsWidgetNameText,
                            ),
                            const SizedBox(height: 16),
                            _TextField(
                              validator: wm.validateField,
                              controller: wm.lastNameController.controller,
                              focusNode: wm.lastNameFocusNode,
                              keyboardType: TextInputType.name,
                              autoFillHint: AutofillHints.familyName,
                              label: userDetailsWidgetSurnameText,
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: wm.onChangePhoneAction,
                              child: _TextField(
                                isEnable: false,
                                controller: wm.phoneController.controller,
                                label: userDetailsWidgetPhoneText,
                                suffixIcon: Icons.arrow_forward_ios,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                createOrderPhoneTitle,
                                style: textRegular12Secondary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            EmailEditText(
                              controller: wm.emailController.controller,
                              focusNode: wm.emailFocusNode,
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                createOrderEmailTitle,
                                style: textRegular12Secondary,
                              ),
                            ),
                            const SizedBox(height: 150),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              StreamedStateBuilder<bool>(
                streamedState: wm.keyBoardOnScreenState,
                builder: (_, isKeyboardOnScreen) {
                  if (isKeyboardOnScreen) return const SizedBox.shrink();
                  return AcceptButton(
                    callback: wm.nextAction,
                    text: createOrderBtnNextTitle,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key key,
    this.controller,
    this.focusNode,
    this.label,
    this.autoFillHint,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.isEnable,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final String autoFillHint;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isEnable;
  final IconData suffixIcon;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextFormField(
        validator: validator,
        enabled: isEnable,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        autofillHints: (isEnable ?? true) ? [autoFillHint] : null,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          enabled: isEnable ?? true,
          filled: true,
          counterText: emptyString,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          labelText: label,
          errorStyle: textRegular12Error.copyWith(height: 0),
          errorMaxLines: 2,
          fillColor: textFormFieldFillColor,
          suffixIcon: suffixIcon == null
              ? null
              : Icon(
                  suffixIcon,
                  size: 16,
                  color: iconColor40o,
                ),
        ),
      ),
    );
  }
}
