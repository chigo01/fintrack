import 'package:intl/intl.dart';

class Money {
  Money._();

  static String format({required double value, required String symbol}) {
    return NumberFormat.currency(symbol: symbol, decimalDigits: 2)
        .format(value);
  }

  static String percentage(
      {required double amount, required double totalAmount}) {
    return '${(amount / totalAmount * 100).toStringAsFixed(1)}%';
  }
}
