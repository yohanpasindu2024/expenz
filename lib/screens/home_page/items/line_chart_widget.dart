import 'package:expenz/constants/colors.dart';
import 'package:expenz/data/backend_data/line_chart_data.dart';
import 'package:expenz/models/ui_models/expense_income_model.dart/expense_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatefulWidget {
  final List<Expense> listOfExpenses;
  const LineChartWidget({
    super.key,
    required this.listOfExpenses,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 12,
              bottom: 12,
            ),
            child: LineChart(
              LineChartData(
                minY: 0,
                maxX: 3,
                lineTouchData: LineTouchData(
                  enabled: true,
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: true,
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        int index = value.toInt();
                        if (index < 0 ||
                            index >= widget.listOfExpenses.length) {
                          return const SizedBox(); // Return an empty widget if out of range
                        }
                        return SideTitleWidget(
                          meta: meta,
                          fitInside: SideTitleFitInsideData(
                            enabled: true,
                            axisPosition: -13,
                            parentAxisSize: 0,
                            distanceFromEdge: 0,
                          ),
                          child: Text(
                            LineChartDataSet.getXLineTitles(
                              listOfItems: widget.listOfExpenses,
                            )[index],
                            style: TextStyle(
                              color: yBlackColor.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: false,
                  )),
                  topTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: false,
                  )),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                    showTitles: false,
                  )),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: LineChartDataSet.getSpots(
                        listOfItems: widget.listOfExpenses),
                    barWidth: 5,
                    isStrokeCapRound: false,
                    dotData: const FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          yPurpleColor.withValues(alpha: 0.22),
                          yPurpleColor.withValues(alpha: 0.01),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    isCurved: true,
                    show: true,
                    color: yPurpleColor.withValues(alpha: 0.4),
                    isStrokeJoinRound: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
