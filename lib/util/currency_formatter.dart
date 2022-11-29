import 'package:intl/intl.dart';

/// Возвращает форматированную валюту без копеек
String currencyFormatter(int price) {
  return NumberFormat.currency(
    locale: 'ru',
    decimalDigits: 0,
    customPattern: '#,### ',
  ).format(price);
}
