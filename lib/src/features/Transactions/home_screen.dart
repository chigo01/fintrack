import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

final _dateTabs = <Widget>[
  const Tab(text: 'day'),
  const Tab(text: 'week'),
  const Tab(text: 'Month'),
  const Tab(text: 'year'),
];

final tabBody = <Widget>[
  const TabBody(),
  const Center(child: Text('Week')),
  const Center(child: Text('Month')),
  const Center(child: Text('Year')),
];

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TabController tabController =
        useTabController(initialLength: _dateTabs.length);
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
                child: Padding(
                  padding: EdgeInsets.only(top: context.width / 5),
                  child: Column(
                    children: [
                      Text(
                        '''  Balance\n${Money.format(value: 14334, symbol: ref.watch(currencyProvider))}''',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 9,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Expense',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith()),
                          Text(
                            'Income',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(),
                          ),
                        ],
                      )
                    ],
                  ),
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
                  child: Column(
                    children: [
                      TabBar(
                        controller: tabController,
                        tabs: _dateTabs,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Theme.of(context).primaryColor,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 3,
                        isScrollable: true,
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: tabBody,
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

class TabBody extends StatefulHookConsumerWidget {
  const TabBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabBodyState();
}

class _TabBodyState extends ConsumerState<TabBody> {
  @override
  Widget build(BuildContext context) {
    final themeModeChecker = ref.read(themeProvider) == ThemeMode.dark;
    return Column(
      children: [
        Container(
          height: 140,
          width: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            // color: Theme.of(context).scaffoldBackgroundColor,
            color: themeModeChecker
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: themeModeChecker
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 30,
                offset: const Offset(3, 6),
              ),
              BoxShadow(
                color: themeModeChecker
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 30,
                offset: const Offset(3, 6),
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                '   Daily Expense',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: themeModeChecker
                          ? null
                          : Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
