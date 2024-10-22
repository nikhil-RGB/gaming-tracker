// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayInformation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayInformation _$PlayInformationFromJson(Map<String, dynamic> json) =>
    PlayInformation(
      game: GameDataModel.fromJson(json['game'] as Map<String, dynamic>),
      hours: (json['hours'] as num).toDouble(),
      performance_mode:
          $enumDecode(_$PowerModeEnumMap, json['performance_mode']),
      fan_speed: $enumDecode(_$FanSpeedEnumMap, json['fan_speed']),
      CPU_FAN: (json['CPU_FAN'] as num?)?.toInt() ?? -1,
      GPU_FAN: (json['GPU_FAN'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$PlayInformationToJson(PlayInformation instance) =>
    <String, dynamic>{
      'game': instance.game,
      'hours': instance.hours,
      'performance_mode': _$PowerModeEnumMap[instance.performance_mode]!,
      'fan_speed': _$FanSpeedEnumMap[instance.fan_speed]!,
      'CPU_FAN': instance.CPU_FAN,
      'GPU_FAN': instance.GPU_FAN,
    };

const _$PowerModeEnumMap = {
  PowerMode.Eco: 'Eco',
  PowerMode.Balanced: 'Balanced',
  PowerMode.Performance: 'Performance',
  PowerMode.Turbo: 'Turbo',
};

const _$FanSpeedEnumMap = {
  FanSpeed.Auto: 'Auto',
  FanSpeed.Custom: 'Custom',
  FanSpeed.Max: 'Max',
};
