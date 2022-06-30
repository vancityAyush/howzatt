import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageException implements Exception {
  HomePageException(error) {
    print(error);
  }
}

class HomePageProvider {
  HomePageProvider(this.client);

  final Dio client;

  String apiUrl = "";

  Future<String?> getUserDataEvent(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL + ApiConstants.users;
    print("token===>>" + prefs.getString("token").toString());
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString("token").toString(),
    };

    try {
      var request = await http.Request('PUT', Uri.parse(apiUrl));
      request.body = jsonEncode({
        "fcm_token": prefs.getString("fcm_token").toString(),
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();

      return string;
    } catch (error) {
      return null;
    }
  }

  Future<Response?> getAuthenticationEvent(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.auth;

    Map data = {
      "access_key": ApiConstants.access_key,
      "secret_key": ApiConstants.secret_key,
      "app_id": ApiConstants.app_id,
      "device_id": ApiConstants.device_id,
    };

    try {
      Response response = await client.post(
        apiUrl,
        data: jsonEncode(data),
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
      );

      return response;
    } catch (error) {
      return null;
    }
  }

  Future<Response?> getScheduleMatchDataEvent(
      BuildContext context, String accessToken,
      {DateTime? date}) async {
    apiUrl = ApiConstants.schedule + accessToken;
    print("apiUrl===kkk>>>" + apiUrl);

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String? dateStr = date != null ? dateFormat.format(date) : null;
    try {
      Response response = await client.get(apiUrl, queryParameters: {
        "date": dateStr,
      });
      return response;
    } catch (error) {
      return null;
    }
  }

  Future<String?> updateToken(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL + ApiConstants.users;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString("token").toString(),
    };

    Map data = {
      "fcm_token": prefs.getString("fcm_token").toString(),
    };

    try {
      var request =
          await http.put(Uri.parse(apiUrl), body: data, headers: headers);
      print("request===>>>" + request.toString());

      return "string";
    } catch (error) {
      return null;
    }
  }

  Future<String?> getNotificationData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL + ApiConstants.fetch_notifictaions;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString("token").toString(),
    };

    try {
      var request = await http.Request('POST', Uri.parse(apiUrl));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();

      return string;
    } catch (error) {
      return null;
    }
  }
}
