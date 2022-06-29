import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:howzatt/DataProvider/WalletProvider.dart';




class WalletRepository{

  final Dio client;

  late WalletProvider provider ;

  WalletRepository(this.client){
    provider = new WalletProvider(client);
  }


  Future<String?> getWalletEvent(BuildContext context) => provider.getWalletEvent(context);

  Future<String?> addWalletEvent(BuildContext context,String amount , String type,String status,String user_id) => provider.addWalletEvent(context,amount,type,status,user_id);

  Future<String?> updateWallet(BuildContext context,String response,String orderId,String status) => provider.updateWallet(context,response,orderId,status);

  Future<String?> addBonusWalletEvent(BuildContext context,String amount , String type,String status,String user_id,String remarks) => provider.addBonusWalletEvent(context,amount,type,status,user_id,remarks);

}