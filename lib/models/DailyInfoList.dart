// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
part 'DailyInfoList.g.dart';

@JsonSerializable()
class DailyInfoList {
  List<PlayInformation> gamesPlayed;
  String date;
  DailyInfoList({required this.gamesPlayed, required this.date});
  factory DailyInfoList.createEmpty(DateTime date) {
    return DailyInfoList(gamesPlayed: [], date: convertDate(date));
  }
  //if no file for the referred date exists, the file WILL  be created, if it exists
  //a DailyInfoList object will be constructed from the JSON in the file
  factory DailyInfoList.fromDate(DateTime now) {
    String date = convertDate(now);
    File file = File("$main_dir_path/DailyInformation/$date.txt");
    if (!file.existsSync()) {
      // file.createSync();
      DailyInfoList obj = DailyInfoList.createEmpty(now);
      file.writeAsStringSync(jsonEncode(obj.toJson()));
      return obj;
    }
    //Otherwise read file and construct object from JSON
    String ejson = file.readAsStringSync();
    DailyInfoList d_info = DailyInfoList.fromJson(jsonDecode(ejson));
    return d_info; //remove this, placeholder for JSON conversion
  }
  //Writes the updates of play information to the users file system
  //If a file for the given date does not already exist, it will be created.
  void updateInfo() {
    File file = File("$main_dir_path/DailyInformation/$date.txt");
    if (!file.existsSync()) {
      file.createSync();
    }
    // ignore: unnecessary_this
    String data = jsonEncode(this.toJson());
    file.writeAsStringSync(data,
        flush: true); //consider removing flush:true for performance reasons
  }

  //add toJson from JSON here.
  factory DailyInfoList.fromJson(Map<String, dynamic> json) =>
      _$DailyInfoListFromJson(json);

  // Connect the generated  function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DailyInfoListToJson(this);

  void addGamingSession(PlayInformation pl) {
    gamesPlayed.add(pl);
  }

  //Removes a particular game via it's index
  void removeGamingSession(int index) {
    gamesPlayed.removeAt(index);
  }

  //Clear the game list
  void clear() {
    gamesPlayed.clear();
  }

  void deleteFromDisk() {
    File file = File("$main_dir_path/DailyInformation/$date.txt");
    try {
      // ignore: unnecessary_this
      this.clear();
      file.deleteSync();
    } catch (e) {
      //error handling pop-up here, keep in
      //mind that even if the delete fails the data is still cleared.
      //Low-priority, but consider adding a info pop up in case this catch block executes.
    }
  }

  double totalHours() {
    double total = 0;
    for (PlayInformation pl in gamesPlayed) {
      total += pl.hours;
    }
    return total;
  }

  double hoursFor(String name) {
    if (name == "All Games") {
      Logger().w("hoursFor() function used for All Games");
      return totalHours();
    }
    double hoursPlayed = 0;
    gamesPlayed.forEach((game) {
      if (game.game.game_name == name) {
        hoursPlayed += game.hours;
      }
    });
    return hoursPlayed;
  }

  //week range
  static List<DateTime> weekRange(DateTime obj) {
    return getDaysBetween(getMostRecentMonday(obj), getNearestSunday(obj));
  }

  static DateTime getMostRecentMonday(DateTime date) {
    int difference = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: difference));
  }

  static DateTime getNearestSunday(DateTime date) {
    int difference = DateTime.sunday - date.weekday;
    return date.add(Duration(days: difference));
  }

  static List<DateTime> getDaysBetween(DateTime start, DateTime end) {
    List<DateTime> days = [];
    for (DateTime date = start;
        date.isBefore(end) || date.isAtSameMomentAs(end);
        date = date.add(const Duration(days: 1))) {
      days.add(date);
    }
    return days;
  }
}
