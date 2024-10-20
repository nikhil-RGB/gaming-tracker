// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';

class PerformancePage extends StatefulWidget {
  PerformancePage(
      {super.key, required this.gameDataModel, required this.dateTime});
  GameDataModel gameDataModel;
  late PlayInformation playinfo;
  DateTime dateTime;
  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.gameDataModel.game_name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              //Rest of the selection options here.
            ), //Game name
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PlayInformation pl_info =
              PlayInformation.standard(widget.gameDataModel);
          DailyInfoList obj = DailyInfoList.fromDate(widget.dateTime);
          obj.addGamingSession(pl_info);
          obj.updateInfo();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingPage()),
              (Route<dynamic> route) => false);
        },
        child: const Text("Send dummy data ahead"),
      ),
    );
  }
}
