import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/domain/order/delivery_time_interval.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/date_chip.dart';

/// Список интервалов времени
class IntervalsList extends StatelessWidget {
  const IntervalsList({
    Key key,
    this.date,
    this.currentInterval,
    this.onIntervalTap,
  }) : super(key: key);

  final DeliveryDate date;
  final DeliveryTimeInterval currentInterval;
  final ValueChanged<DeliveryTimeInterval> onIntervalTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10.0,
      spacing: 15.0,
      children: date.time.map(
        (time) {
          return DateChip(
            label: time.intervals.title,
            isSelected: currentInterval?.id == time.id,
            onTap: () => onIntervalTap(time),
          );
        },
      ).toList(),
    );
  }
}
