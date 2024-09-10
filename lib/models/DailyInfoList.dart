import 'dart:convert';
import 'dart:io';

import 'package:gaming_tracker/main.dart';
import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'DailyInfoList.g.dart';

@JsonSerializable()
class DailyInfoList {
  List<PlayInformation> gamesPlayed;
  String date;
  DailyInfoList({required this.gamesPlayed, required this.date});
  factory DailyInfoList.createEmpty(DateTime date) {
    return DailyInfoList(gamesPlayed: [], date: convertDate(date));
  }
  //if no file for the referred date exists, the file will NOT be created, if it exists
  //a DailyInfoList object will be constructed from the JSON in the file
  factory DailyInfoList.fromDate(DateTime now) {
    String date = convertDate(now);
    File file = File("$main_dir_path/DailyInformation/$date.txt");
    if (!file.existsSync()) {
      return DailyInfoList.createEmpty(now);
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
    file.writeAsStringSync(data, flush: true); //consider removing flush:true
  }

  //add toJson from JSON here.
  factory DailyInfoList.fromJson(Map<String, dynamic> json) =>
      _$DailyInfoListFromJson(json);

  // Connect the generated  function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DailyInfoListToJson(this);
}