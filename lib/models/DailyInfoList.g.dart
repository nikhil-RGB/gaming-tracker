// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyInfoList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyInfoList _$DailyInfoListFromJson(Map<String, dynamic> json) =>
    DailyInfoList(
      gamesPlayed: (json['gamesPlayed'] as List<dynamic>)
          .map((e) => PlayInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$DailyInfoListToJson(DailyInfoList instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'date': instance.date,
    };
