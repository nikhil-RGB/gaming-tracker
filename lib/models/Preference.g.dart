// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preference _$PreferenceFromJson(Map<String, dynamic> json) => Preference(
      fans:
          $enumDecodeNullable(_$FanSpeedEnumMap, json['fans']) ?? FanSpeed.Auto,
      pwr: $enumDecodeNullable(_$PowerModeEnumMap, json['pwr']) ??
          PowerMode.Balanced,
      CPU_FAN: (json['CPU_FAN'] as num?)?.toInt() ?? 0,
      GPU_FAN: (json['GPU_FAN'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PreferenceToJson(Preference instance) =>
    <String, dynamic>{
      'fans': _$FanSpeedEnumMap[instance.fans]!,
      'pwr': _$PowerModeEnumMap[instance.pwr]!,
      'CPU_FAN': instance.CPU_FAN,
      'GPU_FAN': instance.GPU_FAN,
    };

const _$FanSpeedEnumMap = {
  FanSpeed.Auto: 'Auto',
  FanSpeed.Custom: 'Custom',
  FanSpeed.Max: 'Max',
};

const _$PowerModeEnumMap = {
  PowerMode.Eco: 'Eco',
  PowerMode.Balanced: 'Balanced',
  PowerMode.Performance: 'Performance',
  PowerMode.Turbo: 'Turbo',
};
