import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class CryptoException implements Exception {

  CryptoException(error){
    print(error);
  }
}

class CryptoProvider {
  CryptoProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<Response?> fetchCrypto(BuildContext context) async {

    apiUrl = ApiConstants.cryptoApi;
    try {
      Response response = await client.get(apiUrl);
      return response;
    } catch (error) {
      return null;
    }
  }

  Future<Response?> fetchMarketDepth(BuildContext context,String symbol,String limit) async {

    apiUrl = ApiConstants.depth+symbol+"&limit="+limit;
    try {
      Response response = await client.get(apiUrl);
      return response;
    } catch (error) {
      return null;
    }
  }

  Future<String?> getWatchList(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.watchlist;

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
      print("string====>>"+string.toString());

      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> addToWatchList(BuildContext context,String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.watchlist;

    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {
      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "code": code,
       }
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();
      print("string====>>"+string.toString());

      return string;
    } catch (error) {
      return null;
    }
  }

}
