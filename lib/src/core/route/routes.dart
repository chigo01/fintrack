import 'package:fintrack/src/core/route/route_name.dart';
import 'package:fintrack/src/features/ThemeChanges/theme.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (_) => const LightMode(),
          settings: settings,
        );
    }

    return null;
  }
}
