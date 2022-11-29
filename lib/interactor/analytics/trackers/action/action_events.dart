import 'package:uzhindoma/interactor/analytics/base/analytics_events.dart';

/// Тип событий Actions налитики
class ActionEvents extends AnalyticsEvents {
  const ActionEvents(String value) : super(value);

  /// тестовое действие
  static const doAction = ActionEvents('test_do_action');
}

// extension SubscribeInfoExt on SubscribeInfo {
//   /// данные для подписок
//   Map<String, Object> toEpisodeInfo() {
//     if (screenName == null) {
//       logger.i('screenName is null! '
//           'Wrap the screen widget to ScreenNameInherited');
//     }
//     return {
//       'episode_id': episodeId,
//       'is_successful': isSuccess,
//       'screen_name': screenName ?? unknown,
//     };
//   }
//
//   /// данные для подписок
//   Map<String, Object> toShowInfo() {
//     if (screenName == null) {
//       logger.i('screenName is null! '
//           'Wrap the screen widget to ScreenNameInherited');
//     }
//     return {
//       'show_id': showId,
//       'is_successful': isSuccess,
//       'screen_name': screenName ?? unknown,
//     };
//   }
// }
