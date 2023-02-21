import 'package:animations/animations.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/fab-button.dart';
import 'package:fintrack/src/core/presentation/widgets/nav-bar.dart';
import 'package:fintrack/src/features/Profile/profile.dart';
import 'package:fintrack/src/features/Transactions/presentation/views/home_screen.dart';
import 'package:fintrack/src/features/analysis/presentation/views/analysis.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/Transactions/theme.dart';

List<Widget> pages = [
  const HomeScreen(),
  const AnalysisScreen(),
  const Profile(),
  const LightMode()
];

class MyAppActivity extends StatefulHookConsumerWidget {
  const MyAppActivity({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppActivityState();
}

class _MyAppActivityState extends ConsumerState<MyAppActivity> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
          child: FabButton(
            theme: theme,
          )),

      // ),
      body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (widget, animation, anim2) {
            animation = CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return FadeTransition(
              opacity: animation,
              child: widget,
            );
          },
          child: IndexedStack(
            index: _currentIndex,
            key: ValueKey<int>(_currentIndex),
            children: pages,
          )),
      bottomNavigationBar: GlassMorphicNavBar(
        theme: theme,
        currentIndex: _currentIndex,
        onChanged: (value) => setState(
          () {
            _currentIndex = value;
          },
        ),
      ),
    );
  }
}
