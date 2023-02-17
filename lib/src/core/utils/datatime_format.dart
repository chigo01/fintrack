import 'package:intl/intl.dart';

class DateTimeFormatter {
  DateTimeFormatter();
  //a private constructor
  // DateTimeFormatter._(String pattern) : _pattern = DateFormat(pattern);

  // DateFormat _pattern;

  String dateToString(DateTime date) {
    return DateFormat.yMd().format(date);
  }

  String timeToString(DateTime time) {
    return DateFormat.jm().format(time);
  }

  String transDateToString(DateTime transDate) {
    return DateFormat('d MMM').format(transDate);
  }

  String transWeekToString(DateTime transDate) {
    return DateFormat("EEE, d MMM").format(transDate);
  }
}
