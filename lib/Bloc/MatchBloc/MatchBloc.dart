import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:howzatt/Repository/ContestRepository.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'MatchEvent.dart';
part 'MatchState.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchRepository repository;


  MatchBloc(this.repository) : super(const MatchInitialState(version: 0)){
    on<FetchMatchEvent>(_handleFetchMatchEvent, transformer: sequential());
    on<SaveTeamEvent>(_handleSaveTeamEvent, transformer: sequential());
    on<FetchTeamEvent>(_handleFetchTeamEvent, transformer: sequential());
    on<FetchMyMatchEvent>(_handleFetchMyMatchEvent, transformer: sequential());
  }

  void _handleFetchMatchEvent(FetchMatchEvent event, Emitter<MatchState> emit) async{
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchMatch(event.context,event.matchId);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        MatchCompleteState completeState = new MatchCompleteState(context: event.context , version: state.version+1,serverResponse: serverResponse);
        emit(completeState);
      }
    }
  }

  void _handleSaveTeamEvent(SaveTeamEvent event, Emitter<MatchState> emit) async{
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.saveTeam(event.context,event.matchId,event.contest_id,event.teamName,event.user_id,event.user_name,event.team1,event.team2,event.team1Count,event.team2Count,event.playerList,event.total_credit,event.credit_left);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        CreateTeamCompleteState completeState = new CreateTeamCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
    }
  }

  void _handleFetchTeamEvent(FetchTeamEvent event, Emitter<MatchState> emit) async{
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchTeam(event.context,event.contestId);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        FetchTeamCompleteState completeState = new FetchTeamCompleteState(context: event.context , version: state.version+1,serverResponse: serverResponse);
        emit(completeState);
      }
    }
  }

  void _handleFetchMyMatchEvent(FetchMyMatchEvent event, Emitter<MatchState> emit) async{
    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchMyMatch(event.context,event.userId);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        MatchCompleteState completeState = new MatchCompleteState(context: event.context , version: state.version+1,serverResponse: serverResponse);
        emit(completeState);
      }
    }
  }
}
