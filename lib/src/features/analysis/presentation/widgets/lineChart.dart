import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LineCharts extends HookConsumerWidget {
  const LineCharts({
    Key? key,
    required this.sideTitles,
    required this.spots,
  }) : super(key: key);
  final SideTitles? sideTitles;
  final List<FlSpot> spots;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeCheck = ref.watch(themeProvider) == ThemeMode.dark;

    return Container(
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
        height: context.getHeight(0.25),
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
                tooltipBgColor: Theme.of(context).primaryColor.withOpacity(.2),
              ),
              touchCallback: (_, __) {},
            ),
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                axisNameSize: 25,
                sideTitles: sideTitles,
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border.symmetric(
                vertical: BorderSide(
                  width: 1.5,
                  color: Colors.grey,
                ),
                horizontal: BorderSide(
                  width: 1.2,
                  color: Colors.grey,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                color: Theme.of(context)
                    .primaryColor, //themeCheck ? Colors.grey : Colors.black,
                // isCurved: true,
                curveSmoothness: 0.1,
                dotData: FlDotData(
                    show: false,
                    getDotPainter: (_, __, ___, ____) {
                      return FlDotCirclePainter(
                        radius: 2.5,
                        color: Colors.white,
                        strokeWidth: 2,
                        strokeColor: Colors.black,
                      );
                    }),
                barWidth: 2,
                spots: spots,
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
        ));
  }
}
