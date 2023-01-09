import 'package:fintrack/src/core/presentation/controllers/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/fab-button.dart';
import 'package:fintrack/src/core/presentation/widgets/nav-bar.dart';
import 'package:fintrack/src/core/presentation/widgets/pop_menu.dart';
import 'package:fintrack/src/features/Profile/profile.dart';
import 'package:fintrack/src/features/ThemeChanges/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> pages = [
  const Profile(),
  const LightMode(),
  const Profile(),
  const LightMode()
];

class AppActivity extends ConsumerStatefulWidget {
  const AppActivity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<AppActivity> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    final theme = ref.watch(themeProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FabButton(
        theme: theme,
      ),
      appBar: AppBar(
        title: Text(
          'Hi, Favour',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: PopMenuWidget(ref: ref, theme: theme),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar:
          GlassMorphicNavBar(theme: theme, currentIndex: currentIndex),
    );
  }
}
