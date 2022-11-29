import 'package:flutter/material.dart';

/// Модель для номера версии приложения
class AppVersion {
  AppVersion({
    @required this.appStore,
    @required this.playMarket,
  })  : assert(appStore != null),
        assert(playMarket != null);

  final String appStore;
  final String playMarket;

  AppVersion copyWith({
    String appStore,
    String playMarket,
  }) =>
      AppVersion(
        appStore: appStore ?? this.appStore,
        playMarket: playMarket ?? this.playMarket,
      );
}
