import 'package:json_annotation/json_annotation.dart';

part 'api_models.g.dart';

@JsonSerializable(explicitToJson: true)
class Football {
  int count;
  List<MatchGame> matches;
  Football(this.count, this.matches);

  factory Football.fromJson(Map<String, dynamic> json) =>
      _$FootballFromJson(json);
  Map<String, dynamic> toJson() => _$FootballToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MatchGame {
  Score score;
  HomeTeam homeTeam;
  AwayTeam awayTeam;
  MatchGame(this.score, this.homeTeam, this.awayTeam);

  factory MatchGame.fromJson(Map<String, dynamic> json) =>
      _$MatchGameFromJson(json);
  Map<String, dynamic> toJson() => _$MatchGameToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Score {
  String winner;
  Score(this.winner);

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
  Map<String, dynamic> toJson() => _$ScoreToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HomeTeam {
  int id;
  String name;

  HomeTeam(this.id, this.name);

  factory HomeTeam.fromJson(Map<String, dynamic> json) =>
      _$HomeTeamFromJson(json);
  Map<String, dynamic> toJson() => _$HomeTeamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AwayTeam {
  int id;
  String name;

  AwayTeam(this.id, this.name);

  factory AwayTeam.fromJson(Map<String, dynamic> json) =>
      _$AwayTeamFromJson(json);
  Map<String, dynamic> toJson() => _$AwayTeamToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Team {
  String name;
  String crestUrl;
  String address;
  int founded;

  Team(this.name, this.crestUrl, this.address, this.founded);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
