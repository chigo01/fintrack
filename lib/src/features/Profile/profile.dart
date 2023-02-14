import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/presentation/provider/themechanges.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  // const LightMode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
    final theme = ref.watch(themeProvider);
    final currency = ref.watch(currencyProvider);
    return Scaffold(
      key: scaffoldState,
      body: Container(
        // decoration: theme == ThemeMode.dark
        //     ? backgroundColor()
        //     : const BoxDecoration(color: Colors.white),
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
                    child: Center(
                        child: Text(
                            '${MediaQuery.of(context).size} ${Money.format(value: 239888332, symbol: currency)}')),
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
                      '${const Size(54, 78) >= const Size(23, 54)} ${NumberFormat.currency(symbol: currency, decimalDigits: 2).format(239888332)}',
                    )),
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
                            '${MediaQuery.of(context).devicePixelRatio} and ${MediaQuery.of(context).size.aspectRatio}')),
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
