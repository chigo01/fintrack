import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double getHeight([double height = 1]) {
    assert(height != 0);
    return MediaQuery.of(this).size.height * height;
  }

  double getWidth([double width = 1]) {
    assert(width != 0);
    return MediaQuery.of(this).size.width * width;
  }

  double get height => getHeight();
  double get width => getWidth();
}

extension WidgetExtension on Widget {
  GestureDetector onTap(VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: this,
    );
  }
}

extension ColorExtension on bool {
  Color get color => this
      ? const Color(0xff1f3341).withOpacity(0.45)
      : Colors.black.withOpacity(0.1);
}

extension StringExtension on String {
  String get capitalized =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}
