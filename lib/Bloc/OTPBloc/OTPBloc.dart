import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/src/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:howzatt/Repository/LoginRepository.dart';
import 'package:howzatt/Repository/OTPRepository.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:howzatt/utils/Validations/MobileNumber.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'OTPEvent.dart';
part 'OTPState.dart';

class OTPBloc extends Bloc<OTPEvent, OTPState> {
  OTPRepository repository;


  OTPBloc(this.repository) : super(const OTPInitialState(version: 0)){
    on<VerifyOTPEvent>(_handleSendOTPEvent, transformer: sequential());
    on<ReSendOTPEvent>(_handleReSendOTPEvent, transformer: sequential());
  }

  void _handleSendOTPEvent(VerifyOTPEvent event, Emitter<OTPState> emit) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.verifyOtp(event.context,event.mobileNumber,event.otpNumber);
    DialogUtil.dismissProgressDialog(event.context);
    var serverResponse = jsonDecode(serverAPIResponseDto.toString());
    if(serverResponse != null && serverResponse["error_code"].toString() == "0" && serverResponse["status"].toString() != "USER NOT FOUND"){
      prefs.setString("token", serverResponse["token"].toString());
      OTPCompleteState completeState = new OTPCompleteState(context: event.context , version: state.version+1,isNotRegistered: false);
      emit(completeState);
    }
    else if(serverResponse != null && serverResponse["error_code"].toString() == "1" && serverResponse["status"].toString() == "USER NOT FOUND"){
      OTPCompleteState completeState = new OTPCompleteState(context: event.context , version: state.version+1,isNotRegistered: true);
      emit(completeState);
    }
  }

  void _handleReSendOTPEvent(ReSendOTPEvent event, Emitter<OTPState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    Response? serverAPIResponseDto = await repository.resendOTP(event.context,event.mobileNumber);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.data["status"].toString() == "200"){
      ResendOTPCompleteState completeState = new ResendOTPCompleteState(context: event.context , version: state.version+1);
      emit(completeState);
    }
  }

}
