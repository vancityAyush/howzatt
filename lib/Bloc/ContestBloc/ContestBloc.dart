import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/Repository/ContestRepository.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';

part 'ContestEvent.dart';
part 'ContestState.dart';

class ContestBloc extends Bloc<ContestEvent, ContestState> {
  ContestRepository repository;


  ContestBloc(this.repository) : super(const ContestInitialState(version: 0)){
    on<FetchContestEvent>(_handleFetchContestEvent, transformer: sequential());
    on<FetchMyContestEvent>(_handleFetchMyContestEvent, transformer: sequential());
    on<FetchAllUsersEvent>(_handleFetchAllUsersEvent, transformer: sequential());
    on<CreateContestEvent>(_handleCreateContestEvent, transformer: sequential());
    on<InviteForMatchEvent>(_handleInviteForMatchEvent, transformer: sequential());
    on<FetchContestAllTeamEvent>(_handleFetchContestAllTeamEvent, transformer: sequential());
    on<FetchPlayerDetailAfterMatchEvent>(_handleFetchPlayerDetailAfterMatchEvent, transformer: sequential());
  }

  void _handleFetchContestEvent(FetchContestEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchContest(event.context,event.matchId);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        FetchContestCompleteState completeState = new FetchContestCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
        emit(completeState);
      }
    }
  }

  void _handleCreateContestEvent(CreateContestEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.createContest(event.context,event.match_details,event.match_id,event.amount,event.disable_amount,event.max_winners,event.max_teams,event.teams_joined,event.description,event.user_id,event.type,event.status,event.max_one_person_teams,event.response,event.remarks,event.prizebreakups);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        Fluttertoast.showToast(
            msg: "Contest created Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.back();
        CreateContestCompleteState completeState = new CreateContestCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
    }
  }

  void _handleFetchMyContestEvent(FetchMyContestEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchMyContest(event.context,event.matchId);
    DialogUtil.dismissProgressDialog(event.context);
    print(serverAPIResponseDto.toString());
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        FetchMyContestCompleteState completeState = new FetchMyContestCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
        emit(completeState);
      }
    }
  }

  void _handleFetchAllUsersEvent(FetchAllUsersEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchAllUsers(event.context);
    DialogUtil.dismissProgressDialog(event.context);
    print(serverAPIResponseDto.toString());
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        List<UserData> usersList = (serverResponse["data"] as List).map((itemWord) => UserData.fromJson(itemWord)).toList();
        FetchAllUsersCompleteState completeState = new FetchAllUsersCompleteState(context: event.context , version: state.version+1,usersList:usersList);
        emit(completeState);
      }
    }
  }

  void _handleInviteForMatchEvent(InviteForMatchEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.inviteForMatch(event.context,event.contest_id,event.invite_to,event.invite_by);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        Fluttertoast.showToast(
            msg: "User Invited Successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0
        );
        InviteUserCompleteState completeState = new InviteUserCompleteState(context: event.context , version: state.version+1);
        emit(completeState);
      }
    }
  }

  void _handleFetchContestAllTeamEvent(FetchContestAllTeamEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchContestAllTeam(event.context,event.contestId);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        FetchContestAllTeamCompleteState completeState = new FetchContestAllTeamCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
        emit(completeState);
      }
    }
  }

  void _handleFetchPlayerDetailAfterMatchEvent(FetchPlayerDetailAfterMatchEvent event, Emitter<ContestState> emit) async{

    DialogUtil.showProgressDialog("",event.context);
    String? serverAPIResponseDto = await repository.fetchPlayerDetailAfterMatch(event.context,event.contestId,event.matchKey,event.accesstoken);
    DialogUtil.dismissProgressDialog(event.context);
    if(serverAPIResponseDto != null && serverAPIResponseDto.toString() != "Unauthorized"){
      Map<String,dynamic> serverResponse = jsonDecode(serverAPIResponseDto.toString());
      if(serverResponse != null && serverResponse["error_code"].toString() == "0"){
        FetchPlayerDetailAfterMatchCompleteState completeState = new FetchPlayerDetailAfterMatchCompleteState(context: event.context , version: state.version+1,serverResponse:serverResponse);
        emit(completeState);
      }
    }
  }
}
