import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/UserInformationProvider.dart';




class UserInformationRepository{

  final Dio client;

  late UserInformationProvider provider ;

  UserInformationRepository(this.client){
    provider = new UserInformationProvider(client);
  }


  Future<String?> createUser(BuildContext context ,String name,String email,String mobileNumber,String referalCode) => provider.createUser(context,name,email,mobileNumber,referalCode);

  Future<String?> updateUser(BuildContext context ,String name,String gender,String address,Map<String,String> bank,String pan,String aadhaar,String kyc,String fcm_token,String dob) => provider.updateUser(context,name,gender,address,bank,pan,aadhaar,kyc,fcm_token,dob);

  Future<String?> uploadPanImageEvent(BuildContext context ,File panImage) => provider.uploadPanImageEvent(context,panImage);

  Future<String?> uploadAadharFrontImageEvent(BuildContext context ,File aadharFrontImage) => provider.uploadAadharFrontImageEvent(context,aadharFrontImage);

  Future<String?> uploadAadharBackImageEvent(BuildContext context ,File aadharBackImage) => provider.uploadAadharBackImageEvent(context,aadharBackImage);


}