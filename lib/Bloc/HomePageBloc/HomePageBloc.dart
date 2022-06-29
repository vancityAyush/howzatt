import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howzatt/Repository/HomePageRepository.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'HomePageEvent.dart';
part 'HomePageState.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageRepository repository;


  HomePageBloc(this.repository) : super(const HomePageInitialState(version: 0)){
    on<GetUserDataEvent>(_handleGetUserDataEvent, transformer: sequential());
    on<AuthenticationEvent>(_handleAuthenticationEvent, transformer: sequential());
    on<GetScheduleMatchDataEvent>(_handleGetScheduleMatchDataEvent, transformer: sequential());
    on<UpdateToken>(_handleUpdateToken, transformer: sequential());
    on<FetchNotificationsEvent>(_handleFetchNotificationsEvent, transformer: sequential());
    on<GetNotificationDataEvent>(_handleGetNotificationDataEvent, transformer: sequential());
  }

  void _handleGetUserDataEvent(GetUserDataEvent event, Emitter<HomePageState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.getUserDataEvent(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
        UserData newData = UserData.fromJson(dataDto);
        UserDataService userDataService =  getIt<UserDataService>();
        prefs.setString('userData', jsonEncode(newData));
        userDataService.setUserdata(newData);
        GetUserDataCompleteState completeState = new GetUserDataCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
    }
  }

  void _handleAuthenticationEvent(AuthenticationEvent event, Emitter<HomePageState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    Response? serverAPIResponseDto = await repository.getAuthenticationEvent(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.data["status_code"].toString() == "200"){
      prefs.setString("accesstoken", serverAPIResponseDto.data["auth"]["access_token"].toString());
      AuthenticationCompleteState authenticationCompleteState = new AuthenticationCompleteState(context: event.context,version: state.version+1,accessToken: serverAPIResponseDto.data["auth"]["access_token"].toString());
      emit(authenticationCompleteState);
    }
  }

  void _handleGetScheduleMatchDataEvent(GetScheduleMatchDataEvent event, Emitter<HomePageState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    Response? serverAPIResponseDto = await repository.getScheduleMatchDataEvent(event.context,event.accessToken);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.data["status_code"].toString() == "200"){
      GetMatchDataCompleteState authenticationCompleteState = new GetMatchDataCompleteState(context: event.context,version: state.version+1,response: serverAPIResponseDto);
      emit(authenticationCompleteState);
    }
  }

  void _handleUpdateToken(UpdateToken event, Emitter<HomePageState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.updateToken(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null ){
      //prefs.setString("accesstoken", serverAPIResponseDto.data["auth"]["access_token"].toString());
      HomePageState authenticationCompleteState = new HomePageState(version: state.version+1);
      emit(authenticationCompleteState);
    }
  }

  void _handleGetNotificationDataEvent(GetNotificationDataEvent event, Emitter<HomePageState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.getNotificationData(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        GetNotificationDataCompleteState completeState = new GetNotificationDataCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
    }
  }

  void _handleFetchNotificationsEvent(FetchNotificationsEvent event, Emitter<HomePageState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.updateToken(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null ){
      //prefs.setString("accesstoken", serverAPIResponseDto.data["auth"]["access_token"].toString());
      GetNotificationDataCompleteState authenticationCompleteState = new GetNotificationDataCompleteState(version: state.version+1);
      emit(authenticationCompleteState);
    }
  }

}
