part of 'ContestBloc.dart';


abstract class ContestEvent extends Equatable {
  const ContestEvent();

  @override
  List<Object> get props => [];
}

class FetchContestEvent extends ContestEvent {
  const FetchContestEvent({required this.context,required this.matchId});

  final BuildContext context;
  final String matchId;


  @override
  List<Object> get props => [context];

}


class CreateContestEvent extends ContestEvent {
  const CreateContestEvent({required this.context, required this.match_details,required this.match_id,required this.amount,required this.disable_amount,required this.max_winners,required this.max_teams,required this.teams_joined,required this.description,required this.user_id,required this.type,required this.status,required this.max_one_person_teams,required this.response,required this.remarks,required this.prizebreakups});

  final BuildContext context;
  final Map<String,dynamic> match_details;
  final String match_id,amount,disable_amount,max_winners,max_teams,teams_joined,description,user_id,type,status,max_one_person_teams,response,remarks;
  final List prizebreakups;


  @override
  List<Object> get props => [context];

}


class FetchMyContestEvent extends ContestEvent {
  const FetchMyContestEvent({required this.context,required this.matchId});

  final BuildContext context;
  final String matchId;


  @override
  List<Object> get props => [context];

}

class FetchAllUsersEvent extends ContestEvent {
  const FetchAllUsersEvent({required this.context});

  final BuildContext context;



  @override
  List<Object> get props => [context];

}


class InviteForMatchEvent extends ContestEvent {
  const InviteForMatchEvent({required this.context,required this.contest_id,required this.invite_to,required this.invite_by});

  final BuildContext context;
  final String contest_id;
  final String invite_to;
  final String invite_by;


  @override
  List<Object> get props => [context];

}


class FetchContestAllTeamEvent extends ContestEvent {
  const FetchContestAllTeamEvent({required this.context,required this.contestId});

  final BuildContext context;
  final String contestId;


  @override
  List<Object> get props => [context];

}

class FetchPlayerDetailAfterMatchEvent extends ContestEvent {
  const FetchPlayerDetailAfterMatchEvent({required this.context,required this.contestId,required this.matchKey,required this.accesstoken});

  final BuildContext context;
  final String contestId , matchKey ,accesstoken;


  @override
  List<Object> get props => [context];

}

