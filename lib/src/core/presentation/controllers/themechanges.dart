import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanges extends StateNotifier<ThemeMode> {
  ThemeChanges() : super(ThemeMode.dark);

  void changeMode(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleMode({ThemeMode? mode}) async {
    final pref = await SharedPreferences.getInstance();

    if (mode == ThemeMode.dark) {
      state = ThemeMode.light;
      pref.setBool('darkMode', false);
    } else {
      state = ThemeMode.dark;
      pref.setBool('darkMode', true);
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeChanges, ThemeMode>(
  (ref) => ThemeChanges(),
);