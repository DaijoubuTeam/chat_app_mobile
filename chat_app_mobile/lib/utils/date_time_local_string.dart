import 'package:intl/intl.dart';

class DateTimeLocalString {
  static String convertToHourMinute(DateTime time) {
    return DateFormat.jm().format(time.toLocal());
  }

  static String convertToDayMonthYear(DateTime time) {
    return DateFormat("dd/MM/yyyy").format(time.toLocal());
  }
}
