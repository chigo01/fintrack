import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/core/widgets/asyncvalue.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:collection/collection.dart';

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
    final expense = ref.watch(totalTransactions('expense')).value;
    final income = ref.watch(totalTransactions('income')).value;
    return Scaffold(
      body: SizedBox(
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
                    Column(
                      children: [
                        Text(
                          'Balance',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                  ),
                        ),
                        Text(
                          Money.format(
                            value: (income ?? 1) - (expense ?? 1),
                            symbol: ref.watch(currencyProvider),
                          ),
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
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
    );
  }
}

class TabBody extends StatefulHookConsumerWidget {
  const TabBody({
    super.key,
    required this.transType,
    required this.categories,
  });

  final String transType;
  final List<Category> categories;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabBodyState();
}

class _TabBodyState extends ConsumerState<TabBody> {
  @override
  Widget build(BuildContext context) {
    final themeModeChecker = ref.read(themeProvider) == ThemeMode.dark;
    final currency = ref.watch(currencyProvider);
    final expense = ref.watch(totalTransactions('expense'));
    final income = ref.watch(totalTransactions('income'));
    final transactionsData = ref.watch(getTransactions(widget.transType));

    // final transanctionData = ref.watch(transactionProvider);

    // final theme = ref.watch(themeProvider);
    return SingleChildScrollView(
      child: Container(
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
                      child: Column(
                        children: [
                          Text(
                            '''Total Balance''',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontSize: 13,
                                ),
                          ),
                          Text(
                            Money.format(
                              value: (income.value ?? 0.0) -
                                  (expense.value ?? 0.0),
                              symbol: ref.watch(currencyProvider),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                          )
                        ],
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
                            width: transactionsData.value?.isEmpty ?? true
                                ? 3
                                : ((expense.value ?? 0.0) /
                                    (income.value ?? 0.0) *
                                    context.getWidth()),
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
                                value: expense.value ?? 0.0,
                                symbol: currency,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xffFF4439),
                                  ),
                            ),
                            AutoSizeText(
                              Money.format(
                                value: income.value ?? 0.0,
                                symbol: currency,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xff4CAF50),
                                  ),
                            )
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
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  if (transactionsData.value != null &&
                      transactionsData.value!.isNotEmpty) {
                    return AsyncValueWidgets(
                        value: transactionsData,
                        data: (data) {
                          return Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final categoryIcon = widget.categories
                                        .singleWhereOrNull(
                                          (element) =>
                                              element.title ==
                                              data[index].category,
                                        )
                                        ?.icon;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    child: Icon(categoryIcon,
                                                        size: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(width: 3),
                                                Expanded(
                                                  child: Text(
                                                    data[index]
                                                        .name
                                                        .capitalized,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 10,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 70),
                                          const Expanded(child: Text('98%')),
                                          const SizedBox(width: 35),
                                          Expanded(
                                            child: Text(
                                              Money.format(
                                                value: data[index].amount,
                                                symbol: currency,
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontSize: 12,
                                                    color: widget.transType ==
                                                            'Expense'
                                                        ? const Color(
                                                            0xffFF4439)
                                                        : const Color(
                                                            0xff4CAF50),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                        });
                  } else {
                    return const Center(
                      child: Text('No Transactions'),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goals',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w200,
                          fontSize: 13,
                        ),
                  ),
                  Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        'See All',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                      ),
                    ),
                  ).onTap(() {})
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.height < 680 ? 60 : 20,
              ),
              child: SizedBox(
                height: context.height * 0.2,
                width: context.width,
                child: Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  final transactionsData =
                      ref.watch(getTransactions(widget.transType));

                  if (transactionsData.value != null &&
                      transactionsData.value!.isNotEmpty) {
                    return transactionsData.when(
                      data: (data) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PhysicalModel(
                                borderRadius: BorderRadius.circular(15),
                                color: themeModeChecker
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.1)
                                    : Colors.white,
                                elevation: themeModeChecker ? 5.4 : 10,
                                child: SizedBox(
                                  height: 130,
                                  width: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // const SizedBox(height: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '23 May 2023',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w200,
                                              ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: data[index].imageUrl == null
                                                ? Image.asset(
                                                    'assets/images/shoe.png')
                                                : Image.file(
                                                    File(
                                                      data[index].imageUrl!,
                                                    ),
                                                    height: 50,
                                                    width: 70,
                                                    fit: BoxFit.fill,
                                                  )),
                                      ),
                                      Text(
                                        'Shoe',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(fontSize: 15),
                                      ),
                                      const Text(
                                        '\$786',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      error: (Object error, StackTrace stackTrace) => Text(
                        'error $error',
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text('No Transactions'),
                    );
                  }
                }),
              ),
            ),
            const SizedBox(height: 98),
            if (context.height < 750)
              Container(
                height: context.getHeight() * 0.2,
              ),
          ],
        ),
      ),
    );
  }
}
