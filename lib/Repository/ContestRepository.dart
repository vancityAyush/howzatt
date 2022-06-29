import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/ContestProvider.dart';




class ContestRepository{

  final Dio client;

  late ContestProvider provider ;

  ContestRepository(this.client){
    provider = new ContestProvider(client);
  }


  Future<String?> fetchContest(BuildContext context,String matchId) => provider.fetchContest(context,matchId);

  Future<String?> inviteForMatch(BuildContext context,String contest_id,String invite_to,String invite_by) => provider.inviteForMatch(context,contest_id,invite_to,invite_by);

  Future<String?> fetchMyContest(BuildContext context,String matchId) => provider.fetchMyContest(context,matchId);

  Future<String?> fetchAllUsers(BuildContext context) => provider.fetchAllUsers(context);

  Future<String?> createContest(BuildContext context,Map<String,dynamic> match_details,String match_id,String amount,String disable_amount,String max_winners,String max_teams,String teams_joined,String description,String user_id,String type,String status,String max_one_person_teams,String response,String remarks,List prizebreakups) => provider.createContest(context,match_details,match_id,amount,disable_amount,max_winners,max_teams,teams_joined,description,user_id,type,status,max_one_person_teams,response,remarks,prizebreakups);

  Future<String?> fetchContestAllTeam(BuildContext context,String contestId) => provider.fetchContestAllTeam(context,contestId);

  Future<String?> fetchPlayerDetailAfterMatch(BuildContext context,String contestId,String matchKey,String accesstoken) => provider.fetchPlayerDetailAfterMatch(context,contestId,matchKey,accesstoken);

}