import 'package:flutter/material.dart';
import 'package:gaming_tracker/pages/AddGamePage.dart';

class GamesPage extends StatefulWidget {
  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/cat_display.png"),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "No Games Here!",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddGamePage()));
        },
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
    );
  }
}
