import 'package:uzhindoma/ui/res/strings/common_strings.dart';
import 'package:uzhindoma/util/const.dart';

/// Удаляет из номера все символы, кроме чисел и приводит номер к формату +7
String cleanPhoneNumber(String number) {
  final rawPhoneNumber = number.replaceAll(
    RegExp(r'(\D)'),
    emptyString,
  );
  final phoneNumber = '$prefixPhoneNumberText$rawPhoneNumber';
  return phoneNumber;
}
