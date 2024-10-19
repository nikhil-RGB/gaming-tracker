import 'dart:convert';
import 'dart:io';

import 'package:gaming_tracker/main.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logger/logger.dart';
part 'GameDataModel.g.dart';

@JsonSerializable()
class GameDataModel {
  String game_name;
  String description;
  String image_path;
  GameDataModel(
      {required this.game_name,
      required this.description,
      required this.image_path});
  // Connect the generated function to the `fromJson`
  // factory.
  factory GameDataModel.fromJson(Map<String, dynamic> json) =>
      _$GameDataModelFromJson(json);

  // Connect the generated  function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GameDataModelToJson(this);

  //Capture the game data model from the name
  static GameDataModel fromName(String name) {
    String json_source = "";
    try {
      File f = File("$main_dir_path/Games/$name.txt");
      json_source = f.readAsStringSync();
    } catch (e) {
      Logger().w(e.toString());
    }
    return GameDataModel.fromJson(jsonDecode(json_source));
  }
}
