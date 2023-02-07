import 'package:device_preview/device_preview.dart';
import 'package:fintrack/src/core/presentation/app.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() {
  Paint.enableDithering = true;
  // FlutterError.demangleStackTrace = (StackTrace stack) {
  //   if (stack is stack_trace.Trace) return stack.vmTrace;
  //   if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
  //   return stack;
  // };
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
