import 'dart:convert';
import 'dart:io';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/pages/AddGamePage.dart';

class GamesPage extends StatefulWidget {
  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    List<GameDataModel> games = getGameData();
    return Scaffold(
      // ignore: prefer_is_empty
      body: (games.length == 0)
          ? Column(
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
            )
          : Center(
              child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: ((context, index) {
                    return buildGameCard(games[index]);
                  })),
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddGamePage()));

          setState(() {});
        },
        child: const Icon(
          Icons.add_outlined,
        ),
      ),
    );
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

  Widget buildGameCard(GameDataModel gameData) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.black,
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: FileImage(File(gameData.image_path)),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  File reference =
                      File("$main_dir_path/Games/${gameData.game_name}.txt");
                  reference
                      .deleteSync(); //throws a file system exception if it  fails.
                  setState(() {});
                },
              ),
            ),
            Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
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
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        gameData.description,
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
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
