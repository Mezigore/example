import 'package:flutter/material.dart';
import 'package:uzhindoma/config/build_types.dart';
import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';
import 'package:uzhindoma/domain/debug_options.dart';
import 'package:uzhindoma/interactor/common/urls.dart';
import 'package:uzhindoma/runner/runner.dart';


//Main entry point of app
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Environment.init(
    buildType: BuildType.qa,
    config: Config(
      url: Url.testUrl,
      proxyUrl: Url.qaProxyUrl,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
        debugUseMocker: true,
      ),
    ),
  );

  run();
}
