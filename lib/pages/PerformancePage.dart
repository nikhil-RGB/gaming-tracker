// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';

class PerformancePage extends StatefulWidget {
  PerformancePage({super.key, required this.gameDataModel});
  GameDataModel gameDataModel;
  late PlayInformation playinfo;
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
            ), //Game name
          ],
        ),
      ),
    );
  }
}
