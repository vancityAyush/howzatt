import 'package:json_annotation/json_annotation.dart';

part 'TokenData.g.dart';

@JsonSerializable()
class TokenData {


  String token;
  String _id;


  TokenData(
      this.token,
      this._id,
      );

  factory TokenData.fromJson(Map<String,dynamic> json) => _$TokenDataFromJson(json);
  Map<String, dynamic> toJson() => _$TokenDataToJson(this);
}
