import 'package:gaming_tracker/models/PlayInformation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Preference.g.dart';

//This class stores a users preference for a particular game
@JsonSerializable()
class Preference {
  FanSpeed fans;
  PowerMode pwr;
  int CPU_FAN;
  int GPU_FAN;
  Preference(
      {this.fans = FanSpeed.Auto,
      this.pwr = PowerMode.Balanced,
      this.CPU_FAN = 0,
      this.GPU_FAN = 0});

  // Connect the generated function to the `fromJson`
  // factory.
  factory Preference.fromJson(Map<String, dynamic> json) =>
      _$PreferenceFromJson(json);

  // Connect the generated  function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PreferenceToJson(this);

  List<bool> powerList() {
    List<bool> output = List.generate(3, (index) => false);
    PowerMode control = pwr;
    int index = 0;
    switch (control) {
      case PowerMode.Performance:
        index = 1;
        break;
      case PowerMode.Turbo:
        index = 2;
        break;
      default:
      //No action
    }
    output[index] = true;
    return output;
  }

  List<bool> fanList() {
    List<bool> output = List.generate(3, (index) => false);
    FanSpeed control = fans;
    int index = 0;
    switch (control) {
      case FanSpeed.Max:
        index = 1;
        break;
      case FanSpeed.Custom:
        index = 2;
        break;
      default:
      //No action
    }
    output[index] = true;
    return output;
  }
}
