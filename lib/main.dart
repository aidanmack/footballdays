import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:footballdays/domain_models.dart';
import 'package:footballdays/footballService/football_service.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowFootBallTeam(),
    );
  }
}

class ShowFootBallTeam extends ConsumerWidget {
  const ShowFootBallTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) => ref.watch(getTopPremTeam).when(
            data: (data) => ShowTeamInfo(data),
            error: (obj, stack) => ShowError(obj, stack),
            loading: () => const ShowLoading()),
      ),
    );
  }
}

class ShowLoading extends StatelessWidget {
  const ShowLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            const Text("LOADING"),
          ],
        ),
      ),
    );
  }
}

class ShowError extends StatelessWidget {
  StackTrace? stack;
  Object obj;
  ShowError(this.obj, this.stack, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("Obj $obj"),
            const SizedBox(
              height: 21,
            ),
            Text("Error Stack $stack"),
          ],
        ),
      ),
    );
  }
}

class ShowTeamInfo extends StatelessWidget {
  final TeamInfo teamInfo;
  const ShowTeamInfo(this.teamInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
                "One of the teams that have won the most matches in the last 30 days",
                textAlign: TextAlign.center),
            const SizedBox(
              height: 21,
            ),
            Text("For dates From ${teamInfo.fromDate} to ${teamInfo.toDate}"),
            const SizedBox(
              height: 21,
            ),
            SvgPicture.network(teamInfo.crestUrl, height: 128.0),
            const SizedBox(
              height: 21,
            ),
            Text(teamInfo.name),
            Text("Founded in: ${teamInfo.founded}"),
            Text(teamInfo.address)
          ],
        ),
      ),
    );
  }
}
