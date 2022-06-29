import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howzatt/Repository/UserInformationRepository.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'UserInformationEvent.dart';
part 'UserInformationState.dart';

class UserInformationBloc extends Bloc<UserInformationEvent, UserInformationState> {
  UserInformationRepository repository;


  UserInformationBloc(this.repository) : super(const UserInformationInitialState(version: 0)){
     on<CreateUserEvent>(_handleCreateUserEvent, transformer: sequential());
     on<UploadUserProfileEvent>(_handleUploadUserProfileEvent, transformer: sequential());
     on<UploadPanImageEvent>(_handleUploadPanImageEvent, transformer: sequential());
     on<UploadAadharFrontImageEvent>(_handleUploadAadharFrontImageEvent, transformer: sequential());
     on<UploadAadharBackImageEvent>(_handleUploadAadharBackImageEvent, transformer: sequential());
  }

  void _handleCreateUserEvent(CreateUserEvent event, Emitter<UserInformationState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.createUser(event.context,event.name,event.email,event.mobileNumber,event.referalCode);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      print("serverResponse====>>"+serverResponse.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        prefs.setString("token", serverResponse["token"].toString());
        if(serverResponse["data"] != null){
          Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
          UserData newData = UserData.fromJson(dataDto);
          UserDataService userDataService =  getIt<UserDataService>();
          prefs.setString('userData', jsonEncode(newData));
          userDataService.setUserdata(newData);
        }
        UserInformationCompleteState completeState = new UserInformationCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
      else{

      }
    }
  }

  void _handleUploadUserProfileEvent(UploadUserProfileEvent event, Emitter<UserInformationState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.updateUser(event.context,event.name,event.gender,event.address,event.bank,event.pan,event.aadhaar,event.kyc,event.fcm_token,event.dob);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      print("serverResponse====>>"+serverResponse.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        //prefs.setString("token", serverResponse["token"].toString());
        if(serverResponse["data"] != null){
          Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
          UserData newData = UserData.fromJson(dataDto);
          UserDataService userDataService =  getIt<UserDataService>();
          prefs.setString('userData', jsonEncode(newData));
          userDataService.setUserdata(newData);
        }
        UserInformationCompleteState completeState = new UserInformationCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
      else{

      }
    }
  }

  void _handleUploadPanImageEvent(UploadPanImageEvent event, Emitter<UserInformationState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.uploadPanImageEvent(event.context,event.panCardImage);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      UserDataService userDataService =  getIt<UserDataService>();
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        prefs.setString("token", serverResponse["token"].toString());
        if(serverResponse["data"] != null){
          Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
          UserData newData = UserData.fromJson(dataDto);
          prefs.setString('userData', jsonEncode(newData));
          userDataService.setUserdata(newData);
        }
        UploadPanImageCompleteState completeState = new UploadPanImageCompleteState(context: event.context , version: state.version+1,userDataService: userDataService);
        emit(completeState);
      }
      else{

      }
    }
  }

  void _handleUploadAadharFrontImageEvent(UploadAadharFrontImageEvent event, Emitter<UserInformationState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.uploadAadharFrontImageEvent(event.context,event.aadharFrontImage);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      UserDataService userDataService =  getIt<UserDataService>();
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        prefs.setString("token", serverResponse["token"].toString());
        if(serverResponse["data"] != null){
          Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
          UserData newData = UserData.fromJson(dataDto);
          prefs.setString('userData', jsonEncode(newData));
          userDataService.setUserdata(newData);
        }
        UploadAadharFrontImageCompleteState completeState = new UploadAadharFrontImageCompleteState(context: event.context , version: state.version+1,userDataService: userDataService);
        emit(completeState);
      }
      else{

      }
    }
  }

  void _handleUploadAadharBackImageEvent(UploadAadharBackImageEvent event, Emitter<UserInformationState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.uploadAadharBackImageEvent(event.context,event.aadharBackImage);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      var serverResponse = jsonDecode(serverAPIResponseDto.toString());
      UserDataService userDataService =  getIt<UserDataService>();
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        prefs.setString("token", serverResponse["token"].toString());
        if(serverResponse["data"] != null){
          Map<String, dynamic> dataDto = serverResponse["data"] as Map<String, dynamic>;
          UserData newData = UserData.fromJson(dataDto);
          prefs.setString('userData', jsonEncode(newData));
          userDataService.setUserdata(newData);
        }
        UploadAadharBackImageCompleteState completeState = new UploadAadharBackImageCompleteState(context: event.context , version: state.version+1,userDataService: userDataService);
        emit(completeState);
      }
      else{

      }
    }
  }

}
