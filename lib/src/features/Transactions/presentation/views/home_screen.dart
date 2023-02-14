import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/pop_menu.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/balance.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/views/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<String> transTab = ['Expense', 'Income'];

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> currentIndex = useState(0);
    final expense = ref.watch(totalTransactions('expense')).valueOrNull;
    final income = ref.watch(totalTransactions('income')).valueOrNull;
    final themeModeChecker = ref.read(themeProvider) == ThemeMode.dark;
    final theme = ref.watch(themeProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    'Welcome, Favour ',
                                    speed: const Duration(milliseconds: 150),
                                    cursor: '',
                                    textStyle: GoogleFonts.itim(
                                      fontSize: 17,
                                      color:
                                          themeModeChecker ? Colors.grey : null,
                                    ),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                repeatForever: true,
                                displayFullTextOnTap: true,
                                stopPauseOnTap: false,
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: PopMenuWidget(ref: ref, theme: theme),
                          ),
                        ],
                      ),
                    ),
                    BalanceWidget(
                      income: income,
                      expense: expense,
                      ref: ref,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(transTab.length, (index) {
                          return Text(
                            transTab[index],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: context.height >= 960 ? 12 : 16,
                                  color: currentIndex.value == index
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                ),
                          ).onTap(() {
                            currentIndex.value = index;
                          });
                        })
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: IndexedStack(
                    index: currentIndex.value,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: TabBody(
                          categories: categories,
                          transType: 'Expense',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: TabBody(
                          categories: incomeCategory,
                          transType: 'Income',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
