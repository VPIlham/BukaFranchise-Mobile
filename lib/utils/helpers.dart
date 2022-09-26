import 'dart:math';

import 'package:intl/intl.dart';

double truncateToDecimalPlaces(num value, int fractionalDigits) =>
    (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);

String kmbGenerator(num value, {bool idr = false}) {
  var num = double.parse(value.toString());
  if (num < 1) {
    if (num > 0) {
      return truncateToDecimalPlaces(num, 2).toString();
    } else {
      return truncateToDecimalPlaces(num, 2).toString();
    }
  } else {
    int? getDecimal = int.tryParse((num.toString().split('.')[1]));
    if (getDecimal != null) {
      if (getDecimal > 0) {
        return NumberFormat.currency(
                locale: 'eu', symbol: "", decimalDigits: idr ? 0 : 2)
            .format(double.parse(
                truncateToDecimalPlaces(num, idr ? 0 : 2).toString()));
      } else {
        return NumberFormat.currency(locale: 'eu', symbol: "", decimalDigits: 0)
            .format(double.parse(truncateToDecimalPlaces(num, 0).toString()));
      }
    } else {
      return NumberFormat.currency(locale: 'eu', symbol: "", decimalDigits: 0)
          .format(double.parse(truncateToDecimalPlaces(num, 0).toString()));
    }
  }
}
