import 'dart:developer';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:share_plus/share_plus.dart';
import 'package:surf_mwwm/surf_mwwm.dart';
import 'package:uzhindoma/domain/user/user_info.dart';
import 'package:uzhindoma/interactor/analytics/analytics_interactor.dart';
import 'package:uzhindoma/interactor/user/user_manager.dart';
import 'package:uzhindoma/ui/screen/profile/profile_screen.dart';

/// [WidgetModel] for [ProfileScreen]
class ProfileWidgetModel extends WidgetModel {
  ProfileWidgetModel(
    WidgetModelDependencies dependencies,
    this._navigator,
    this._userManager,
    this.scaffoldKey,
    this._analyticsInteractor,
  ) : super(dependencies);

  final GlobalKey<ScaffoldState> scaffoldKey;

  final NavigatorState _navigator;

  final UserManager _userManager;

  final AnalyticsInteractor _analyticsInteractor;

  /// Стрим с сотоянием пользователя
  EntityStreamedState<UserInfo> get userState => _userManager.userState;

  final onBackAction = Action<void>();

  final onReloadAction = Action<void>();

  final onShareButtonTap = Action<void>();

  @override
  void onLoad() {
    super.onLoad();
    _loadUserInfo();
  }

  @override
  void onBind() {
    super.onBind();
    bind<void>(
        onBackAction,
        (_) => _navigator.canPop()
            ? _navigator.pop()
            : _navigator.pushReplacementNamed('/'));
    bind<void>(onShareButtonTap, (_) => _onShareButtonTap());
    subscribe<void>(onReloadAction.stream, (_) => _loadUserInfo());
  }

  Future<void> _loadUserInfo() async {
    await _userManager.loadUserInfo();
  }

  void _onShareButtonTap() {
    log('tap');
    AppMetrica.reportEvent('bonus_click');
    _analyticsInteractor.events.trackBonusButtonClick();
    final link = userState.value.data.referral;
    Share.share(
        'Попробуй Ужин Дома. С этим набором ты приготовишь пять ужинов на 2 персоны всего за 1980 рублей. Каждый вечер - новый ужин. Будет вкусно, обещаю!)\n$link',
        subject: 'Ужин Дома');
  }
}
