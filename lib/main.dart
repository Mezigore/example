// import 'package:appmetrica_sdk/appmetrica_sdk.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:uzhindoma/config/build_types.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/domain/debug_options.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/runner/runner.dart';

/// Initializing the AppMetrica SDK.
AppMetricaConfig get _config =>
    const AppMetricaConfig('ac0caca9-ad11-4ef0-befc-66908170a452', logs: false);

//Main entry point of app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppMetrica.activate(_config);

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
