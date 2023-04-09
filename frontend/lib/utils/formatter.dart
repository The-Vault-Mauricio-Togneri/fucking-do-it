import 'package:fucking_do_it/utils/localizations.dart';
import 'package:intl/intl.dart';

class Formatter {
  static const String TIMESTAMP_FORMAT = 'yyyy-MM-dd';
  static const String TIMESTAMP_FORMAT_REVERSED = 'dd-MM-yyyy';

  static String dayLongMonthMonthYear(DateTime dateTime) =>
      DateFormat.yMMMd(Localized.current.languageCode).format(dateTime);
      
  static String hoursMinutes(DateTime dateTime) =>
      DateFormat.Hm(Localized.current.languageCode).format(dateTime);

  static String fullDateTime(DateTime dateTime) {
    final String date = dayLongMonthMonthYear(dateTime);
    final String time = hoursMinutes(dateTime);

    return '$date $time';
  }

  static String deltaDate(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = dateTime.difference(today);

    if (difference.inDays > 0) {
      return Localized.get.labelDeltaDaysFuture(difference.inDays.toString());
    } else if (difference.inDays == 0) {
      return Localized.get.labelDeltaToday.toLowerCase();
    } else {
      return Localized.get
          .labelDeltaDaysPast(difference.inDays.abs().toString());
    }
  }

  static String deltaTime(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return Localized.get.labelDeltaDaysPast(difference.inDays.toString());
    } else if (difference.inHours > 0) {
      return Localized.get.labelDeltaHoursPast(difference.inHours.toString());
    } else {
      return Localized.get
          .labelDeltaMinutesPast(difference.inMinutes.toString());
    }
  }
}
