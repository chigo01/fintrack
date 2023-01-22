import 'package:intl/intl.dart';

class Money {
  Money._();

  static String format({required double value, required String symbol}) {
    return NumberFormat.currency(symbol: symbol, decimalDigits: 2)
        .format(value);
  }
}
