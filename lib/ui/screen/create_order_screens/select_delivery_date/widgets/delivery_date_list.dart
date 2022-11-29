import 'package:flutter/material.dart';
import 'package:uzhindoma/domain/order/delivery_date.dart';
import 'package:uzhindoma/ui/screen/create_order_screens/select_delivery_date/widgets/date_chip.dart';

/// Списко дат возможной доставки
class DeliveryDateList extends StatelessWidget {
  const DeliveryDateList({
    Key key,
    this.listOfDates,
    this.currentDate,
    this.onDateTap,
  }) : super(key: key);

  final List<DeliveryDate> listOfDates;
  final DeliveryDate currentDate;
  final ValueChanged<DeliveryDate> onDateTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10.0,
      spacing: 15.0,
      children: listOfDates.map(
        (date) {
          return DateChip(
            label: date.dateTitle,
            isSelected: currentDate?.date == date.date,
            onTap: () => onDateTap(date),
          );
        },
      ).toList(),
    );
  }
}
