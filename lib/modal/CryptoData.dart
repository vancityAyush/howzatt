import 'package:json_annotation/json_annotation.dart';

part 'CryptoData.g.dart';

@JsonSerializable()
class CryptoData {


  String symbol;
  String baseAsset;
  String quoteAsset;
  String openPrice;
  String lowPrice;
  String highPrice;
  String lastPrice;
  String volume;
  String bidPrice;
  String askPrice;
  String at;
  String lastPricePercent;


  CryptoData(
      this.symbol,
      this.baseAsset,
      this.quoteAsset,
      this.openPrice,
      this.lowPrice,
      this.highPrice,
      this.lastPrice,
      this.volume,
      this.bidPrice,
      this.askPrice,
      this.at,
      this.lastPricePercent
      );

  factory CryptoData.fromJson(Map<String,dynamic> json) => _$CryptoDataFromJson(json);
  Map<String, dynamic> toJson() => _$CryptoDataToJson(this);
}
