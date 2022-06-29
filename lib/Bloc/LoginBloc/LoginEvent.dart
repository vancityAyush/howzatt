part of 'LoginBloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SendOTPEvent extends LoginEvent {
  const SendOTPEvent({required this.context  , required this.mobileNumber});

  final String mobileNumber;
  final BuildContext context;



  @override
  List<Object> get props => [context];

}





class MobileNumberChanged extends LoginEvent {
  const MobileNumberChanged({required this.mobileNumber});

  final String mobileNumber;

  @override
  List<Object> get props => [mobileNumber];
}