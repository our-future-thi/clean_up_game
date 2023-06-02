import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Player {
  List<Log> logs = [];
  bool admin = false;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerToJson(this);

  Player();
}

@JsonSerializable()
class Log {
  String name = 'Error';
  int change = 0;
  bool cancelled = false;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);

  Map<String, dynamic> toJson() => _$LogToJson(this);

  Log({
    this.name = 'Error',
    this.change = 0,
    this.cancelled = false,
  });
}

@JsonSerializable()
class Article {
  String name = 'Error';
  int price = 0;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  Article({
    this.name = 'Error',
    this.price = 0,
  });
}
