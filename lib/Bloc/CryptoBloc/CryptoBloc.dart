import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howzatt/Repository/ContestRepository.dart';
import 'package:howzatt/Repository/CryptoRepository.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';

part 'CryptoEvent.dart';
part 'CryptoState.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoRepository repository;


  CryptoBloc(this.repository) : super(const CryptoInitialState(version: 0)){
    on<FetchCryptoEvent>(_handleFetchCryptoEvent, transformer: sequential());
    on<FetchMarketDepthEvent>(_handleFetchMarketDepthEvent, transformer: sequential());
    on<AddtoWatchList>(_handleAddtoWatchList, transformer: sequential());
    on<GetWatchList>(_handleGetWatchList, transformer: sequential());
  }

  void _handleFetchCryptoEvent(FetchCryptoEvent event, Emitter<CryptoState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    Response? serverResponse = await repository.fetchCrypto(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverResponse != null){
        CryptoCompleteState completeState = new CryptoCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
        emit(completeState);
    }
  }

  void _handleFetchMarketDepthEvent(FetchMarketDepthEvent event, Emitter<CryptoState> emit) async{

    if(event.fromWhere == true){
      DialogUtil.showProgressDialog("",event.context);
    }
    Response? serverResponse = await repository.fetchMarketDepth(event.context,event.symbol,event.limit);
    if(event.fromWhere == true){
      DialogUtil.dismissProgressDialog(event.context);
    }
    if(serverResponse != null){
      MarketDepthCompleteState completeState = new MarketDepthCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
      emit(completeState);
    }
  }

  void _handleAddtoWatchList(AddtoWatchList event, Emitter<CryptoState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverResponse = await repository.addToWatchList(event.context,event.code);
    DialogUtil.dismissProgressDialog(event.context);
    Map<String,dynamic> serverResponseDto = jsonDecode(serverResponse.toString());
    if(serverResponseDto["error_code"].toString() == "0"){
      AddtoWatchListCompleteState completeState = new AddtoWatchListCompleteState(context: event.context , version: state.version+1);
      emit(completeState);
    }
    else{

    }
  }

  void _handleGetWatchList(GetWatchList event, Emitter<CryptoState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverResponse = await repository.getWatchList(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    Map<String,dynamic> serverResponseDto = jsonDecode(serverResponse.toString());
    if(serverResponseDto["error_code"].toString() == "0"){
      GetWatchListCompleteState completeState = new GetWatchListCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponseDto);
      emit(completeState);
    }
  }

}
