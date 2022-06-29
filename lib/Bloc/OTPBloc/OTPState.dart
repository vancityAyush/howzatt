part of 'OTPBloc.dart';

class OTPState extends Equatable {
  final int version;


  const OTPState({required this.version});

  OTPState copyWith({
    required int? version
  }) {
    return OTPState(
        version: version ?? this.version,
    );
  }


  @override
  List<Object> get props => [version];

}



class OTPInitialState extends OTPState {

  const OTPInitialState({
    this.context,
    required this.version,
  }):super(version: version);

  final BuildContext? context;
  final  int version;


  @override
  List<Object> get props => [version];
}

class OTPCompleteState extends OTPState {

  const OTPCompleteState({
    this.context,
    required this.version,
    required this.isNotRegistered
  }):super(version: version,);

  final BuildContext? context;
  final int version;
  final bool isNotRegistered;



  @override
  List<Object> get props => [version];
}

class ResendOTPCompleteState extends OTPState {

  const ResendOTPCompleteState({
    this.context,
    required this.version,
  }):super(version: version,);

  final BuildContext? context;
  final int version;



  @override
  List<Object> get props => [version];
}

