import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class UserInformationException implements Exception {

  UserInformationException(error){
    print(error);
  }
}

class UserInformationProvider {
  UserInformationProvider(this.client);

  final Dio client;

  String apiUrl = "";


  Future<String?> createUser(BuildContext context ,String name,String email,String mobileNumber,String referalCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.users;
    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
    };

    try {

      var request = await http.Request('POST',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "phone": mobileNumber,
        "email": email,
        "name" : name,
        "usedreferal" : referalCode
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> updateUser(BuildContext context ,String name,String gender,String address,Map<String,String> bank,String pan,String aadhaar,String kyc,String fcm_token,String dob) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.users;
    var headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = await http.Request('PUT',Uri.parse(apiUrl));
      request.body = jsonEncode({
        "name": name,
        "gender": gender,
        "address" : address,
        "bank" : jsonEncode(bank),
        "pan":pan,
        "aadhaar" : aadhaar,
        "kyc" : kyc,
        "fcm_token" : fcm_token,
        "dob" :dob
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();
      print("string===updateUser===>>"+string);

      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> uploadPanImageEvent(BuildContext context ,File panImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.update_pan_image;
    var headers = {
      'Content-Type':'multipart/form-data',
      'Accept': 'multipart/form-data',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(http.MultipartFile('file', panImage.readAsBytes().asStream(), panImage.lengthSync(), filename: panImage.path.split("/").last));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();

      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> uploadAadharFrontImageEvent(BuildContext context ,File aadharFrontImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.users;
    var headers = {
      'Content-Type':'multipart/form-data',
      'Accept': 'multipart/form-data',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };

    try {

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(http.MultipartFile('file', aadharFrontImage.readAsBytes().asStream(), aadharFrontImage.lengthSync(), filename: aadharFrontImage.path.split("/").last));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();


      return string;
    } catch (error) {
      return null;
    }
  }

  Future<String?> uploadAadharBackImageEvent(BuildContext context ,File aadharBackimage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiUrl = ApiConstants.BASE_URL+ApiConstants.users;
    var headers = {
      'Content-Type':'multipart/form-data',
      'Accept': 'multipart/form-data',
      'Authorization': 'Bearer '+prefs.getString("token").toString(),
    };
    try {

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(http.MultipartFile('file', aadharBackimage.readAsBytes().asStream(), aadharBackimage.lengthSync(), filename: aadharBackimage.path.split("/").last));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String string = await response.stream.bytesToString();

      return string;
    } catch (error) {
      return null;
    }
  }

}
