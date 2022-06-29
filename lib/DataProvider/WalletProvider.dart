import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class WalletException implements Exception {

  WalletException(error){
    print(error);
  }
}

class WalletProvider {
  WalletProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<String?> getWalletEvent(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.wallet;
    print("Bearer token===>>"+prefs.getString("token").toString());
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


  Future<String?> addWalletEvent(BuildContext context,String amount , String type,String status,String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.wallet;
    print("addwallet===>>>"+apiUrl.toString());
    print("Bearer token===>>"+prefs.getString("token").toString());
    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "amount": amount,
        "type": type,
        "status" : status,
        "user_id":user_id
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }


  Future<String?> updateWallet(BuildContext context,String responseS,String orderId,String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.wallet+"/"+orderId;

    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {
      var request = await http.Request('PUT',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "status": status,
        "response": responseS,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }


  Future<String?> addBonusWalletEvent(BuildContext context,String amount , String type,String status,String user_id,String remarks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.wallet;
    print("addwallet===>>>"+apiUrl.toString());
    print("Bearer token===>>"+prefs.getString("token").toString());

    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };



    try {

      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "amount": amount,
        "type": type,
        "status" : status,
        "user_id":user_id,
        "remarks":"BONUS"
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }


}
