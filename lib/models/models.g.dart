// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player()
  ..logs = (json['logs'] as List<dynamic>)
      .map((e) => Log.fromJson(e as Map<String, dynamic>))
      .toList()
  ..admin = json['admin'] as bool;

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'logs': instance.logs,
      'admin': instance.admin,
    };

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      name: json['name'] as String? ?? 'Error',
      change: json['change'] as int? ?? 0,
      cancelled: json['cancelled'] as bool? ?? false,
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'name': instance.name,
      'change': instance.change,
      'cancelled': instance.cancelled,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      name: json['name'] as String? ?? 'Error',
      price: json['price'] as int? ?? 0,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };
