import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import '../../core/presentation/provider/themechanges.dart';
import '../../core/utils/background-dec.dart';

class LightMode extends ConsumerWidget {
  const LightMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return Container(
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
              'theme',
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
                  child: Center(child: Text('${MediaQuery.of(context).size}')),
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
                      child:
                          Text('${const Size(54, 78) >= const Size(23, 54)}')),
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
                      DateTime.now().toIso8601String(),
                    ),
                  ),
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
    );
  }
}
