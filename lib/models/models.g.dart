// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player()
  ..logs = (json['logs'] as List<dynamic>)
      .map((e) => Log.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'logs': instance.logs,
    };

Log _$LogFromJson(Map<String, dynamic> json) => Log()
  ..name = json['name'] as String
  ..change = json['change'] as int;

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'name': instance.name,
      'change': instance.change,
    };
