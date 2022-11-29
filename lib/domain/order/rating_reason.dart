import 'package:uzhindoma/interactor/common/exceptions.dart';
import 'package:uzhindoma/ui/res/strings/strings.dart';

/// Причины низкой оценки блюда
enum RatingReason {
  cooking,
  other,
  quality,
  taste,
}

extension RatingReasonExt on RatingReason {
  /// Заголовок
  String get title {
    switch (this) {
      case RatingReason.cooking:
        return rateLowCooking;
      case RatingReason.other:
        return rateLowOther;
      case RatingReason.quality:
        return rateLowQuality;
      case RatingReason.taste:
        return rateLowTaste;
      default:
        throw EnumArgumentException('Not found RatingReason for $this');
    }
  }
}
