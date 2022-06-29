import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:http/http.dart' as http;




class OTPException implements Exception {

  OTPException(error){
    print(error);
  }
}

class OTPProvider {
  OTPProvider(this.client);

  final Dio client;
  var headers = {'Content-Type':'application/json'};
  String apiUrl = "";


  Future<String?> verifyOTP(BuildContext context, String mobileNumber,String otpNumber) async {

    apiUrl = ApiConstants.BASE_URL+ApiConstants.login;

    try {
      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "phone": mobileNumber,
        "otp": otpNumber,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();
      return string;
    } catch (error) {
      return null;
    }
  }

  Future<Response?> resendOTP(BuildContext context, String mobileNumber) async {

    apiUrl = ApiConstants.BASE_URL+ApiConstants.otp+mobileNumber;
    try {
      Response response = await client.get(apiUrl);
      return response;
    } catch (error) {
      return null;
    }
  }

}
