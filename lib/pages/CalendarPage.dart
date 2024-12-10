// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:gaming_tracker/pages/DailyGamesPage.dart';

DateTime globalReferenceDay = DateTime.now();

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    //Current date to initialize the calendar
    DateTime today = globalReferenceDay;
    List<DateTime?> _dates = [today];
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                selectedYearTextStyle: TextStyle(color: Colors.redAccent),
                dayTextStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700),
                selectedDayTextStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
              ),
              value: _dates,
              onValueChanged: (dates) {
                _dates = dates;
                globalReferenceDay = _dates[0]!;
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTime obj = _dates[0]!;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DailyGamePage(
                    referenceDay: obj,
                  )));
        },
        child: const Icon(Icons.play_arrow_outlined),
      ),
    );
  }
}
