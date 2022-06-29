import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/MatchProvider.dart';
import 'package:howzatt/modal/PlayerData.dart';




class MatchRepository{

  final Dio client;

  late MatchProvider provider ;

  MatchRepository(this.client){
    provider = new MatchProvider(client);
  }


  Future<String?> fetchMatch(BuildContext context,String matchId) => provider.fetchMatch(context,matchId);

  Future<String?> saveTeam(BuildContext context,String matchId,String contest_id,String teamName,String user_id,String user_name,String team1,team2,team1Count,team2Count,List<PlayerData>? playerList,String total_credit,String credit_left) => provider.saveTeam(context,matchId,contest_id,teamName,user_id,user_name,team1,team2,team1Count,team2Count,playerList,total_credit,credit_left);

  Future<String?> fetchTeam(BuildContext context,String contestId) => provider.fetchTeam(context,contestId);

  Future<String?> fetchMyMatch(BuildContext context,String userId) => provider.fetchMyMatch(context,userId);
}