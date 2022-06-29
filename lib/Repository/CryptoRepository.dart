import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/CryptoProvider.dart';
import 'package:howzatt/DataProvider/OTPProvider.dart';




class CryptoRepository{

  final Dio client;

  late CryptoProvider provider ;

  CryptoRepository(this.client){
    provider = new CryptoProvider(client);
  }


  Future<Response?> fetchCrypto(BuildContext context) => provider.fetchCrypto(context);

  Future<Response?> fetchMarketDepth(BuildContext context,String symbol,String limit) => provider.fetchMarketDepth(context,symbol,limit);

  Future<String?> addToWatchList(BuildContext context,String code) => provider.addToWatchList(context,code);

  Future<String?> getWatchList(BuildContext context) => provider.getWatchList(context);

}