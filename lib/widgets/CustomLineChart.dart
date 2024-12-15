import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gaming_tracker/widgets/CustomLinesTileData.dart';

final List<Color> gradientColorsCustom = [
  const Color(0xff23b6e6),
  const Color(0xff02d39a),
];

class CustomLineChart extends StatefulWidget {
  List<double> hours;
  CustomLineChart({super.key, required this.hours});
  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  @override
  Widget build(BuildContext context) {
    CustomLineTiles.previousCustomLabel = "";
    return LineChart(
      LineChartData(
          titlesData: CustomLineTiles.getTitleData(),
          minY: 0,
          minX: 0,
          maxX: widget.hours.length.toDouble(),
          maxY: 24,
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
              spots: List.generate(widget.hours.length,
                  (index) => FlSpot((index).toDouble(), widget.hours[index])),
              color: gradientColorsCustom[1],
              belowBarData: BarAreaData(
                show: true,
                color: gradientColorsCustom[1].withOpacity(0.3),
              ),
            ),
          ]),
    );
  }
}
