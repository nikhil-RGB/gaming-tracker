// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
    return LineChart(
      LineChartData(
          minY: 0,
          minX: 0,
          maxX: LineChartWidget.MAX_X,
          maxY: LineChartWidget.MAX_Y,
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(LineChartWidget.MAX_X.toInt(),
                  (index) => FlSpot((index).toDouble(), widget.hours[index])),
            )
          ]),
    );
  }
}
