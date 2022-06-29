part of 'ContestBloc.dart';

class ContestState extends Equatable {
  final int version;


  const ContestState({required this.version});

  ContestState copyWith({
    required int? version
  }) {
    return ContestState(
      version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class ContestInitialState extends ContestState {

  const ContestInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class FetchContestCompleteState extends ContestState {

  const FetchContestCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;



  @override
  List<Object> get props => [version];
}

class FetchMyContestCompleteState extends ContestState {

  const FetchMyContestCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;



  @override
  List<Object> get props => [version];
}

class CreateContestCompleteState extends ContestState {

  const CreateContestCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;




  @override
  List<Object> get props => [version];
}


class FetchAllUsersCompleteState extends ContestState {

  const FetchAllUsersCompleteState({
    this.context,
    required this.version,
    required this.usersList,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final List<UserData> usersList;



  @override
  List<Object> get props => [version];
  get getUsersList => usersList;
}


class InviteUserCompleteState extends ContestState {

  const InviteUserCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;




  @override
  List<Object> get props => [version];
}


class FetchContestAllTeamCompleteState extends ContestState {

  const FetchContestAllTeamCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;



  @override
  List<Object> get props => [version];
}

class FetchPlayerDetailAfterMatchCompleteState extends ContestState {

  const FetchPlayerDetailAfterMatchCompleteState({
    this.context,
    required this.version,
    required this.serverResponse,
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;



  @override
  List<Object> get props => [version];
}