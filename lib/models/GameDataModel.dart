import 'package:json_annotation/json_annotation.dart';
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
}
