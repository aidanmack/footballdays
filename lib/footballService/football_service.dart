import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footballdays/domain_models.dart';
import 'package:footballdays/footballService/api_models.dart';
import 'package:jiffy/jiffy.dart';

import '../rest_client.dart';

class FootballDataService extends FacadeFootballDataService {
  final RestClient restClient;

  FootballDataService(this.restClient);

  @override
  getPremBestPerformingTeams(String startDate, String lastDate) {
    return restClient.getMatches(startDate, lastDate);
  }

  @override
  Future<Team> getTeam(int teamID) {
    return restClient.getTeam(teamID.toString());
  }
}

abstract class FacadeFootballDataService {
  Future<Football> getPremBestPerformingTeams(
      String startDate, String lastDate);

  Future<Team> getTeam(int teamID);
}

final apiService = Provider<FacadeFootballDataService>(
    (ref) => FootballDataService(restClient));

final getTopPremTeam = FutureProvider<TeamInfo>((ref) async {
  final fromDate = Jiffy().subtract(days: 30).format("yyyy-MM-d");
  final toDate = Jiffy().format("yyyy-MM-d");

  final api = ref.watch(apiService);
  return await api
      .getPremBestPerformingTeams(fromDate, toDate)
      .then((games) => getTeamWithMostWins(games))
      .then((teamId) => api.getTeam(teamId).then((value) {
            return TeamInfo(value.name, value.crestUrl, value.address,
                value.founded.toString(), fromDate, toDate);
          }));
});

int getTeamWithMostWins(Football value) {
  List<int?> ids = value.matches.map((element) {
    if (element.score.winner == "AWAY_TEAM") {
      return element.awayTeam.id;
    } else if (element.score.winner == "HOME_TEAM") {
      return element.homeTeam.id;
    }
  }).toList()
    ..removeWhere((element) => element == null);

  var map = {};
  for (var element in ids) {
    if (!map.containsKey(element)) {
      map[element] = 1;
    } else {
      map[element] += 1;
    }
  }

  List sortedValues = map.values.toList()..sort();
  int popularValue = sortedValues.last;
  List<int> teamIdsThatWonTheMostGames = [];
  map.forEach((k, v) {
    if (v == popularValue) {
      teamIdsThatWonTheMostGames.add(k);
    }
  });
  return teamIdsThatWonTheMostGames.first;
}
