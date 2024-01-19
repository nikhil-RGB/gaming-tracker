// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CalendarDatePicker(
              initialDate: DateTime(2024),
              firstDate: DateTime(2024),
              lastDate: DateTime(2025),
              onDateChanged: (changed) {}),
        ),
      ),
    );
  }
}
