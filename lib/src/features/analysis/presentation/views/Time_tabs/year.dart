import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/analysis/presentation/widgets/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class YearTab extends HookConsumerWidget {
  const YearTab({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(getAllTransactions('expense')).valueOrNull;

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
                    DateFormat('MMM').format(
                      DateTime(
                        DateTime.now().year,
                        value.toInt(),
                      ),
                    ),
                    style: textStyle,
                  ),
                ),
                spots: List.generate(
                  12,
                  (index) => FlSpot(
                      index.toDouble(),
                      TotalCalculation.getTotalOfMonthPerYear(
                          index, transaction)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
