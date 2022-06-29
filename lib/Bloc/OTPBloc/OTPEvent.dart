part of 'OTPBloc.dart';


abstract class OTPEvent extends Equatable {
  const OTPEvent();

  @override
  List<Object> get props => [];
}

class VerifyOTPEvent extends OTPEvent {
  const VerifyOTPEvent({required this.context  , required this.mobileNumber,required this.otpNumber});

  final String mobileNumber;
  final BuildContext context;
  final String otpNumber;



  @override
  List<Object> get props => [context];

}


class ReSendOTPEvent extends OTPEvent {
  const ReSendOTPEvent({required this.context  , required this.mobileNumber});

  final String mobileNumber;
  final BuildContext context;



  @override
  List<Object> get props => [context];

}

