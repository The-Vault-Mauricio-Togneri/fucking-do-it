import 'package:fucking_do_it/utils/localizations.dart';
import 'package:intl/intl.dart';

class Formatter {
  static const String TIMESTAMP_FORMAT = 'yyyy-MM-dd';
  static const String TIMESTAMP_FORMAT_REVERSED = 'dd-MM-yyyy';

  static String dayLongMonthMonthYear(DateTime dateTime) =>
      DateFormat.yMMMd(Localized.current.languageCode).format(dateTime);

  static String deltaDate(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = dateTime.difference(today);
    String delta = '';

    if (difference.inDays > 0) {
      delta = Localized.get.labelDeltaDaysFuture(difference.inDays.toString());
    } else if (difference.inDays == 0) {
      delta = Localized.get.labelDeltaToday.toLowerCase();
    } else {
      delta =
          Localized.get.labelDeltaDaysPast(difference.inDays.abs().toString());
    }

    return delta;
  }

  static String deltaTime(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Duration difference = dateTime.difference(today);
    String delta = '';

    if (difference.inDays > 0) {
      delta = Localized.get.labelDeltaDaysFuture(difference.inDays.toString());
    } else if (difference.inDays == 0) {
      delta = Localized.get.labelDeltaToday.toLowerCase();
    } else {
      delta =
          Localized.get.labelDeltaDaysPast(difference.inDays.abs().toString());
    }

    return delta;
  }
}
