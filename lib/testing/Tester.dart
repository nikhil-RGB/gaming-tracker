import 'dart:convert';
import 'dart:io';

import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/DailyInfoList.dart';
import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';

class Tester {
  void writeTestData() {
    List<GameDataModel> games = getGameData();
    List<PlayInformation> pi = games
        .map((e) => PlayInformation(
            game: e,
            hours: 3.1,
            performance_mode: PowerMode.Balanced,
            fan_speed: FanSpeed.Custom,
            CPU_FAN: 4500,
            GPU_FAN: 4500))
        .toList();
    DailyInfoList info_list = DailyInfoList.fromDate(DateTime.now());
    info_list.gamesPlayed = pi;
    info_list.updateInfo();
  }

  static List<GameDataModel> getGameData() {
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
}
