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
  final List<bool> _modes = [
    true,
    false
  ]; //first bool means standard view, second means custom view
  TextEditingController _dateStart = TextEditingController();
  TextEditingController _dateEnd = TextEditingController();
  DateTime? start;
  DateTime? end;
  @override
  Widget build(BuildContext context) {
    if (_modes[0]) {
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
                toggleViews(),
                const Gap(25),
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
                  child: LineChartWidget(
                      game_name: initialGameValue, hours: hours),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SafeArea(
          child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              toggleViews(),
              const Gap(25),
              datePickers(context),
            ],
          ),
        ),
      ));
    }
  }

  Widget datePickers(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter start date",
              style: TextStyle(color: Colors.white),
            ),
            const Gap(8),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.31,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _dateStart,
                readOnly: true,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
            const Gap(1),
            IconButton(
                // color: Colors.redAccent,
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    // initialDate: start,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now().add(const Duration(days: 1095)),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateStart.text = DateFormat('dd/MM/yyyy').format(picked);
                      // start = picked;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month)),
          ],
        ),
        const Gap(10),
        Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Enter end date  ",
              style: TextStyle(color: Colors.white),
            ),
            const Gap(8),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.31,
              child: TextField(
                textAlign: TextAlign.center,
                controller: _dateEnd,
                readOnly: true,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
            const Gap(1),
            IconButton(
                // color: Colors.redAccent,
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    // initialDate: end,
                    firstDate: DateTime(2023),
                    lastDate: DateTime.now().add(const Duration(days: 1095)),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateEnd.text = DateFormat('dd/MM/yyyy').format(picked);
                      // end = picked;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_month)),
          ],
        ),
        const Gap(23),
        selectGameDropdown(),
        const Gap(25),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: (_dateStart.text.isEmpty || _dateEnd.text.isEmpty)
                ? null
                : () {
                    DateTime t1 = parseDate(_dateStart.text);
                    DateTime t2 = parseDate(_dateEnd.text);
                    Duration difference_dur = t2.difference(t1);
                    int diff = difference_dur.inDays;
                    if (diff <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid Date Range!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    } else if (diff < 5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Day range must be greater than 4'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    } else if (diff > 20) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Day range cannot be greater than 20'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    start = t1;
                    end = t2;
                  },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Build/Refresh Graph",
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
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

  ToggleButtons toggleViews() {
    return ToggleButtons(
      fillColor: Colors.redAccent,
      borderRadius: BorderRadius.circular(12),
      borderWidth: 3,
      borderColor: Colors.redAccent,
      selectedBorderColor: Colors.redAccent,
      isSelected: _modes,
      onPressed: (index) {
        setState(() {
          _modes[0] = !_modes[0];
          _modes[1] = !_modes[1];
        });
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Standard View",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Custom View", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  //parses a date in the format dd-mm-yyyy
  DateTime parseDate(String input) {
    List<String> tokens = input.split("/"); //[dd,mm,yyyy]
    String toParse = "${tokens[2]}-${tokens[1]}-${tokens[0]}";
    return DateTime.parse(toParse);
  }
}
