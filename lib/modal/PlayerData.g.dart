// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PlayerData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerData _$PlayerDataFromJson(Map<String, dynamic> json) => PlayerData(
  json['name'] == null ? "" : json['name'] as String,
  json['pre_cp'] == null ? "" : json['pre_cp'] as String,
  json['position'] == null ? "" : json['position'] as String,
  json['team'] == null ? "" : json['team'] as String,
  json['id'] == null ? "" : json['id'] as String,
  json['index'] == null ? "" : json['index'] as String,
  json['type'] == null ? "" : json['type'] as String,
  json['captain'] == null ? "" : json['captain'] as String,
  json['vc'] == null ? "" : json['vc'] as String
);

Map<String, dynamic> _$PlayerDataToJson(PlayerData instance) => <String, dynamic>{
  'name': instance.name,
  'pre_cp': instance.pre_cp,
  'position' : instance.position,
  'team' : instance.team,
  'id' : instance.id,
  'index' : instance.index,
  'type' : instance.type,
  'captain' : instance.captain,
  'vc' : instance.vc
};
