import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/src/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:howzatt/Repository/LoginRepository.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:howzatt/utils/Validations/MobileNumber.dart';


part 'LoginEvent.dart';
part 'LoginState.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository repository;


  LoginBloc(this.repository) : super(const LoginInitialState(version: 0)){
    on<SendOTPEvent>(_handleSendOTPEvent, transformer: sequential());
  }

  void _handleSendOTPEvent(SendOTPEvent event, Emitter<LoginState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    Response? serverAPIResponseDto = await repository.sendOTP(event.context,event.mobileNumber);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.data["data"] != null){
     Fluttertoast.showToast(
          msg: serverAPIResponseDto.data["data"]["otp"].toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
      LoginCompleteState completeState = new LoginCompleteState(context: event.context , version: state.version+1);
      emit(completeState);
    }

  }

}
