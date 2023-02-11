import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnalysisScreen extends HookConsumerWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeCheck = ref.watch(themeProvider) == ThemeMode.dark;
    // final dat = ref.watch(tr);

    final transaction = ref.watch(getTransactions2('expense')).value;

    double getTotal(int day) {
      List<double> trans = [];
      if (transaction != null) {
        trans = transaction
            .where((element) =>
                DateTime.utc(
                  element.date.year,
                  element.date.month,
                  element.date.day,
                ).weekday ==
                day)
            .map(
              (e) => e.amount,
            )
            .toList();
      }

      if (trans.isNotEmpty) {
        return trans.reduce(
          (value, element) => element + value,
        );
      } else {
        return 100;
      }
    }

    // print(transaction!
    //     .where((element) => element.date.month == DateTime.february)
    //     .map((e) => e.amount)
    //     .reduce((value, element) => element + value));

    TextStyle textStyle = const TextStyle(
      fontSize: 16,
    );
    return Scaffold(
        body: SizedBox(
      child: Column(
        children: [
          Container(
            height: 200,
          ),
          Container(
            //const Color(0xff00042b),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: themeCheck
                  ? const Color(0xff00042b)
                  : Colors.white.withOpacity(.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: themeCheck ? 0 : 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: context.getHeight(0.5),
            width: context.getWidth(0.93),

            // color: const Color(0xff00042b),
            child: LineChart(
              LineChartData(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(.3),
                minY: 2,
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor:
                        Theme.of(context).primaryColor.withOpacity(.2),
                  ),
                  touchCallback: (_, __) {},
                ),
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameSize: 25,
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        switch (value.toInt()) {
                          case 2:
                            return Text('mon', style: textStyle);
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
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border.symmetric(
                    vertical: BorderSide(width: 1.5, color: Colors.grey),
                    horizontal: BorderSide(width: 1.2, color: Colors.grey),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: themeCheck ? Colors.grey : Colors.black,
                    // isCurved: true,
                    curveSmoothness: 0.1,
                    barWidth: 2,
                    spots: [
                      FlSpot(2, getTotal(DateTime.monday)),
                      FlSpot(4, getTotal(DateTime.tuesday)),
                      FlSpot(6, getTotal(DateTime.wednesday)),
                      FlSpot(8, getTotal(DateTime.thursday)),
                      FlSpot(10, getTotal(DateTime.friday)),
                      FlSpot(12, getTotal(DateTime.saturday)),
                      FlSpot(14, getTotal(DateTime.sunday))
                    ],
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.black12,
                          Theme.of(context).primaryColor.withOpacity(.3),
                          // themeCheck
                          //     ? const Color.fromARGB(213, 14, 117, 202)
                          //     : Theme.of(context).primaryColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
