import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class MatchException implements Exception {

  MatchException(error){
    print(error);
  }
}

class MatchProvider {
  MatchProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<String?> fetchMatch(BuildContext context,String matchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.fetch_player_detail+matchId+"/"+prefs.get("accesstoken").toString();


    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('GET',Uri.parse(apiUrl));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> saveTeam(BuildContext context,String matchId,String contest_id,String teamName,String user_id,String user_name,String team1,String team2,String team1Count,String team2Count,List<PlayerData>? playerList,String total_credit,String credit_left) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.create_team;

    var teams1 = {
      'name': team1.toString(),
      'players': team1Count.toString()
    };

    var teams2 = {
      'name': team2.toString(),
      'players': team2Count.toString()
    };

    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "contest_id": contest_id,
        "user_id": user_id,
        "user_name" : user_name,
        "team1" : teams1,
        "team2" : teams2,
        "players" : playerList,
        "team_name":teamName,
        "total_credit": total_credit,
        "credit_left":credit_left,
        "match_key":matchId
       }
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> fetchTeam(BuildContext context,String contestId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.contest_team+contestId;


    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('GET',Uri.parse(apiUrl));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> fetchMyMatch(BuildContext context,String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.my_matches+"xyz/"+prefs.get("accesstoken").toString();


    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('GET',Uri.parse(apiUrl));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }
}
