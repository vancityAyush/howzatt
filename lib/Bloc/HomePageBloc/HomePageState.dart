part of 'HomePageBloc.dart';

class HomePageState extends Equatable {
  final int version;


  const HomePageState({required this.version});

  HomePageState copyWith({
    required int? version
  }) {
    return HomePageState(
      version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class HomePageInitialState extends HomePageState {

  const HomePageInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class GetUserDataCompleteState extends HomePageState {

  const GetUserDataCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;



  @override
  List<Object> get props => [version];
}


class AuthenticationCompleteState extends HomePageState {

  const AuthenticationCompleteState({
    this.context,
    required this.version,
    required this.accessToken
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final String accessToken;



  @override
  List<Object> get props => [version];
}


class GetMatchDataCompleteState extends HomePageState {

  const GetMatchDataCompleteState({
    this.context,
    required this.version,
    required this.response
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final Response response;



  @override
  List<Object> get props => [version];
}

class GetNotificationDataCompleteState extends HomePageState {

  const GetNotificationDataCompleteState({
    this.context,
    required this.version,

  }):super(version: version,);

  final BuildContext? context;
  final int version;




  @override
  List<Object> get props => [version];
}