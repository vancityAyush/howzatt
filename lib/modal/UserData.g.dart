// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
    json['usedreferal'] == null  ? "" : json['usedreferal'].toString(),
    json['referal'] == null ? "" : json['referal'].toString(),
    json['_id'] == null ? "" : json['_id'].toString(),
    json['name'] == null ? "" : json['name'].toString(),
    json['email'] == null ? "" : json['email'].toString(),
    json['phone'] == null ? "" : json['phone'].toString(),
    json['gender'] == null ? "" : json['gender'].toString(),
    json['image'] == null ? "" : json['image'].toString(),
    json['address'] == null ? "" : json['address'].toString(),
    json['bank'] == null ? "" : json['bank'].toString(),
    json['pan'] == null ? "" : json['pan'].toString(),
    json['pan_image'] == null ? "" : json['pan_image'].toString(),
    json['aadhaar_front_image'] == null ? "" : json['aadhaar_front_image'].toString(),
    json['aadhaar_back_image'] == null ? "" : json['aadhaar_back_image'].toString(),
    json['aadhaar'] == null ? "" : json['aadhaar'].toString(),
    json['kyc'] == null ? "" : json['kyc'].toString(),
    json['verified'] == null ? "" : json['verified'].toString(),
    json['fcm_token'] == null ? "" : json['fcm_token'].toString(),
    json['dob'] == null ? "" : json['dob'].toString(),
    json['deleted_at'] == null ? "" : json['deleted_at'].toString(),
    json['created_at'] == null ? "" : json['created_at'].toString(),
    json['updated_at'] == null ? "" : json['updated_at'].toString(),

);

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
  'usedreferal' : instance.usedreferal,
  'referal' : instance.referal,
  'id': instance.id,
  'name': instance.name,
  'email' : instance.email,
  'phone' : instance.phone,
  'gender' : instance.gender,
  'image' : instance.image,
  'address' : instance.address,
  'bank' : instance.bank,
  'pan' : instance.pan,
  'pan_image' : instance.pan_image,
  'aadhaar_front_image' : instance.aadhaar_front_image,
  'aadhaar_back_image' : instance.aadhaar_back_image,
  'aadhaar' : instance.aadhaar,
  'kyc' : instance.kyc,
  'verified' : instance.verified,
  'fcm_token' : instance.fcm_token,
  'dob' : instance.dob,
  'deleted_at' : instance.deleted_at,
  'created_at' : instance.created_at,
  'updated_at' : instance.updated_at,
};
