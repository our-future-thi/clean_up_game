import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Player {
  List<Log> logs = [];

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Player();
}

@JsonSerializable()
class Log {
  String name = 'Error';
  int change = 0;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);

  Log({
    this.name = 'Error',
    this.change = 0,
  });
}
