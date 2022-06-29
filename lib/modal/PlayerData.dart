import 'package:json_annotation/json_annotation.dart';

part 'PlayerData.g.dart';

@JsonSerializable()
class PlayerData {


  String name;
  String pre_cp;
  String position;
  String team;
  String id;
  String index;
  String type;
  String captain;
  String vc;


  PlayerData(
      this.name,
      this.pre_cp,
      this.position,
      this.team,
      this.id,
      this.index,
      this.type,
      this.captain,
      this.vc
      );

  factory PlayerData.fromJson(Map<String,dynamic> json) => _$PlayerDataFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerDataToJson(this);
}
