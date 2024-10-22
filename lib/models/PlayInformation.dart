import 'package:gaming_tracker/models/GameDataModel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'PlayInformation.g.dart';

@JsonSerializable()
class PlayInformation {
  GameDataModel game;
  double hours;
  PowerMode performance_mode;
  FanSpeed fan_speed;
  int CPU_FAN;
  int GPU_FAN;
  PlayInformation({
    required this.game,
    required this.hours,
    required this.performance_mode,
    required this.fan_speed,
    this.CPU_FAN = -1,
    this.GPU_FAN = -1,
  });

  // Connect the generated function to the `fromJson`
  // factory.
  factory PlayInformation.fromJson(Map<String, dynamic> json) =>
      _$PlayInformationFromJson(json);

  // Connect the generated  function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlayInformationToJson(this);

  factory PlayInformation.standard(GameDataModel game) => PlayInformation(
      game: game,
      hours: 0,
      performance_mode: PowerMode.Performance,
      fan_speed: FanSpeed.Auto);
}

enum PowerMode {
  Eco,
  Balanced,
  Performance,
  Turbo;
}

enum FanSpeed { Auto, Custom, Max }
