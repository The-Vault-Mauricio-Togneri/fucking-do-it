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
}
