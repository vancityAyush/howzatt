import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howzatt/Repository/WalletRepository.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';


part 'WalletEvent.dart';
part 'WalletState.dart';


class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletRepository repository;


  WalletBloc(this.repository) : super(const WalletInitialState(version: 0)){
    on<GetWalletEvent>(_handleGetWalletEvent, transformer: sequential());
    on<AddWalletEvent>(_handleAddWalletEvent, transformer: sequential());
    on<AddBonusWalletEvent>(_handleAddBonusWalletEvent, transformer: sequential());
    on<UpdateWallet>(_handleUpdateWallet, transformer: sequential());
  }

  void _handleGetWalletEvent(GetWalletEvent event, Emitter<WalletState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.getWalletEvent(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    var serverResponse = jsonDecode(serverAPIResponseDto.toString());
    if(serverResponse != null && serverResponse["error_code"].toString() == "0" && serverResponse["data"].toString() != "null"){
      GetWalletCompleteState completeState = new GetWalletCompleteState(context: event.context , version: state.version+1,totalWalletAmount:serverResponse["wallet_sum"].toString(),serverResponse: serverResponse);
      emit(completeState);
    }

  }


  void _handleAddWalletEvent(AddWalletEvent event, Emitter<WalletState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.addWalletEvent(event.context,event.amount,event.type,event.status,event.user_id);
    DialogUtil.dismissProgressDialog(event.context);
    var serverResponse = jsonDecode(serverAPIResponseDto.toString());
    print("cfttoken===>>"+serverResponse.toString());
    String cfttoken = "";
    if(serverResponse["payment_data"] != null){
      cfttoken = serverResponse["payment_data"]["cftoken"].toString();
    }
    if(serverResponse != null && serverResponse["error_code"].toString() == "0" && serverResponse["data"].toString() != "null"){
      AddWalletCompleteState completeState = new AddWalletCompleteState(context: event.context , version: state.version+1,cftoken:cfttoken.toString(),orderId:serverResponse["data"]["_id"].toString());
      emit(completeState);
    }

  }

  void _handleUpdateWallet(UpdateWallet event, Emitter<WalletState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.updateWallet(event.context,event.response,event.orderId,event.status);
    DialogUtil.dismissProgressDialog(event.context);
    var serverResponse = jsonDecode(serverAPIResponseDto.toString());
    if(serverResponse != null && serverResponse["error_code"].toString() == "0" && serverResponse["data"].toString() != "null"){
      UpdateWalletCompleteState completeState = new UpdateWalletCompleteState(context: event.context , version: state.version+1,isFromSuccess:event.isFromSuccess);
      emit(completeState);
    }

  }


  void _handleAddBonusWalletEvent(AddBonusWalletEvent event, Emitter<WalletState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.addWalletEvent(event.context,event.amount,event.type,event.status,event.user_id);
    DialogUtil.dismissProgressDialog(event.context);
    var serverResponse = jsonDecode(serverAPIResponseDto.toString());
    print("cfttoken===>>"+serverResponse.toString());
    String cfttoken = "";

    if(serverResponse != null && serverResponse["error_code"].toString() == "0" && serverResponse["data"].toString() != "null"){
      AddBonusWalletWalletCompleteState completeState = new AddBonusWalletWalletCompleteState(context: event.context , version: state.version+1,cftoken:cfttoken.toString(),orderId:serverResponse["data"]["_id"].toString());
      emit(completeState);
    }

  }


}
