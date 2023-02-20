import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/trans_row.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/core/widgets/asyncvalue.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:fintrack/src/features/analysis/presentation/providers/nav_analysis.dart';
import 'package:fintrack/src/features/analysis/presentation/views/analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
    final themeModeChecker = ref.watch(themeProvider) == ThemeMode.dark;
    final currency = ref.watch(currencyProvider);
    final expense = ref.watch(totalTransactions('expense')).valueOrNull ?? 0.0;
    final income = ref.watch(totalTransactions('income')).valueOrNull ?? 0.0;
    final transactionsData = ref.watch(getTransactions(widget.transType));
    final value = (expense) / (income) * context.getWidth();
    final linear = useLinearProgress(value);
    final totalAmount =
        ref.watch(totalTransactions(widget.transType)).valueOrNull ?? 0.0;

    // final transanctionData = ref.watch(transactionProvider);

    // final theme = ref.watch(themeProvider);
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
                    child: Column(
                      children: [
                        Text(
                          '''Total Balance''',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 13,
                                  ),
                        ),
                        Text(
                          Money.format(
                            value: income - expense,
                            symbol: ref.watch(currencyProvider),
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
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
                          constraints: BoxConstraints(
                            maxWidth: context.getWidth(),
                            maxHeight: 14,
                          ),
                          // width: context.getWidth(),
                          // height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: linear.value,
                            maxHeight: 14,
                          ),
                          // width:
                          // height: 14,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: AutoSizeText(
                              Money.format(
                                value: expense,
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: AutoSizeText(
                              Money.format(
                                value: income,
                                symbol: currency,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: const Color(0xff4CAF50),
                                  ),
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
                  onPressed: () {
                    context.pushTransition(
                      const AnalysisScreen(),
                    );
                    ref.read(navigatesAnalysis.notifier).push();
                  },
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
                if (transactionsData.valueOrNull != null &&
                    transactionsData.valueOrNull!.isNotEmpty) {
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
                                  .singleWhereOrNull((element) =>
                                      element.title == data[index].category)
                                  ?.icon;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: TransactionRow(
                                  width: 2,
                                  categoryIcon: categoryIcon,
                                  totalAmount: totalAmount,
                                  transType: widget.transType,
                                  currency: currency,
                                  amount: data[index].amount,
                                  text: Text(
                                    data[index].category.capitalized,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 10,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
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
                ).onTap(() {
                  debugPrint('hello');
                })
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
                if (transactionsData.valueOrNull != null &&
                    transactionsData.valueOrNull!.isNotEmpty) {
                  return AsyncValueWidgets(
                      value: transactionsData,
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
                                            ?.copyWith(
                                              fontSize: 15,
                                            ),
                                      ),
                                      const Text(
                                        '\$786',
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
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
    );
  }
}

Animation<double> useLinearProgress(double value) {
  final animationController = useAnimationController(
    duration: const Duration(seconds: 7),
  );
  useEffect(() {
    animationController.forward();
    return null;
  }, const []);

  useAnimation(animationController);
  return Tween<double>(begin: 3, end: value).animate(
    CurvedAnimation(
      parent: animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}
