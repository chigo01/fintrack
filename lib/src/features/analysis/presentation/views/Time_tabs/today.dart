import 'package:collection/collection.dart';
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
import 'package:fintrack/src/features/analysis/presentation/providers/filter.dart';
import 'package:fintrack/src/features/analysis/presentation/widgets/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../Transactions/presentation/provider/currency.dart';

final StateProvider<TransactionType> _transactionType = StateProvider(
  (ref) => TransactionType.expense,
);

class TodayTab extends HookConsumerWidget {
  const TodayTab({super.key});

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
                TodayTransactionTypeTab(
                    type: 'expense', categories: categories),
                TodayTransactionTypeTab(
                    type: 'income', categories: incomeCategory),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TodayTransactionTypeTab extends HookConsumerWidget {
  const TodayTransactionTypeTab({
    super.key,
    required String type,
    required this.categories,
  }) : _transactionType = type;
  final String _transactionType;
  final List<Category> categories;

  @override
  Widget build(BuildContext context, ref) {
    final transaction =
        ref.watch(getAllTransactions(_transactionType)).valueOrNull;
    // final transactionList =
    //     ref.watch(getAllTransactionsbyDay(_transactionType));
    final theme = ref.watch(themeProvider);
    final currency = ref.watch(currencyProvider);
    final TransactionPerTime time = TransactionPerTime();
    final formatDate = DateTimeFormatter();

    double totalAmount() {
      List<double> trans = [];
      trans = time
          .getTransactionByDay(transaction)
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
      search = time.getTransactionByDay(transaction);
    } else {
      search = time
          .getTransactionByDay(transaction)
          .where((element) => element.category
              .toLowerCase()
              .contains(ref.watch(query).toLowerCase()))
          .toList();
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TodayChart(transaction: transaction),
        ),
        TransactionHeader(
          transactionType: _transactionType,
          currency: currency,
          amount: totalAmount(),
        ),
        SizedBox(
          height: context.getHeight(.8),
          width: context.getWidth(.9),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: search.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final element = search[index];
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
                  ),
                );
              }),
        )
      ],
    );
  }
}

class TodayChart extends StatelessWidget {
  const TodayChart({
    super.key,
    required this.transaction,
  });

  final List<Transaction>? transaction;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      fontSize: 9,
    );

    return LineCharts(
        sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              switch (value.toInt()) {
                case 2:
                  return Text('1hr', style: textStyle);
                case 4:
                  return Text('2hr', style: textStyle);
                case 6:
                  return Text('3hr', style: textStyle);
                case 8:
                  return Text('4hr', style: textStyle);
                case 10:
                  return Text('5hr', style: textStyle);
                case 12:
                  return Text('6hr', style: textStyle);
                case 14:
                  return Text('7hr', style: textStyle);
                case 16:
                  return Text('8hr', style: textStyle);
                case 18:
                  return Text('9hr', style: textStyle);
                case 20:
                  return Text('10hr', style: textStyle);
                case 22:
                  return Text('11hr', style: textStyle);
                case 24:
                  return Text('12hr', style: textStyle);
                case 26:
                  return Text('13hr', style: textStyle);
                case 28:
                  return Text('14hr', style: textStyle);
                case 30:
                  return Text('15hr', style: textStyle);
                case 32:
                  return Text('16hr', style: textStyle);
                case 34:
                  return Text('17hr', style: textStyle);
                case 36:
                  return Text('18hr', style: textStyle);
                case 38:
                  return Text('19hr', style: textStyle);
                case 40:
                  return Text('20hr', style: textStyle);
                case 42:
                  return Text('21hr', style: textStyle);
                case 44:
                  return Text('22hr', style: textStyle);
                case 46:
                  return Text('23hr', style: textStyle);
                case 48:
                  return Text('24hr', style: textStyle);
                default:
                  return const SizedBox();
              }
            }),
        spots: [
          FlSpot(2, TotalCalculation.getTotalByDay(1, transaction)),
          FlSpot(4, TotalCalculation.getTotalByDay(2, transaction)),
          FlSpot(6, TotalCalculation.getTotalByDay(3, transaction)),
          FlSpot(8, TotalCalculation.getTotalByDay(4, transaction)),
          FlSpot(10, TotalCalculation.getTotalByDay(5, transaction)),
          FlSpot(12, TotalCalculation.getTotalByDay(6, transaction)),
          FlSpot(14, TotalCalculation.getTotalByDay(7, transaction)),
          FlSpot(16, TotalCalculation.getTotalByDay(8, transaction)),
          FlSpot(18, TotalCalculation.getTotalByDay(9, transaction)),
          FlSpot(20, TotalCalculation.getTotalByDay(10, transaction)),
          FlSpot(22, TotalCalculation.getTotalByDay(11, transaction)),
          FlSpot(24, TotalCalculation.getTotalByDay(12, transaction)),
          FlSpot(26, TotalCalculation.getTotalByDay(13, transaction)),
          FlSpot(28, TotalCalculation.getTotalByDay(14, transaction)),
          FlSpot(30, TotalCalculation.getTotalByDay(15, transaction)),
          FlSpot(32, TotalCalculation.getTotalByDay(16, transaction)),
          FlSpot(34, TotalCalculation.getTotalByDay(17, transaction)),
          FlSpot(36, TotalCalculation.getTotalByDay(18, transaction)),
          FlSpot(38, TotalCalculation.getTotalByDay(19, transaction)),
          FlSpot(40, TotalCalculation.getTotalByDay(20, transaction)),
          FlSpot(42, TotalCalculation.getTotalByDay(21, transaction)),
          FlSpot(44, TotalCalculation.getTotalByDay(22, transaction)),
          FlSpot(46, TotalCalculation.getTotalByDay(23, transaction)),
          FlSpot(48, TotalCalculation.getTotalByDay(24, transaction)),
        ]);
  }
}
