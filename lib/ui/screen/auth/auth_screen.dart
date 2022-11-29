import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:surf_injector/surf_injector.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/ui/common/widgets/accept_button.dart';
import 'package:uzhindoma/ui/common/widgets/input/phone_input.dart';
import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';
import 'package:uzhindoma/ui/res/text_styles.dart';
import 'package:uzhindoma/ui/screen/auth/auth_wm.dart';
import 'package:uzhindoma/ui/screen/auth/di/auth_component.dart';
import 'package:uzhindoma/ui/widget/logo/logo.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: prefer_mixin

/// Screen [AuthScreen]
class AuthScreen extends MwwmWidget<AuthComponent> {
  AuthScreen({
    Key key,
  }) : super(
          key: key,
          widgetModelBuilder: createAuthWidgetModel,
          dependenciesBuilder: (context) => AuthComponent(context),
          widgetStateBuilder: () => _AuthScreenState(),
        );
}

class _AuthScreenState extends WidgetState<AuthWidgetModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Injector.of<AuthComponent>(context).component.scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: StreamedStateBuilder<EntityState<void>>(
            streamedState: wm.screenBehaviuorState,
            builder: (context, state) {
              return StreamedStateBuilder<void>(
                streamedState: wm.phoneValidState,
                builder: (_, __) => _ContentAuthWidget(
                  controller: wm.phoneController.controller,
                  sendCode: wm.sendCode,
                  phoneValidState: wm.phoneValidState,
                  canLoginState: wm.canLoginState,
                  focus: wm.phoneFocusNode,
                  state: state,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContentAuthWidget extends StatefulWidget {
  const _ContentAuthWidget({
    Key key,
    @required this.controller,
    @required this.sendCode,
    @required this.phoneValidState,
    @required this.canLoginState,
    this.state,
    this.focus,
  }) : super(key: key);

  final EntityState<void> state;

  final TextEditingController controller;

  final FocusNode focus;

  final Action<void> sendCode;

  final StreamedState<String> phoneValidState;
  final StreamedState<bool> canLoginState;

  @override
  __ContentAuthWidgetState createState() => __ContentAuthWidgetState();
}

class __ContentAuthWidgetState extends State<_ContentAuthWidget>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  String get errorText {
    if (widget.phoneValidState.value != null) {
      return widget.phoneValidState.value;
    }
    if (widget.state.hasError) {
      if (widget.state.error.e != null) {
        if (widget.state.error.e is DioError &&
            (widget.state.error.e.type == DioErrorType.connectTimeout ||
                widget.state.error.e.type == DioErrorType.receiveTimeout ||
                widget.state.error.e.type == DioErrorType.other)) {
          return noInternetConnectionErrorMessage;
        }
      }
      return authScreenAcceptExceedTheNumberOfAttemptsErrorText;
    }
    return authScreenAcceptEnterNumberPhoneErrorText;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (WidgetsBinding.instance.window.viewInsets.bottom > 0) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 20),
            curve: Curves.easeOutCubic,
          );
        }
      },
    );
  }

  Future<void> _openBrowser(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      shrinkWrap: true,
      slivers: [
        const SliverToBoxAdapter(child: LogoWidget()),
        SliverToBoxAdapter(
          child: Text(
            authScreenEnterText,
            style: textMedium32,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Text(
              errorText,
              style:
              widget.state.hasError || widget.phoneValidState.value != null
                  ? textRegular12Error
                  : textRegular12,
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
          child: PhoneInput(
            controller: widget.controller,
            isEnable: !widget.state.isLoading,
            validState: widget.phoneValidState,
            focusNode: widget.focus,
            isValid: widget.state.hasError ? false : null,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: authScreenPolitics,
                  style: textRegular12Secondary,
                ),
                TextSpan(
                  style: textRegular12SecondaryUnderline,
                  text: authScreenPoliticsButtonUrlString,
                  recognizer: TapGestureRecognizer()
                    ..onTap = ()  {
                      _openBrowser('https://uzhindoma.ru/user-agreement/');
                    },
                ),
              ],
            ),
            ),
          ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: StreamedStateBuilder<bool>(
              streamedState: widget.canLoginState,
              builder: (context, canLogin) {
                return widget.state.isLoading
                    ? const AcceptButton(
                        padding: EdgeInsets.zero,
                        text: authScreenAcceptButtonText,
                        isLoad: true,
                      )
                    : AcceptButton(
                        padding: EdgeInsets.zero,
                        callback: canLogin ? widget.sendCode : null,
                        text: authScreenAcceptButtonText,
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
