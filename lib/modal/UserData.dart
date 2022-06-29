import 'package:howzatt/modal/TokenData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserData.g.dart';

@JsonSerializable()
class UserData {

  String usedreferal;
  String referal;
  String id;
  String name;
  String email;
  String phone;
  String gender;
  String image;
  String address;
  String bank;
  String pan;
  String pan_image;
  String aadhaar_front_image;
  String aadhaar_back_image;
  String aadhaar;
  String kyc;
  String verified;
  String fcm_token;
  String dob;
  String deleted_at;
  String created_at;
  String updated_at;



  UserData(
      this.usedreferal,
      this.referal,
      this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.image,
      this.address,
      this.bank,
      this.pan,
      this.pan_image,
      this.aadhaar_front_image,
      this.aadhaar_back_image,
      this.aadhaar,
      this.kyc,
      this.verified,
      this.fcm_token,
      this.dob,
      this.deleted_at,
      this.created_at,
      this.updated_at,
      );

  factory UserData.fromJson(Map<String,dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
