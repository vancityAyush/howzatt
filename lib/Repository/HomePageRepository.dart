import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/HomePageProvider.dart';
import 'package:howzatt/DataProvider/UserInformationProvider.dart';




class HomePageRepository{

  final Dio client;

  late HomePageProvider provider ;

  HomePageRepository(this.client){
    provider = new HomePageProvider(client);
  }


  Future<String?> getUserDataEvent(BuildContext context) => provider.getUserDataEvent(context);

  Future<Response?> getAuthenticationEvent(BuildContext context) => provider.getAuthenticationEvent(context);

  Future<Response?> getScheduleMatchDataEvent(BuildContext context,String accessToken) => provider.getScheduleMatchDataEvent(context,accessToken);

  Future<String?> updateToken(BuildContext context) => provider.updateToken(context);

  Future<String?> getNotificationData(BuildContext context) => provider.getNotificationData(context);

}