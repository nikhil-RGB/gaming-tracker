import 'package:flutter/material.dart';
import 'package:gaming_tracker/pages/CalendarPage.dart';
import 'package:gaming_tracker/pages/GamesPage.dart';
import 'package:gaming_tracker/pages/StatisticsPage.dart';

int currentPage = 0;
List<Widget> _screens = [
  CalendarPage(),
  GamesPage(),
  StatisticsPage(),
];

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[currentPage],
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            currentIndex: currentPage,
            backgroundColor: const Color(0xFF101010),
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.redAccent,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.gamepad_outlined,
                  ),
                  label: 'Games'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.stacked_bar_chart_outlined,
                  ),
                  label: 'Statistics'),
            ],
          ),
        ),
      ),
    );
  }
}
