import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
                child: Container(
                  padding: EdgeInsets.only(top: context.height * 0.1),
                  child: Column(
                    children: [
                      Text(
                        '''  Balance\n${Money.format(
                          value: 14334,
                          symbol: ref.watch(currencyProvider),
                        )}''',
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
    final currency = ref.watch(currencyProvider);
    final theme = ref.watch(themeProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PhysicalModel(
            color: themeModeChecker
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.white,
            elevation: themeModeChecker ? 5.4 : 10,
            child: SizedBox(
              height: 160,
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      '   Daily Expense',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '''Total Balance\n   ${Money.format(
                        value: 14334,
                        symbol: ref.watch(currencyProvider),
                      )}''',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Stack(
                      children: [
                        Container(
                          width: context.getWidth(),
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          width: context.width / (5000 / 2000),
                          height: 14,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text('Expense'),
                          Text('Income'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          AutoSizeText(
                            Money.format(
                              value: 2000,
                              symbol: currency,
                            ),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 12,
                                      color: const Color(0xffFF4439),
                                    ),
                          ),
                          AutoSizeText(
                            Money.format(
                              value: 5000,
                              symbol: currency,
                            ),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 12,
                                      color: const Color(0xff4CAF50),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Recent Transactions',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w200),
              ),
              Tooltip(
                message: 'See All',
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(
                    PhosphorIcons.arrowCircleRight,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: context.getHeight() * 0.17,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: const Icon(Icons.money, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Food',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      const Text('98%'),
                      Text(
                        Money.format(
                          value: 2000,
                          symbol: currency,
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: const Color(0xffFF4439),
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right :290),
            child: Text(
              'Goals',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w200,
                    fontSize: 13,
                  ),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: context.height * 0.2,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: PhysicalModel(
                        borderRadius: BorderRadius.circular(15),
                        color: themeModeChecker
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.white,
                        elevation: themeModeChecker ? 5.4 : 10,
                        child: Container(
                          height: 100,
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset('assets/images/shoe.png'),
                              ),
                              Text('\$786'),
                              Text(
                                'Shoe',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.getHeight() * 0.18,
          )
        ],
      ),
    );
  }
}
