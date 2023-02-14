import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/analysis/presentation/widgets/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class MonthTab extends HookConsumerWidget {
  const MonthTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(getAllTransactions('expense')).valueOrNull;

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

    TextStyle textStyle = const TextStyle(
      fontSize: 9,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: LineCharts(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) => Text(
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
                spots: List.generate(
                  getIndex(DateTime.now()),
                  (index) => FlSpot(
                    index.toDouble(),
                    TotalCalculation.getTotalOfWeekPerMonth(index, transaction),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
