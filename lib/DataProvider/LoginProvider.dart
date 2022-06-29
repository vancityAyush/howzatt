import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/utils/ApiConstants.dart';





class LoginException implements Exception {

  LoginException(error){
    print(error);
  }
}

class LoginProvider {
  LoginProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<Response?> sendOTP(BuildContext context, String mobileNumber) async {

    apiUrl = ApiConstants.BASE_URL+ApiConstants.otp+mobileNumber;

    try {
      Response response = await client.get(apiUrl);
      return response;
    } catch (error) {
      return null;
    }
  }


}
