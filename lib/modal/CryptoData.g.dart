// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CryptoData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoData _$CryptoDataFromJson(Map<String, dynamic> json) => CryptoData(
    json['symbol'] == null ? "" : json['symbol'] as String,
    json['baseAsset'] == null ? "" : json['baseAsset'] as String,
    json['quoteAsset'] == null ? "" : json['quoteAsset'] as String,
    json['openPrice'] == null ? "" : json['openPrice'] as String,
    json['lowPrice'] == null ? "" : json['lowPrice'] as String,
    json['highPrice'] == null ? "" : json['highPrice'] as String,
    json['lastPrice'] == null ? "" : json['lastPrice'] as String,
    json['volume'] == null ? "" : json['volume'] as String,
    json['bidPrice'] == null ? "" : json['bidPrice'] as String,
    json['askPrice'] == null ? "" : json['askPrice'] as String,
    json['at'] == null ? "" : json['at'] as String,
    json['lastPricePercent'] == null ? "" : json['lastPricePercent'] as String
);

Map<String, dynamic> _$CryptoDataToJson(CryptoData instance) => <String, dynamic>{
  'symbol': instance.symbol,
  'baseAsset': instance.baseAsset,
  'quoteAsset' : instance.quoteAsset,
  'openPrice' : instance.openPrice,
  'lowPrice' : instance.lowPrice,
  'highPrice' : instance.highPrice,
  'lastPrice' : instance.lastPrice,
  'volume' : instance.volume,
  'bidPrice' : instance.bidPrice,
  'askPrice' : instance.askPrice,
  'at' : instance.at,
  'lastPricePercent' : instance.lastPricePercent
};
