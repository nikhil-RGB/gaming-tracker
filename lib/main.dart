import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

late String main_dir_path;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  main_dir_path = await _localPath;
  Directory("${main_dir_path}/Games").createSync();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
