import 'package:flutter/material.dart';
import 'package:gaming_tracker/pages/LandingPage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
