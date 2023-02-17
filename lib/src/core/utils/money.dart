import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/utils/extension.dart';
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

class TotalCalculation {
  static double getTotalOfWeekPerMonth(
    int day,
    List<Transaction>? transaction,
  ) {
    List<double> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.month == DateTime.now().month)
          .where((element) =>
              DateTime.utc(
                element.date.year,
                element.date.month,
                element.date.day,
              ).day ==
              day)
          .map(
            (e) => e.amount,
          )
          .toList();
    }
    if (trans.isNotEmpty) {
      return trans.reduce(
        (value, element) => element + value,
      );
    } else {
      return 100;
    }
  }

  static double getTotalOfDayPerWeek(int day, List<Transaction>? transaction) {
    List<double> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) =>
              element.date.weekOfMonth == DateTime.now().weekOfMonth)
          .where((element) =>
              DateTime.utc(
                element.date.year,
                element.date.month,
                element.date.day,
              ).weekday ==
              day)
          .map(
            (e) => e.amount,
          )
          .toList();
    }
    if (trans.isNotEmpty) {
      return trans.reduce(
        (value, element) => element + value,
      );
    } else {
      return 100;
    }
  }

  static double getTotalOfMonthPerYear(
      int day, List<Transaction>? transaction) {
    List<double> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.month == DateTime.now().month)
          .where((element) =>
              DateTime.utc(
                element.date.year,
                element.date.month,
                element.date.day,
              ).month ==
              day)
          .map(
            (e) => e.amount,
          )
          .toList();
    }
    if (trans.isNotEmpty) {
      return trans.reduce(
        (value, element) => element + value,
      );
    } else {
      return 100;
    }
  }

  static double getTotalByDay(int day, List<Transaction>? transaction) {
    List<double> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.day == DateTime.now().day)
          .where((element) =>
              DateTime.utc(
                    element.date.year,
                    element.date.month,
                    element.date.day,
                    element.date.hour,
                  ).hour +
                  1 ==
              day)
          .map(
            (e) => e.amount,
          )
          .toList();
    }
    if (trans.isNotEmpty) {
      return trans.reduce(
        (value, element) => element + value,
      );
    } else {
      return 100;
    }
  }
}

class TransactionPerTime {
  List<Transaction> getTransactionByDay(
    List<Transaction>? transaction,
  ) {
    List<Transaction> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.day == DateTime.now().day)
          .toList();
    }
    return trans;
  }

  List<Transaction> getTransactionByWeek(List<Transaction>? transaction) {
    List<Transaction> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) =>
              element.date.weekOfMonth == DateTime.now().weekOfMonth)
          .toList();
    }
    return trans;
  }

  List<Transaction> getTransactionByMonth(List<Transaction>? transaction) {
    List<Transaction> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.month == DateTime.now().month)
          .toList();
    }
    return trans;
  }

  List<Transaction> getTransactionByYear(List<Transaction>? transaction) {
    List<Transaction> trans = [];
    if (transaction != null) {
      trans = transaction
          .where((element) => element.date.year == DateTime.now().year)
          .toList();
    }
    return trans;
  }
}
