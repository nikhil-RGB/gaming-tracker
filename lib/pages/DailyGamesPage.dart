import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:gaming_tracker/pages/SelectGamePage.dart';
import 'package:gaming_tracker/pages/ShowPlayInfo.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:transparent_image/transparent_image.dart';

class DailyGamePage extends StatefulWidget {
  @override
  State<DailyGamePage> createState() => _DailyGamePageState();
  final DateTime referenceDay;
  const DailyGamePage({super.key, required this.referenceDay});
}

class _DailyGamePageState extends State<DailyGamePage> {
  @override
  Widget build(BuildContext context) {
    DailyInfoList gamesPlayed = DailyInfoList.fromDate(widget.referenceDay);
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: (gamesPlayed.gamesPlayed.isEmpty)
          ? null
          : AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              //This button will delete the entire day's game data
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        gamesPlayed.clear();
                        gamesPlayed.updateInfo();
                      });
                    },
                    icon: const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.red,
                    ))
              ],
            ),
      body: Center(
        child:
            //add ternary operator check here for games played.
            (gamesPlayed.gamesPlayed.isEmpty)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/cat_display.png"),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "No Games played today!",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Gap(MediaQuery.of(context).size.height * 0.27),
                      _addGameButton(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      dateCard(date: widget.referenceDay),
                      const Text(
                        "Today's Games",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Gap(MediaQuery.of(context).size.height * 0.050),
                      buildGameList(gamesPlayed),
                      Gap(MediaQuery.of(context).size.height * 0.059),
                      _addGameButton(),
                    ],
                  ),
      ),
    ));
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

  //Builds a list view of the games played that day
  Widget buildGameList(DailyInfoList gamesPlayed) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.522,
      child: Center(
        child: ListView.builder(
            itemCount: gamesPlayed.gamesPlayed.length,
            itemBuilder: ((context, index) {
              return buildGameCard(gamesPlayed.gamesPlayed[index], index);
            })),
      ),
    );
  }

  Widget buildGameCard(PlayInformation gameInfo, int index) {
    String gname = gameInfo.game.game_name;
    if (gname.length > 13) {
      gname = gname.substring(0, 11);
      gname = gname + "..";
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShowPlayInfo(
                  gameInformation: gameInfo,
                  index: index,
                  date: widget.referenceDay,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 1.0),
        child: Column(
          children: [
            SizedBox(
              height: 152,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gname,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(3),
                        Text("${gameInfo.hours} hours played",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Gap(16.0),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: Colors.black,
                    // margin: const EdgeInsets.all(10.0),
                    clipBehavior: Clip.hardEdge,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: FileImage(File(gameInfo.game.image_path)),
                      fit: BoxFit.cover,
                      height: 110,
                      width: 142,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0.5,
              thickness: 0.8,
              color: Color(0xFF4D4C4C),
            )
          ],
        ),
      ),
    );
  }

  Widget _addGameButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFFF23453),
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    // border radius
                    borderRadius: BorderRadius.circular(50))),
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
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SelectGamePage(
                            referenceDay: widget.referenceDay,
                          )));
            },
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Log Gaming Session",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600),
              ),
            )),
      ),
    );
  }
}
