import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/pages/PerformancePage.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:transparent_image/transparent_image.dart';

// ignore: must_be_immutable
class SelectGamePage extends StatefulWidget {
  SelectGamePage({super.key, required this.referenceDay});
  final DateTime referenceDay;
  String selectedGame = "";
  @override
  State<SelectGamePage> createState() => _SelectGamePageState();
}

class _SelectGamePageState extends State<SelectGamePage> {
  @override
  void initState() {
    widget.selectedGame = getGameData()[0].game_name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dateCard(date: widget.referenceDay),
                const Text(
                  "Choose a game",
                  style: TextStyle(
                    color: Color(0XFFF23453),
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                Gap(MediaQuery.of(context).size.height * 0.062),
                buildGameGrid(),
                //next button here
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buildNextButton(),
    );
  }

  Widget dateCard({required DateTime date}) {
    Logger logger = Logger();
    DateTime now = date;
    String dayMonth = DateFormat('MMMM dd').format(now);
    logger.i(dayMonth); // Example output: "July 03"
    int year = (now.year);
    logger.i(year);
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dayMonth,
            style: const TextStyle(
                color: Color(0xFFA9A9A9),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const Gap(2),
          Text(
            "$year",
            style: const TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const Gap(2),
        ],
      ),
    );
  }

  Widget buildGameGrid() {
    List<GameDataModel> games = getGameData();
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          children: games.map((e) {
            return buildGameCard(e);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildGameCard(GameDataModel gameData) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: (widget.selectedGame == gameData.game_name)
              ? const Color(0xFFF23453)
              : Colors.black,
          width: 2.0,
        ),
      ),
      color: Colors.black,
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.selectedGame = gameData.game_name;
          });
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: FileImage(File(gameData.image_path)),
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(
                        gameData.game_name,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 3.0,
                      ),
                      // Text(
                      //   gameData.description,
                      //   textAlign: TextAlign.center,
                      //   maxLines: 2,
                      //   softWrap: true,
                      //   overflow: TextOverflow.ellipsis,
                      //   style: const TextStyle(
                      //     color: Colors.white,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14,
                      //   ),
                      // ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  FloatingActionButton buildNextButton() {
    return FloatingActionButton(
      backgroundColor: const Color(0xFFF23453),
      onPressed: () {
        List<GameDataModel> games = getGameData();
        games.isEmpty
            ? Fluttertoast.showToast(
                msg: "No Game Registered",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color.fromARGB(255, 41, 40, 40),
                textColor: Colors.white,
                fontSize: 16.0)
            : Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PerformancePage()));
      },
      child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Text(
          "Next",
          style: TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Widget nextButton() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(50),
  //       ),
  //       child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //               backgroundColor: const Color(0XFFF23453),
  //               shape: RoundedRectangleBorder(
  //                   side: BorderSide.none,
  //                   // border radius
  //                   borderRadius: BorderRadius.circular(50))),
  //           onPressed: () {
  //             List<GameDataModel> games = getGameData();
  //             games.isEmpty
  //                 ? Fluttertoast.showToast(
  //                     msg: "No Game Registered",
  //                     toastLength: Toast.LENGTH_SHORT,
  //                     gravity: ToastGravity.BOTTOM,
  //                     timeInSecForIosWeb: 1,
  //                     backgroundColor: const Color.fromARGB(255, 41, 40, 40),
  //                     textColor: Colors.white,
  //                     fontSize: 16.0)
  //                 : Navigator.of(context).push(MaterialPageRoute(
  //                     builder: (context) => PerformancePage()));
  //           },
  //           child: const Padding(
  //             padding: EdgeInsets.all(15.0),
  //             child: Text(
  //               "Next",
  //               style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 19,
  //                   fontWeight: FontWeight.w600),
  //             ),
  //           )),
  //     ),
  //   );
  // }
}
