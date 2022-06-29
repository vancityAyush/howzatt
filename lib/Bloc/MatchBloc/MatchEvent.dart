part of 'MatchBloc.dart';


abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

class FetchMatchEvent extends MatchEvent {
  const FetchMatchEvent({required this.context,required this.matchId,required this.accessToken});

  final BuildContext context;
  final String matchId;
  final String accessToken;


  @override
  List<Object> get props => [context];

}

class SaveTeamEvent extends MatchEvent {
  const SaveTeamEvent({required this.context,required this.matchId,required this.contest_id,required this.teamName,required this.user_id,required this.user_name,required this.team1,required this.team2,required this.team1Count,required this.team2Count,required this.playerList,required this.total_credit,required this.credit_left,});


  final BuildContext context;
  final String matchId;
  final String contest_id;
  final String teamName;
  final String user_id;
  final String user_name;
  final String team1;
  final String team2;
  final String team1Count;
  final String team2Count;
  final List<PlayerData>? playerList;
  final String total_credit;
  final String credit_left;



  @override
  List<Object> get props => [context];

}


class FetchTeamEvent extends MatchEvent {
  const FetchTeamEvent({required this.context,required this.contestId});

  final BuildContext context;
  final String contestId;


  @override
  List<Object> get props => [context];

}


class FetchMyMatchEvent extends MatchEvent {
  const FetchMyMatchEvent({required this.context,required this.userId});

  final BuildContext context;
  final String userId;


  @override
  List<Object> get props => [context];

}