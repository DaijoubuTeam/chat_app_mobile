import 'package:intl/intl.dart';

class DateTimeLocalString {
  static String convertToHourMinute(DateTime time) {
    final checkToday = calculateDifference(time);
    if (checkToday == 0) {
      return DateFormat.jm().format(time.toLocal());
    } else if (checkToday == -1) {
      return "Yesterday";
    }
    return DateFormat("dd/MM/yyyy").format(time.toLocal());
  }

  static String convertToDayMonthYear(DateTime time) {
    return DateFormat("dd/MM/yyyy").format(time.toLocal());
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
