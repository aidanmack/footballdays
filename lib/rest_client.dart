import 'package:dio/dio.dart';
import 'package:footballdays/footballService/api_models.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.football-data.org/v2/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/competitions/2021/matches")
  Future<Football> getMatches(
      @Query("dateFrom") String from, @Query("dateTo") String to);

  @GET("/teams/{teamId}")
  Future<Team> getTeam(@Path("teamId") String id);
}

final RestClient restClient = RestClient(Dio()
  ..options.headers["X-Auth-Token"] = "caae77ab03294bb48b8a408b39ae4766");
