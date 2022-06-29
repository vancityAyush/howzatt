part of 'LoginBloc.dart';

class LoginState extends Equatable {
  final int version;
  final MobileNumber mobileNumber;
  final FormzStatus? status;


  const LoginState({required this.version,this.mobileNumber = const MobileNumber.pure(),this.status});

  LoginState copyWith({
    MobileNumber? mobileNumber,
    FormzStatus? status,
    required int? version
  }) {
    return LoginState(
        version: version ?? this.version,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        status: status ?? this.status
    );
  }


  @override
  List<Object> get props => [version];

}



class LoginInitialState extends LoginState {

  const LoginInitialState({
    this.context,
    required this.version,
    this.status
  }):super(version: version);

  final BuildContext? context;
  final  int version;
  final FormzStatus? status;

  @override
  List<Object> get props => [version];
}

class LoginCompleteState extends LoginState {

  const LoginCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;


  @override
  List<Object> get props => [version];
}

