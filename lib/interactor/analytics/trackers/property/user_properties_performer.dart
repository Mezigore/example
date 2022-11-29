import 'package:uzhindoma/interactor/analytics/analytics.dart';
import 'package:uzhindoma/interactor/analytics/base/analytics_service.dart';
import 'package:uzhindoma/interactor/analytics/base/base_performer.dart';
import 'package:uzhindoma/interactor/analytics/trackers/property/analytics_user_properties.dart';

/// Перформер для обработки событий аналитики [AnalyticsUserProperties]
class UserPropertiesPerformer extends BasePerformer<AnalyticsUserProperties> {
  UserPropertiesPerformer(Analytics analytics) : super(analytics);

  @override
  void perform(AnalyticsUserProperties action) {
    // ignore: avoid_function_literals_in_foreach_calls
    analytics.services.forEach((service) => _logProperty(service, action));
  }

  void _logProperty(AnalyticsService service, AnalyticsUserProperties action) {
    service.setUserProperty(name: action.name, value: action.value);
  }
}
