import 'package:flutter/material.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/pages/CalendarPage.dart';
import 'package:gaming_tracker/widgets/LineChartWidget.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

String initialGameValue = "All Games";
const String defaultGameSelection = "All Games";

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
      if (initialGameValue == defaultGameSelection) {
        return plinfo.totalHours();
      } else {
        return plinfo.hoursFor(initialGameValue);
      }
    }).toList();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selected day: ${convertDate(globalReferenceDay)}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(15),
              selectGameDropdown(),
              const Gap(18),
              Text(
                "${formatNumericDate(DailyInfoList.getMostRecentMonday(globalReferenceDay))} - ${formatNumericDate(DailyInfoList.getNearestSunday(globalReferenceDay))}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Gap(12),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.93,
                child:
                    LineChartWidget(game_name: initialGameValue, hours: hours),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatNumericDate(DateTime now) {
    String date = DateFormat('dd/MM/yyyy').format(now);
    // Logger().w(date);  Example output: "11-12-2024"
    return date;
  }

  Widget selectGameDropdown() {
    List<String> games =
        getGameData().map((gameData) => gameData.game_name).toList();
    games.add("All Games");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Select Game: ",
          style: TextStyle(color: Colors.white),
        ),
        const Gap(13.0),
        DropdownButton<String>(
            iconEnabledColor: Colors.redAccent,
            dropdownColor: Colors.redAccent,
            underline: Container(
              height: 1,
              color: Colors.redAccent,
            ),
            value: initialGameValue,
            selectedItemBuilder: (BuildContext context) {
              return games.map((String value) {
                return Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(minWidth: 200),
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }).toList();
            },
            items: games.map((gameName) {
              return DropdownMenuItem(
                  value: gameName,
                  child: Text(
                    gameName,
                    style: const TextStyle(color: Colors.white),
                  ));
            }).toList(),
            onChanged: (Object? value) {
              if (value == null) {
                return;
              }
              setState(() {
                initialGameValue = value as String;
              });
            })
      ],
    );
  }
}
