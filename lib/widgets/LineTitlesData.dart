import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static int previousLabelValue = -1;
  static FlTitlesData getTitleData() => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35,
            getTitlesWidget: (value, meta) {
              Widget text;
              int val = value.toInt();
              if (previousLabelValue == val) {
                return const SizedBox.shrink(); // Don't show title
              } else {
                previousLabelValue = val;
              }
              switch (value.toInt()) {
                case 0:
                  text = const Text(
                    'Mon',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 1:
                  text = const Text(
                    'Tue',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 2:
                  text = const Text(
                    'Wed',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 3:
                  text = const Text(
                    'Thu',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 4:
                  text = const Text(
                    'Fri',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 5:
                  text = const Text(
                    'Sat',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;
                case 6:
                  text = const Text(
                    'Sun',
                    style: TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  );
                  break;

                default:
                  text = const Text('');
                  break;
              }
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
