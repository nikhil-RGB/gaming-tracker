// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gaming_tracker/widgets/LineTitlesData.dart';

final List<Color> gradientColors = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class LineChartWidget extends StatefulWidget {
  static final double MAX_X = 7;
  static final double MAX_Y = 24;
  String game_name;
  List<double> hours;
  LineChartWidget({
    super.key,
    required this.game_name,
    required this.hours,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: LineChart(
        LineChartData(
            titlesData: LineTitles.getTitleData(),
            minY: 0,
            minX: 0,
            maxX: LineChartWidget.MAX_X,
            maxY: LineChartWidget.MAX_Y,
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1.0,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return const FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1.0,
                );
              },
            ),
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color(0xFFF23453),
                  width: 1,
                )),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(LineChartWidget.MAX_X.toInt(),
                    (index) => FlSpot((index).toDouble(), widget.hours[index])),
                color: gradientColors[1],
                belowBarData: BarAreaData(
                  show: true,
                  color: gradientColors[1].withOpacity(0.3),
                ),
              ),
            ]),
      ),
    );
  }
}
