import 'dart:developer';

import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/trans_row.dart';
import 'package:fintrack/src/core/presentation/widgets/transactionHeader.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/enum.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/core/widgets/category_widget.dart';
import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:fintrack/src/features/analysis/presentation/providers/filter.dart';
import 'package:fintrack/src/features/analysis/presentation/widgets/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

final StateProvider<TransactionType> _transactionType = StateProvider(
  (ref) => TransactionType.expense,
);

class MonthTab extends HookConsumerWidget {
  const MonthTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final currentTransactionType = ref.watch(_transactionType);
    final themeModeCheck = theme == ThemeMode.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CategoryIndexWidget(
              currentTransactionType: currentTransactionType,
              themeModeCheck: themeModeCheck,
              ref: ref,
              transactionType: _transactionType,
            ),
            IndexedStack(
              index: currentTransactionType.index,
              children: [
                MonthTransactionTabType(categories, type: 'expense'),
                MonthTransactionTabType(incomeCategory, type: 'income'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MonthTransactionTabType extends HookConsumerWidget {
  const MonthTransactionTabType(this.categories,
      {super.key, required String type})
      : _transactionType = type;
  final String _transactionType;
  final List<Category> categories;

  @override
  Widget build(BuildContext context, ref) {
    int getIndex(DateTime day) {
      if (day.month == 2) {
        return 28;
      } else if (day.month == 4 ||
          day.month == 6 ||
          day.month == 9 ||
          day.month == 11) {
        return 30;
      } else {
        return 31;
      }
    }

    final transaction =
        ref.watch(getAllTransactions(_transactionType)).valueOrNull;
    // final transactionList =
    //     ref.watch(getAllTransactionsbyDay(_transactionType));
    final theme = ref.watch(themeProvider);
    final currency = ref.watch(currencyProvider);
    final TransactionPerTime time = TransactionPerTime();
    final formatDate = DateTimeFormatter();
    bool isSearching = false;

    double totalAmount() {
      List<double> trans = [];
      trans = time
          .getTransactionByMonth(transaction)
          .where((element) => element.transactionType == _transactionType)
          .map((e) => e.amount)
          .toList();
      if (trans.isNotEmpty) {
        return trans.reduce((value, element) => value + element);
      }
      return 0;
    }

    List<Transaction> search = [];

    if (ref.watch(query).isEmpty) {
      search = time.getTransactionByMonth(transaction);
    } else {
      search = time
          .getTransactionByMonth(transaction)
          .where((element) => element.category
              .toLowerCase()
              .contains(ref.watch(query).toLowerCase()))
          .toList();
    }

    TextStyle textStyle = const TextStyle(
      fontSize: 7,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: LineCharts(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Padding(
                padding: const EdgeInsets.only(right: 9.0, top: 5),
                child: Text(
                  DateFormat('d MMM').format(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      value.toInt(),
                    ),
                  ),
                  style: textStyle,
                ),
              ),
            ),
            spots: List.generate(
              getIndex(DateTime.now()),
              (index) => FlSpot(
                index.toDouble(),
                TotalCalculation.getTotalOfWeekPerMonth(index, transaction),
              ),
            ),
          ),
        ),
        TransactionHeader(
          transactionType: _transactionType,
          currency: currency,
          amount: totalAmount(),
        ),
        SizedBox(
          height: context.getHeight(.3),
          width: context.getWidth(.9),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: search.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final element = search[index];

                //     :

                final categoryIcon = categories
                    .singleWhereOrNull(
                        (value) => value.title == element.category)
                    ?.icon;
                final paymentIcon = paymentCategory.singleWhereOrNull(
                    (value) => value.title == element.paymentType);
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GlassMorphic(
                    mode: theme,
                    border: BorderRadius.circular(12),
                    height: 80,
                    width: 300,
                    borderWidth: 2,
                    borderColor: Colors.white30,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        TransactionRow(
                            categoryIcon: categoryIcon,
                            totalAmount: totalAmount(),
                            transType: _transactionType,
                            currency: currency,
                            amount: element.amount,
                            text: Text(
                              element.category.capitalized,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            name: element.name.capitalized,
                            date:
                                '${formatDate.transDateToString(element.date)}'
                                '     ${formatDate.timeToString(element.date)}',
                            width: 10,
                            paymentTypeIcon: paymentIcon?.icon,
                            paymentType: paymentIcon?.title),
                      ],
                    ),
                  ).onTap(() {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => TransactionDetail(
                    //       transaction: element,
                    //       transactionType: _transactionType,
                    //     ),
                    //   ),
                    // );
                    log(element.name);
                  }),
                );
              }),
        ),
      ],
    );
  }
}
