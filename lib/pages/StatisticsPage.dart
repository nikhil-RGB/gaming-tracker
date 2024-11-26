import 'package:flutter/material.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/pages/CalendarPage.dart';
import 'package:gaming_tracker/widgets/LineChartWidget.dart';

class StatisticsPage extends StatefulWidget {
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> days = DailyInfoList.weekRange(globalReferenceDay);
    List<DailyInfoList> plinfos = days.map(
      (now) {
        return DailyInfoList.fromDate(now);
      },
    ).toList();
    List<double> hours = plinfos.map((plinfo) {
      return plinfo.totalHours();
    }).toList();
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width * 0.93,
            child: LineChartWidget(game_name: "All Games", hours: hours)),
      ),
    );
  }
}
