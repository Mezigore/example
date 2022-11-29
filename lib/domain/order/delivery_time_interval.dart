import 'package:uzhindoma/domain/order/time_interval.dart';

/// id временного интервала, верхняя и нижняя граница
class DeliveryTimeInterval {
  DeliveryTimeInterval({
    this.id,
    this.intervals,
  });

  /// Id временного интервала доставки
  final int id;

  final TimeInterval intervals;
}
