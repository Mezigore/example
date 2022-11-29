import 'package:uzhindoma/config/config.dart';
import 'package:uzhindoma/config/env/env.dart';

/// Интерактор для работы с <DebugScreen>
class DebugScreenInteractor {
  DebugScreenInteractor();

  void showDebugScreenNotification() {
    if (Environment<Config>.instance().isDebug) {
      // ignore: avoid_print
      print('Open debug screen');
    }
  }
}
