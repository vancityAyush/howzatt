part of 'UserInformationBloc.dart';

class UserInformationState extends Equatable {
  final int version;


  const UserInformationState({required this.version});

  UserInformationState copyWith({
    required int? version
  }) {
    return UserInformationState(
      version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class UserInformationInitialState extends UserInformationState {

  const UserInformationInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class UserInformationCompleteState extends UserInformationState {

  const UserInformationCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;



  @override
  List<Object> get props => [version];
}

class UploadPanImageCompleteState extends UserInformationState {

  const UploadPanImageCompleteState({
    this.context,
    required this.version,
    required this.userDataService
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final UserDataService userDataService;



  @override
  List<Object> get props => [version];
}

class UploadAadharFrontImageCompleteState extends UserInformationState {

  const UploadAadharFrontImageCompleteState({
    this.context,
    required this.version,
    required this.userDataService
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final UserDataService userDataService;



  @override
  List<Object> get props => [version];
}


class UploadAadharBackImageCompleteState extends UserInformationState {

  const UploadAadharBackImageCompleteState({
    this.context,
    required this.version,
    required this.userDataService
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final UserDataService userDataService;



  @override
  List<Object> get props => [version];
}