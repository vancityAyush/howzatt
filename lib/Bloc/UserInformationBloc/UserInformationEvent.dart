part of 'UserInformationBloc.dart';


abstract class UserInformationEvent extends Equatable {
  const UserInformationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends UserInformationEvent {
  const CreateUserEvent({required this.context  , required this.mobileNumber,required this.email,required this.name,required this.referalCode});

  final String mobileNumber;
  final BuildContext context;
  final String email;
  final String name;
  final String referalCode;



  @override
  List<Object> get props => [context];

}


class UploadUserProfileEvent extends UserInformationEvent {
  const UploadUserProfileEvent({required this.context  , required this.name,
    required this.gender,required this.address,required this.bank,
    required this.pan,required this.aadhaar,required this.kyc,required this.fcm_token,required this.dob
  });

  final BuildContext context;
  final String name;
  final String gender;
  final String address;
  final Map<String,String> bank;
  final String pan;
  final String aadhaar;
  final String kyc;
  final String fcm_token;
  final String dob;

  @override
  List<Object> get props => [context];

}


class UploadPanImageEvent extends UserInformationEvent {
  const UploadPanImageEvent({required this.context  , required this.panCardImage});

  final BuildContext context;
  final File panCardImage;

  @override
  List<Object> get props => [context];

}

class UploadAadharFrontImageEvent extends UserInformationEvent {
  const UploadAadharFrontImageEvent({required this.context  , required this.aadharFrontImage});

  final BuildContext context;
  final File aadharFrontImage;

  @override
  List<Object> get props => [context];

}

class UploadAadharBackImageEvent extends UserInformationEvent {
  const UploadAadharBackImageEvent({required this.context  , required this.aadharBackImage});

  final BuildContext context;
  final File aadharBackImage;

  @override
  List<Object> get props => [context];

}
