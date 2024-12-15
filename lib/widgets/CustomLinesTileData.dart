import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomLineTiles {
  static late DateTime startDay;
  static String previousCustomLabel = "";
  // static late DateTime endDay;
  static FlTitlesData getTitleData() => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (value, meta) {
              int daysAdd = value.toInt();
              String day = "";

              DateTime result = startDay.add(Duration(days: daysAdd));
              day = result.day.toString();

              if (day == previousCustomLabel) {
                return const SizedBox.shrink(); // Don't show title
              } else {
                previousCustomLabel =
                    day; //Update previous label with currently displayed label
              }

              Widget text = Text(
                day,
                style: const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              );

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8,
                child: text,
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,

            reservedSize: 40, // Increased to provide space for labels
            interval: 3,
            getTitlesWidget: (value, meta) {
              Widget text;

              // Show titles at intervals of 6
              text = Text(
                '${value.toInt()}',
                style: const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              );

              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 12,
                child: text,
              );
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );
}
