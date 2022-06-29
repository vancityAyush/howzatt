part of 'MatchBloc.dart';

class MatchState extends Equatable {
  final int version;


  const MatchState({required this.version});

  MatchState copyWith({
    required int? version
  }) {
    return MatchState(
      version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class MatchInitialState extends MatchState {

  const MatchInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class MatchCompleteState extends MatchState {

  const MatchCompleteState({
    this.context,
    required this.version,
    required this.serverResponse
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;




  @override
  List<Object> get props => [version];
}


class CreateTeamCompleteState extends MatchState {

  const CreateTeamCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;





  @override
  List<Object> get props => [version];
}


class FetchTeamCompleteState extends MatchState {

  const FetchTeamCompleteState({
    this.context,
    required this.version,
    required this.serverResponse
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Map<String,dynamic> serverResponse;




  @override
  List<Object> get props => [version];
}