import 'package:footballdays/footballService/api_models.dart';
import 'package:footballdays/footballService/football_service.dart';

class FAKEApiService extends FacadeFootballDataService {
  FAKEApiService();

  @override
  Future<Team> getTeam(int teamID) {
    return Future.value(Team("foo", "cresturl", "address", 1909));
  }

  @override
  Future<Football> getPremBestPerformingTeams(
      String startDate, String lastDate) {
    return Future.value(Football(20, [
      MatchGame(Score("AWAY_TEAM"), HomeTeam(20, "Newcastle"),
          AwayTeam(15, "Manchester"))
    ]));
  }
}
