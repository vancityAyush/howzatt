import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/LoginProvider.dart';
import 'package:howzatt/DataProvider/OTPProvider.dart';




class OTPRepository{

  final Dio client;

  late OTPProvider provider ;

  OTPRepository(this.client){
    provider = new OTPProvider(client);
  }


  Future<String?> verifyOtp(BuildContext context ,String mobileNumber,String otpNumber) => provider.verifyOTP(context,mobileNumber,otpNumber);

  Future<Response?> resendOTP(BuildContext context ,String mobileNumber) => provider.resendOTP(context,mobileNumber);
}