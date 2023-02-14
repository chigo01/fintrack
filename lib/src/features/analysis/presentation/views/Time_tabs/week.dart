import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/analysis/presentation/widgets/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeekTab extends HookConsumerWidget {
  const WeekTab({super.key});
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
                      getTitlesWidget: (value, _) {
                        switch (value.toInt()) {
                          case 2:
                            return Text('Mon', style: textStyle);
                          case 4:
                            return Text('Tues', style: textStyle);
                          case 6:
                            return Text('Wed', style: textStyle);
                          case 8:
                            return Text('Thu', style: textStyle);
                          case 10:
                            return Text('Fri', style: textStyle);
                          case 12:
                            return Text('Sat', style: textStyle);
                          case 14:
                            return Padding(
                              padding: const EdgeInsets.only(right: 30.0),
                              child: Text('Sun', style: textStyle),
                            );
                        }
                        return const SizedBox();
                      }),
                  spots: [
                    FlSpot(
                        2,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.monday, transaction)),
                    FlSpot(
                        4,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.tuesday, transaction)),
                    FlSpot(
                        6,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.wednesday, transaction)),
                    FlSpot(
                        8,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.thursday, transaction)),
                    FlSpot(
                        10,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.friday, transaction)),
                    FlSpot(
                        12,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.saturday, transaction)),
                    FlSpot(
                        14,
                        TotalCalculation.getTotalOfDayPerWeek(
                            DateTime.sunday, transaction))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
