// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameDataModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameDataModel _$GameDataModelFromJson(Map<String, dynamic> json) =>
    GameDataModel(
      game_name: json['game_name'] as String,
      description: json['description'] as String,
      image_path: json['image_path'] as String,
    );

Map<String, dynamic> _$GameDataModelToJson(GameDataModel instance) =>
    <String, dynamic>{
      'game_name': instance.game_name,
      'description': instance.description,
      'image_path': instance.image_path,
    };
