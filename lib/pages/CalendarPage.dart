// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) {
    //Current date to initialize the calendar
    DateTime today = DateTime.now();
    List<DateTime?> _dates = [today];
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        body: Center(
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              dayTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
              selectedDayTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            ),
            value: _dates,
            onValueChanged: (dates) => _dates = dates,
          ),
        ),
      ),
    );
  }
}
