import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';
import 'package:gaming_tracker/testing/Tester.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

late String main_dir_path;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  main_dir_path = await _localPath;
  //The line below is used for cleaning previous data, allowing for clean reinstalls of the app
  //whenever the underlying models(eg:GameDataModel) are changed. Keep it commented during the final build/standard testing
  // Directory("${main_dir_path}/Games").deleteSync(recursive: true);
  Directory("${main_dir_path}/Games").createSync();
  Directory("${main_dir_path}/DailyInformation").createSync();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tester().writeTestData();
    return MaterialApp(
      title: 'Gaming Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFFF23453),
        ),
        textTheme: GoogleFonts.sourceCodeProTextTheme(),
      ),
      home: LandingPage(),
    );
  }
}

//get the application documents directory path.
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

//Converts the date to the required format
String convertDate(DateTime now) {
  String date = DateFormat('MMMM dd yyyy').format(now);

  return date;
}

List<GameDataModel> getGameData() {
  Directory games_dir = Directory("$main_dir_path/Games");
  List<FileSystemEntity> files = games_dir.listSync();
  List<GameDataModel> gameData = [];
  for (FileSystemEntity entity in files) {
    File ref = File(entity.path);
    String data = ref.readAsStringSync();
    gameData.add(GameDataModel.fromJson(jsonDecode(data)));
  }
  return gameData;
}
