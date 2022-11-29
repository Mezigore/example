import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:surf_logger/surf_logger.dart';
import 'package:uzhindoma/config/build_types.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/ui/app/app.dart';
import 'package:uzhindoma/ui/res/locale.dart';
import 'package:uzhindoma/util/crashlytics_strategy.dart';

Future<void> run() async {
  // Нужно вызывать чтобы не падало проставление ориентации
  WidgetsFlutterBinding.ensureInitialized();
  // закрепляем ориентацию
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Должен вызываться до любого использования
  await Firebase.initializeApp();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  log(
      'FCM TOKEN : ${await messaging.getToken()}');

  final NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('User granted provisional permission');
  } else {
    log('User declined or has not accepted permission');
  }

  Intl.defaultLocale = rusLocale.toLanguageTag();
  await _initCrashlytics();
  _initLogger();
  _runApp();
}

void _runApp() {
  runZonedGuarded<Future<void>>(
    () async {
      runApp(App());
    },
    FirebaseCrashlytics.instance.recordError,
  );
}

Future<void> _initCrashlytics() async {
  // Выключаем Crashlytics для debug
  if (Environment<Config>.instance().buildType == BuildType.debug) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

void _initLogger() {
  RemoteLogger.addStrategy(CrashlyticsRemoteLogStrategy());
  Logger.addStrategy(DebugLogStrategy());
  Logger.addStrategy(RemoteLogStrategy());
}
