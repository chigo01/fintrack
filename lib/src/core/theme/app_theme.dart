import 'package:fintrack/src/core/theme/app_color.dart';
import 'package:fintrack/src/core/theme/textstyle.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final AppTextStyle _textStyle = AppTextStyle.instance;

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: AppColor.secondaryColors[1].withOpacity(0.2),
      elevation: 3,
    ),
    textTheme: TextTheme(
      displayLarge: _textStyle.displayLarge,
      displayMedium: _textStyle.displayMedium,
      displaySmall: _textStyle.displaySmall,
      headlineLarge: _textStyle.headlineLarge,
      headlineMedium: _textStyle.headlineMedium,
      headlineSmall: _textStyle.headlineSmall,
      titleLarge: _textStyle.titleLarge,
      titleSmall: _textStyle.titleSmall,
      titleMedium: _textStyle.titleMedium,
      labelLarge: _textStyle.labelLarge,
      labelMedium: _textStyle.labelMedium,
      labelSmall: _textStyle.labelSmall,
      bodyLarge: _textStyle.bodyLarge,
      bodyMedium: _textStyle.bodyMedium,
      bodySmall: _textStyle.bodySmall,
    ),
  );

  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    // backgroundColor: AppColor.black,

    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColor.primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.white,
      centerTitle: true,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.black.withOpacity(0.1), // Colors.white.withOpacity(0.2),
      elevation: 1,
    ),
    textTheme: TextTheme(
      displayLarge: _textStyle.displayLarge.copyWith(color: Colors.black),
      displayMedium: _textStyle.displayMedium.copyWith(color: Colors.black),
      displaySmall: _textStyle.displaySmall.copyWith(color: Colors.black),
      headlineLarge: _textStyle.headlineLarge.copyWith(color: Colors.black),
      headlineMedium: _textStyle.headlineMedium.copyWith(color: Colors.black),
      headlineSmall: _textStyle.headlineSmall.copyWith(color: Colors.black),
      titleLarge: _textStyle.titleLarge.copyWith(color: Colors.black),
      titleSmall: _textStyle.titleSmall.copyWith(color: Colors.black),
      titleMedium: _textStyle.titleMedium.copyWith(color: Colors.black),
      labelLarge: _textStyle.labelLarge.copyWith(color: Colors.black),
      labelMedium: _textStyle.labelMedium.copyWith(color: Colors.black),
      labelSmall: _textStyle.labelSmall.copyWith(color: Colors.black),
      bodyLarge: _textStyle.bodyLarge.copyWith(color: Colors.black),
      bodyMedium: _textStyle.bodyMedium.copyWith(color: Colors.black),
      bodySmall: _textStyle.bodySmall.copyWith(color: Colors.black),
    ),
  );
}
