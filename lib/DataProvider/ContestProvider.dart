import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class ContestException implements Exception {

  ContestException(error){
    print(error);
  }
}

class ContestProvider {
  ContestProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<String?> fetchContest(BuildContext context,String matchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.matches+matchId;
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

  Future<String?> createContest(BuildContext context,Map<String,dynamic> match_details,String match_id,String amount,String disable_amount,String max_winners,String max_teams,String teams_joined,String description,String user_id,String type,String status,String max_one_person_teams,String responses,String remarks,List prizebreakups) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };
    apiUrl = ApiConstants.BASE_URL+ApiConstants.matches;

    try {
      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "match_details": match_details,
        "match_id": match_id,
        "amount" : amount,
        "disable_amount" : disable_amount,
        "max_winners" : max_winners,
        "max_teams" : max_teams,
        "teams_joined" : teams_joined,
        "description" : description,
        "user_id" : user_id,
        "type" : "private",
        "status" : "upcoming",
        "max_one_person_teams" : "1",
        "response" : responses,
        "remarks" : remarks,
        "prize_breakup" : prizebreakups
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

  Future<String?> fetchMyContest(BuildContext context,String matchId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.my_contest+matchId;
    print("apiUrl===>>>"+apiUrl.toString());

    print(apiUrl.toString());
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

  Future<String?> fetchAllUsers(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.all_user;

    print(apiUrl.toString());
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

  Future<String?> inviteForMatch(BuildContext context,String contest_id,String invite_to,String invite_by) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };
    apiUrl = ApiConstants.BASE_URL+ApiConstants.invite;

    try {
      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "contest_id": contest_id,
        "invite_to": invite_to,
        "invite_by" : invite_by,
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

  Future<String?> fetchContestAllTeam(BuildContext context,String contestId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.contest_all_team+contestId;
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

  Future<String?> fetchPlayerDetailAfterMatch(BuildContext context,String contestId,String matchKey,String accesstoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.fetch_player_detail_after_match+contestId+"/"+matchKey+"/"+accesstoken;
    print("apiurl====>>"+apiUrl);
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
