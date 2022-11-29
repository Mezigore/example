import 'dart:developer';

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
// import 'package:appmetrica_push/appmetrica_push.dart';
// import 'package:appmetrica_push_plugin/appmetrica_push_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:uzhindoma/config/build_types.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/domain/debug_options.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/runner/runner.dart';


/// Initializing the AppMetrica SDK.
AppMetricaConfig get _config =>
    const AppMetricaConfig('ac0caca9-ad11-4ef0-befc-66908170a452', logs: true);


//Main entry point of app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppMetrica.activate(_config);
  // await AppmetricaPush.instance.activate();
  // AppmetricaPush.instance.onMessageOpenedApp
  //     .listen((data) => log(' $data', name: 'onMessageOpenedApp:'));
  // await AppMetricaPush.activate();
  // await AppMetricaPush.requestPermission(alert: true, badge: true, sound: true);
  // AppMetricaPush.tokenStream.listen((tokens) {
  //   log(tokens.toString(), name: 'tokens');
  // });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Environment.init(
    buildType: BuildType.release,
    config: Config(
      url: Url.prodUrl,
      proxyUrl: Url.prodProxyUrl,
      debugOptions: DebugOptions(),
    ),
  );


  await run();
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log(message.data.toString(), name: 'firebaseMessagingBackgroundHandler data');
  // log(message.category.toString(), name: 'category');
  // log(message.collapseKey.toString(), name: 'collapseKey');
  // log(message.contentAvailable.toString(), name: 'contentAvailable');
  // log(message.from.toString(), name: 'from');
  // log(message.messageId.toString(), name: 'messageId');
  // log(message.messageType.toString(), name: 'messageType');
  // log(message.mutableContent.toString(), name: 'mutableContent');
  // log(message.senderId.toString(), name: 'senderId');
  log(message.notification.body.toString(), name: 'notification.body');
}