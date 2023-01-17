import 'package:device_preview/device_preview.dart';
import 'package:fintrack/src/core/presentation/app.dart';
import 'package:fintrack/src/core/presentation/controllers/themechanges.dart';
import 'package:fintrack/src/core/theme/app_theme.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  runApp(
    const ProviderScope(
      //     child: DevicePreview(
      //   builder: (_) => const MyApp(),
      //   enabled: !kReleaseMode,
      // )
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeProvider);

    return MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeModeState,
      debugShowCheckedModeBanner: false,
      home: const AppActivity(),
    );
  }
}
