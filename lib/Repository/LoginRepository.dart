import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/LoginProvider.dart';




class LoginRepository{

  final Dio client;

  late LoginProvider provider ;

  LoginRepository(this.client){
    provider = new LoginProvider(client);
  }


  Future<Response?> sendOTP(BuildContext context ,String mobileNumber) => provider.sendOTP(context,mobileNumber);

}