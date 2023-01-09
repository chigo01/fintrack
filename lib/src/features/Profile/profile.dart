import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/presentation/controllers/themechanges.dart';
import '../../core/utils/background-dec.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  // const LightMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    final theme = ref.watch(themeProvider);
    return Scaffold(
      key: scaffoldState,
      body: Container(
        decoration: theme == ThemeMode.dark
            ? backgroundColor()
            : const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [],
            ),
            Container(
              height: 60,
              width: 100,
              decoration: const BoxDecoration(
                color: Color(0xff243bb6),
                shape: BoxShape.circle,
              ),
              child: const Text(
                'Home',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  GlassMorphic(
                    mode: theme,
                    border: BorderRadius.circular(10),
                    height: 70,
                    width: 300,
                    borderWidth: 2,
                    borderColor: Colors.white30,
                    child:
                        Center(child: Text('${MediaQuery.of(context).size}')),
                  ),
                  const SizedBox(height: 10),
                  GlassMorphic(
                    mode: theme,
                    border: BorderRadius.circular(10),
                    height: 70,
                    width: 300,
                    borderWidth: 2,
                    borderColor: Colors.white30,
                    child: Center(
                        child: Text(
                            '${const Size(54, 78) >= const Size(23, 54)}')),
                  ),
                  const SizedBox(height: 10),
                  GlassMorphic(
                    mode: theme,
                    border: BorderRadius.circular(10),
                    height: 70,
                    width: 300,
                    borderWidth: 2,
                    borderColor: Colors.white30,
                  ),
                  // const SizedBox(height: 10),
                  // GlassMorphic(
                  //   mode: theme,
                  //   border: BorderRadius.circular(6),
                  // ),
                  // const SizedBox(height: 10),
                  //   mode: theme,
                  //   border: BorderRadius.circular(6),
                  //
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
