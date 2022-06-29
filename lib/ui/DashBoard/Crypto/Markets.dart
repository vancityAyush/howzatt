import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/modal/CryptoData.dart';
import 'package:howzatt/modal/WatchListData.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../Bloc/CryptoBloc/CryptoBloc.dart';
import '../../../Repository/CryptoRepository.dart';


class Markets extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CryptoBloc(CryptoRepository(dio.Dio())),
            ),
          ],
          child: MarketsStatetful(),
        )
    );
  }
}

class MarketsStatetful extends StatefulWidget {


  @override
  _MarketsState createState() => _MarketsState();
}


class _MarketsState extends State<MarketsStatetful> with SingleTickerProviderStateMixin{

  late TabController _controller;
  int _selectedIndex = 0;
  dio.Response? serverResponse,marketDepthResponse;
  bool assPrice = true , disPrice = false;
  bool assChangePrice = true , disChangePrice = false;
  bool assPrice1 = true , disPrice1 = false;
  bool assChangePrice1 = true , disChangePrice1 = false;
  List<CryptoData> cryptoDataList = new List.empty(growable: true);
  List<CryptoData> searchCryptoDataList = new List.empty(growable: true);
  List<WatchListData> watchList = new List.empty(growable: true);
  late CryptoData cryptoData;
  late BuildContext cryptoContext;
  Map<String,dynamic>? watchListResponse;
  List<CryptoData> watchListCryptoDataList = new List.empty(growable: true);
  List<CryptoData> searchWatchListCryptoDataList = new List.empty(growable: true);
  bool fromMyWatchList = false;
  bool sheetopen = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    BlocProvider.of<CryptoBloc>(context).add(FetchCryptoEvent(context: context));
    BlocProvider.of<CryptoBloc>(context).add(GetWatchList(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Container(
            color: Colors.black,
            height: 60.h,
            child: Padding(
                padding: EdgeInsets.only(top: 25.h,bottom: 5.h,left: 20.w),
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: Image.asset('assets/images/back_arrow.png', width: 50.w ,height: 20.h,color: Colors.white,),
                    ),
                    SizedBox(
                      width: 0.h,
                    ),
                    Text(
                      'Markets',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'RoMedium',
                          color: Colors.white,
                          fontSize: 18.sp
                      ),
                    ),
                  ],
                )
            )
        ),
      ),
      body: BlocListener<CryptoBloc,CryptoState>(
        listener: (context,state){
          if(state is CryptoCompleteState){
            setState((){
              cryptoContext = context;
              serverResponse = state.serverResponse;
              getData(serverResponse);
            });
          }
          if(state is MarketDepthCompleteState){
            setState((){
              marketDepthResponse = state.serverResponse;
              if(sheetopen == false)
              showPreViewScreen(context,cryptoData);
            });
          }
          if(state is GetWatchListCompleteState){
            setState((){
              watchListResponse = state.serverResponse;
              getWatchList(watchListResponse);
            });
          }
          if(state is AddtoWatchListCompleteState){
            Fluttertoast.showToast(
                msg: "Successfully added into watch list",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        child: Padding(
            padding: EdgeInsets.only(left: 0.w,top: 0.h,bottom: 0.h,right: 0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 55.h,
                  width:MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10.w,),
                      Expanded(child: Container(
                        height: 40.h,
                        //width: 220.w,
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black26, width: 2),
                            color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search.......",
                              hintMaxLines: 2,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (value) {
                              if(_selectedIndex == 0){
                                searchCryptoDataList.clear();
                                if(value != "" && value != null){
                                  cryptoDataList.forEach((element) {
                                    if(value.toLowerCase().contains(element.baseAsset.toString().toLowerCase())){
                                      setState((){
                                        searchCryptoDataList.add(element);
                                      });
                                    }
                                  });
                                }
                                else{
                                  setState((){
                                    searchCryptoDataList.clear();
                                  });
                                }
                              }
                              else  if(_selectedIndex == 1){
                                searchWatchListCryptoDataList.clear();
                                if(value != "" && value != null){
                                  watchListCryptoDataList.forEach((element) {
                                    if(value.toLowerCase().contains(element.baseAsset.toString().toLowerCase())){
                                      setState((){
                                        searchWatchListCryptoDataList.add(element);
                                      });
                                    }
                                  });
                                }
                                else{
                                  setState((){
                                    searchWatchListCryptoDataList.clear();
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),),
                      SizedBox(width: 10.w,),
                      InkWell(onTap: (){},child: Icon(Icons.search, size: 30,)),
                      SizedBox(width: 10.w,),
                    ],
                  ),
                ),
                Container(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width.w,
                  color: ColorConstants.colorhintText,
                  child: TabBar(
                    controller: _controller,
                    indicatorColor: Colors.deepOrange,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.black,
                    indicatorWeight: 5,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                    tabs: [
                      Tab(text: "All Coins"),
                      Tab(text: "My Watchlist"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:
                  15.w,right: 15.w),
                  child: Container(
                    width: MediaQuery.of(context).size.width.w,
                    height: 0.5.sp,
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  controller: _controller,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 0.h),
                          child: Row(
                            children: [
                              Expanded(
                                flex:2,
                                child:Text("Coin Name",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13.sp
                                ),),
                              ),
                              Expanded(
                                  flex:3,
                                  child:Row(
                                    children: [
                                      Expanded(
                                          flex:1,
                                          child:GestureDetector(
                                            onTap: (){
                                              setState((){
                                               if(disPrice == false){
                                                 disPrice = true;
                                                 assPrice = false;
                                                 cryptoDataList.sort((a, b) => a.lastPrice.compareTo(b.lastPrice));
                                               }
                                               else{
                                                 disPrice = false;
                                                 assPrice = true;
                                                 cryptoDataList.sort((a, b) => b.lastPrice.compareTo(a.lastPrice));
                                               }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Text("Price ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 13.sp
                                                ),),
                                                (assPrice == true) ? Icon(Icons.arrow_upward,color: Colors.green,size: 20.sp,): SizedBox(),
                                                (disPrice == true) ? Icon(Icons.arrow_downward,color: Colors.red,size: 20.sp,) : SizedBox(),
                                              ],
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          flex:1,
                                          child:GestureDetector(
                                            onTap: (){
                                              setState((){
                                                if(assChangePrice == true){
                                                  disChangePrice = true;
                                                  assChangePrice = false;
                                                  cryptoDataList.sort((a, b) => a.lastPricePercent.compareTo(b.lastPricePercent));
                                                }
                                                else{
                                                  disChangePrice = false;
                                                  assChangePrice = true;
                                                  cryptoDataList.sort((a, b) => b.lastPricePercent.compareTo(a.lastPricePercent));
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Center(
                                                  child:Text("24H CHANGE",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ),
                                                (assChangePrice == true) ? Image.asset("assets/images/downarrowtwo.png",height: 10.h,width: 10.h,color: Colors.black,):SizedBox(),
                                                (disChangePrice == true) ? Image.asset("assets/images/up_arrow.png",height: 10.h,width: 10.h,color: Colors.black,):SizedBox(),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: (searchCryptoDataList != null && searchCryptoDataList.length > 0) ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: searchCryptoDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  setState((){
                                    cryptoData = searchCryptoDataList[index];
                                    fromMyWatchList = false;
                                    sheetopen = false;
                                  });
                                  BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: searchCryptoDataList[index].symbol,limit: "5",fromWhere: true ));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 25.h,bottom: 8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex:2,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                                  SizedBox(
                                                    width: 5.h,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(searchCryptoDataList[index].baseAsset.toString().toUpperCase(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 15.sp
                                                          ),),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:1,
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                        Text(searchCryptoDataList[index].lastPrice.toString(),style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 13.sp
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex:1,
                                                      child:Center(
                                                        child: Container(
                                                          width: 90.w,
                                                          height: 30.h,
                                                          padding: EdgeInsets.all(5.h),
                                                          decoration: BoxDecoration(
                                                              color: (double.parse(searchCryptoDataList[index].lastPricePercent.toString()) < 0) ? ColorConstants.colorPinkShade : ColorConstants.colorGreenBtn,
                                                              borderRadius: BorderRadius.circular(5.h)
                                                          ),
                                                          child: Center(
                                                            child: Text(double.parse(searchCryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'RoMedium',
                                                                color: (double.parse(searchCryptoDataList[index].lastPricePercent.toString()) < 0) ? Colors.deepOrange : ColorConstants.colorGreenHint,
                                                                fontSize: 15.sp
                                                            ),),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height: 0.5.sp,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ) : ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cryptoDataList.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    setState((){
                                      cryptoData = cryptoDataList[index];
                                      fromMyWatchList = false;
                                      sheetopen = false;
                                    });
                                    BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: cryptoDataList[index].symbol,limit: "5",fromWhere: true ));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 25.h,bottom: 8.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex:2,
                                                child:Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                                    SizedBox(
                                                      width: 5.h,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(cryptoDataList[index].baseAsset.toString().toUpperCase(),style: TextStyle(
                                                                fontFamily: 'RoMedium',
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black,
                                                                fontSize: 15.sp
                                                            ),),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex: 3,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex:1,
                                                      child:  Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                          Text(cryptoDataList[index].lastPrice.toString(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 13.sp
                                                          ),),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex:1,
                                                        child:Center(
                                                          child: Container(
                                                            width: 90.w,
                                                            height: 30.h,
                                                            padding: EdgeInsets.all(5.h),
                                                            decoration: BoxDecoration(
                                                                color: (double.parse(cryptoDataList[index].lastPricePercent.toString()) < 0) ? ColorConstants.colorPinkShade : ColorConstants.colorGreenBtn,
                                                                borderRadius: BorderRadius.circular(5.h)
                                                            ),
                                                            child: Center(
                                                              child: Text(double.parse(cryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'RoMedium',
                                                                  color: (double.parse(cryptoDataList[index].lastPricePercent.toString()) < 0) ? Colors.deepOrange : ColorConstants.colorGreenHint,
                                                                  fontSize: 15.sp
                                                              ),),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width.w,
                                          height: 0.5.sp,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 0.h),
                          child: Row(
                            children: [
                              Expanded(
                                flex:2,
                                child:Text("Coin Name",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13.sp
                                ),),
                              ),
                              Expanded(
                                  flex:3,
                                  child:Row(
                                    children: [
                                      Expanded(
                                          flex:1,
                                          child:GestureDetector(
                                            onTap: (){
                                              setState((){
                                                if(disPrice1 == false){
                                                  disPrice1 = true;
                                                  assPrice1 = false;
                                                  watchListCryptoDataList.sort((a, b) => a.lastPrice.compareTo(b.lastPrice));
                                                }
                                                else{
                                                  disPrice1 = false;
                                                  assPrice1 = true;
                                                  watchListCryptoDataList.sort((a, b) => b.lastPrice.compareTo(a.lastPrice));
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Text("Price ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 13.sp
                                                ),),
                                                (assPrice1 == true) ? Icon(Icons.arrow_upward,color: Colors.green,size: 20.sp,): SizedBox(),
                                                (disPrice1 == true) ? Icon(Icons.arrow_downward,color: Colors.red,size: 20.sp,) : SizedBox(),
                                              ],
                                            ),
                                          )
                                      ),
                                      Expanded(
                                          flex:1,
                                          child:GestureDetector(
                                            onTap: (){
                                              setState((){
                                                if(assChangePrice1 == true){
                                                  disChangePrice1 = true;
                                                  assChangePrice1 = false;
                                                  watchListCryptoDataList.sort((a, b) => a.lastPricePercent.compareTo(b.lastPricePercent));
                                                }
                                                else{
                                                  disChangePrice1 = false;
                                                  assChangePrice1 = true;
                                                  watchListCryptoDataList.sort((a, b) => b.lastPricePercent.compareTo(a.lastPricePercent));
                                                }
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Center(
                                                  child:Text("24H CHANGE",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ),
                                                (assChangePrice1 == true) ? Image.asset("assets/images/downarrowtwo.png",height: 10.h,width: 10.h,color: Colors.black,):SizedBox(),
                                                (disChangePrice1 == true) ? Image.asset("assets/images/up_arrow.png",height: 10.h,width: 10.h,color: Colors.black,):SizedBox(),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: (searchWatchListCryptoDataList != null && searchWatchListCryptoDataList.length > 0 ) ? ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: searchWatchListCryptoDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  setState((){
                                    cryptoData = searchWatchListCryptoDataList[index];
                                    fromMyWatchList = true;
                                    sheetopen = false;
                                  });
                                  BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: searchWatchListCryptoDataList[index].symbol,limit: "5",fromWhere: true ));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 25.h,bottom: 8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex:2,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                                  SizedBox(
                                                    width: 5.h,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(searchWatchListCryptoDataList[index].baseAsset.toString().toUpperCase(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 15.sp
                                                          ),),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:1,
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                        Text(searchWatchListCryptoDataList[index].lastPrice.toString(),style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 13.sp
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex:1,
                                                      child:Center(
                                                        child: Container(
                                                          width: 90.w,
                                                          height: 30.h,
                                                          padding: EdgeInsets.all(5.h),
                                                          decoration: BoxDecoration(
                                                              color: (double.parse(searchWatchListCryptoDataList[index].lastPricePercent.toString()) < 0) ? ColorConstants.colorPinkShade : ColorConstants.colorGreenBtn,
                                                              borderRadius: BorderRadius.circular(5.h)
                                                          ),
                                                          child: Center(
                                                            child: Text(double.parse(searchWatchListCryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'RoMedium',
                                                                color: (double.parse(searchWatchListCryptoDataList[index].lastPricePercent.toString()) < 0) ? Colors.deepOrange : ColorConstants.colorGreenHint,
                                                                fontSize: 15.sp
                                                            ),),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height: 0.5.sp,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ) : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: watchListCryptoDataList.length,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                  setState((){
                                    cryptoData = watchListCryptoDataList[index];
                                    fromMyWatchList = true;
                                    sheetopen = false;
                                  });
                                  BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: watchListCryptoDataList[index].symbol,limit: "5" ,fromWhere: true));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 25.h,bottom: 8.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex:2,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                                  SizedBox(
                                                    width: 5.h,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(watchListCryptoDataList[index].baseAsset.toString().toUpperCase(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                              fontSize: 15.sp
                                                          ),),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex:1,
                                                    child:  Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                        Text(watchListCryptoDataList[index].lastPrice.toString(),style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                            fontSize: 13.sp
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex:1,
                                                      child:Center(
                                                        child: Container(
                                                          width: 90.w,
                                                          height: 30.h,
                                                          padding: EdgeInsets.all(5.h),
                                                          decoration: BoxDecoration(
                                                              color: (double.parse(watchListCryptoDataList[index].lastPricePercent.toString()) < 0) ? ColorConstants.colorPinkShade : ColorConstants.colorGreenBtn,
                                                              borderRadius: BorderRadius.circular(5.h)
                                                          ),
                                                          child: Center(
                                                            child: Text(double.parse(watchListCryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'RoMedium',
                                                                color: (double.parse(watchListCryptoDataList[index].lastPricePercent.toString()) < 0) ? Colors.deepOrange : ColorConstants.colorGreenHint,
                                                                fontSize: 15.sp
                                                            ),),
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15.w,right: 15.w),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height: 0.5.sp,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                        ),)
                      ],
                    )
                  ],
                ))
              ],
            )
        ),
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  void getData(dio.Response? serverResponse) {
    for(int i=0 ; i<serverResponse!.data.length ; i++){
      if(serverResponse.data[i]["symbol"].toString().contains("usdt") == false && serverResponse.data[i]["symbol"].toString().contains("wrx") == false)
      {
        var changePercent = (((double.parse(serverResponse.data[i]["lastPrice"].toString()) - double.parse(serverResponse.data[i]["openPrice"].toString())) / double.parse(serverResponse.data[i]["openPrice"].toString())) * 100);
        cryptoDataList.add(CryptoData(serverResponse.data[i]["symbol"].toString(), serverResponse.data[i]["baseAsset"].toString(), serverResponse.data[i]["quoteAsset"].toString(), serverResponse.data[i]["openPrice"].toString(), serverResponse.data[i]["lowPrice"].toString(), serverResponse.data[i]["highPrice"].toString(), serverResponse.data[i]["lastPrice"].toString(), serverResponse.data[i]["volume"].toString(), serverResponse.data[i]["bidPrice"].toString(), serverResponse.data[i]["askPrice"].toString(), serverResponse.data[i]["at"].toString(),changePercent.toString()));
      }
    }
    cryptoDataList.sort((a, b) => a.lastPrice.compareTo(b.lastPrice));
  }

  showPreViewScreen(BuildContext context, CryptoData cryptoData){
    sheetopen = true;
    timer = Timer.periodic(Duration(seconds: 5), (Timer t){
      BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: cryptoData.symbol,limit: "5",fromWhere: false ));
    });
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height.h,
            color: Colors.white,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 15.h,bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 5.h,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.back();
                                },
                                child: Image.asset("assets/images/back_arrow.png",height: 25.h,width: 20.w,),
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                              SizedBox(
                                width: 5.h,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cryptoData.baseAsset.toString().toUpperCase(),style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15.sp
                                      ),),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(fromMyWatchList == false)
                              BlocProvider.of<CryptoBloc>(cryptoContext).add(AddtoWatchList(context: context,code: cryptoData.symbol));
                            },
                            child: Image.asset("assets/images/eye.png",height: 20.h,width: 20.w,color: ColorConstants.indigoAccent,),
                          ),
                          (fromMyWatchList == true) ? Text("Added to Watchlist",style: TextStyle(color: ColorConstants.indigoAccent),):SizedBox(),
                          (fromMyWatchList == false) ? Text("Watchlist",style: TextStyle(color: ColorConstants.indigoAccent),):SizedBox(),
                        ],
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w),
                  child: Container(
                    width: MediaQuery.of(context).size.width.w,
                    height: 0.5.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.h,
                    ),
                    Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,),
                    SizedBox(
                      width: 5.h,
                    ),
                    Text(cryptoData.lastPrice.toString(),style: TextStyle(
                        fontFamily: 'RoMedium',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18.sp
                    ),),
                    SizedBox(
                      width: 15.h,
                    ),
                    (double.parse(cryptoData.lastPricePercent) > 0) ? Icon(Icons.arrow_upward,color: ColorConstants.colorGreenHint,):SizedBox(),
                    (double.parse(cryptoData.lastPricePercent) < 0) ? Icon(Icons.arrow_downward,color: Colors.red,):SizedBox(),
                    SizedBox(
                      width: 2.h,
                    ),
                    (double.parse(cryptoData.lastPricePercent) > 0) ? Text(double.parse(cryptoData.lastPricePercent).toStringAsFixed(2)+"%",style: TextStyle(
                        fontFamily: 'RoMedium',
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.colorGreenHint,
                        fontSize: 14.sp
                    ),):SizedBox(),
                    (double.parse(cryptoData.lastPricePercent) < 0) ? Text(double.parse(cryptoData.lastPricePercent).toStringAsFixed(2)+"%",style: TextStyle(
                        fontFamily: 'RoMedium',
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 14.sp
                    ),):SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10.h,
                    ),
                    Expanded(
                        child: Center(
                          child: Text("Bid (Buy Orders)",style: TextStyle(fontSize: 15.sp),),
                        )
                    ),
                    /*Expanded(
                        flex: 1,
                        child: Text("Ask (Sell Orders)",style: TextStyle(fontSize: 15.sp),)
                    ),*/
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.h,
                ),
                Row(
                  children: [
                    Expanded(child: Container(
                        //width: MediaQuery.of(context).size.width.w/2.w,
                        height: 160.h,
                        margin: EdgeInsets.only(left:30.h,right: 30.h,top: 5.h,bottom: 0.h),
                        padding: EdgeInsets.only(left:10.w,right: 10.w,top: 5.h,bottom: 0.h),
                        decoration: BoxDecoration(
                            color: ColorConstants.colorWhite,
                            borderRadius: BorderRadius.circular(5.h),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 15.h,
                              child:  Row(
                                children: [
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Price",style: TextStyle(fontSize: 15.sp),)
                                        ],
                                      )
                                  ),
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("Qty",style: TextStyle(fontSize: 15.sp),)
                                        ],
                                      )
                                  ),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(child:  ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: marketDepthResponse!.data["bids"].length,
                              itemBuilder: (context,index){
                                return Padding(
                                    padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Text(marketDepthResponse!.data["bids"][index][1].toString(),style: TextStyle(fontSize: 15.sp),)
                                              ],
                                            )
                                        ),
                                        SizedBox(
                                          width: 5.h,
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 110.w,
                                                    height: 20.h,
                                                    padding: EdgeInsets.all(2.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green.shade300,
                                                        borderRadius: BorderRadius.circular(3.h)
                                                    ),
                                                    child: Center(
                                                        child: Text(marketDepthResponse!.data["bids"][index][0].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorGreenBtnTwo,fontWeight: FontWeight.bold),)
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                );
                              },
                            ),)
                          ],
                        )
                    ),),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                        child: Center(
                          child: Text("Ask (Sell Orders)",style: TextStyle(fontSize: 15.sp),),
                        )
                    ),
                    /*Expanded(
                        flex: 1,
                        child: Text("Ask (Sell Orders)",style: TextStyle(fontSize: 15.sp),)
                    ),*/
                    SizedBox(
                      width: 10.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.h,
                ),
                Row(
                  children: [
                    Expanded(child: Container(
                      //width: MediaQuery.of(context).size.width.w/2.w,
                        height: 160.h,
                        margin: EdgeInsets.only(left:30.h,right: 30.h,top: 5.h,bottom: 0.h),
                        padding: EdgeInsets.only(left:10.w,right: 10.w,top: 5.h,bottom: 5.h),
                        decoration: BoxDecoration(
                            color: ColorConstants.colorWhite,
                            borderRadius: BorderRadius.circular(3.h),
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Column(
                          children: [
                          Container(
                          height: 15.h,
                          child:Row(
                              children: [
                                SizedBox(
                                  width: 2.h,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Price",style: TextStyle(fontSize: 15.sp),)
                                      ],
                                    )
                                ),
                                SizedBox(
                                  width: 5.h,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text("Qty",style: TextStyle(fontSize: 15.sp),)
                                      ],
                                    )
                                ),
                                SizedBox(
                                  width: 2.h,
                                ),
                              ],
                            ),),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: marketDepthResponse!.data["asks"].length,
                                  itemBuilder: (context,index){
                                    return Padding(
                                      padding: EdgeInsets.only(top: 2.h,bottom: 2.h),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Text(marketDepthResponse!.data["asks"][index][1].toString(),style: TextStyle(fontSize: 15.sp),)
                                                ],
                                              )
                                          ),
                                          SizedBox(
                                            width: 5.h,
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      width: 110.w,
                                                      height: 20.h,
                                                      padding: EdgeInsets.all(2.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors.green.shade300,
                                                          borderRadius: BorderRadius.circular(3.h)
                                                      ),
                                                      child: Center(
                                                          child: Text(marketDepthResponse!.data["asks"][index][0].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorGreenBtnTwo,fontWeight: FontWeight.bold),)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                            )
                          ],
                        )
                    ),),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Fluttertoast.showToast(
                                msg: "Coming Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          },
                          child: Center(
                            child: Container(
                              width: 120.w,
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                  color: ColorConstants.colorGreenHint,
                                  borderRadius: BorderRadius.circular(3.h)
                              ),
                              child: Center(
                                child: Text("BUY",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.white,
                                    fontSize: 15.sp
                                ),),
                              ),
                            ),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Fluttertoast.showToast(
                                msg: "Coming Soon",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );

                          },
                          child: Center(
                            child: Container(
                              width: 120.w,
                              padding: EdgeInsets.all(10.h),
                              decoration: BoxDecoration(
                                  color: ColorConstants.colorLoginBtn,
                                  borderRadius: BorderRadius.circular(3.h)
                              ),
                              child: Center(
                                child: Text("SELL",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.white,
                                    fontSize: 15.sp
                                ),),
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            )
          );
        }
    ).whenComplete(() {
     timer!.cancel();
    });
  }

  void getWatchList(Map<String, dynamic>? watchListResponse) {
    for(int i=0 ; i<watchListResponse!["data"].length ; i++){
      watchList.add(WatchListData(watchListResponse["data"][i]["_id"].toString(), watchListResponse["data"][i]["user_id"].toString(), watchListResponse["data"][i]["code"].toString(), watchListResponse["data"][i]["created_at"].toString(), watchListResponse["data"][i]["__v"].toString()));
    }
    for(int i=0 ; i<watchList.length ; i++){
      for(int j=0 ; j<cryptoDataList.length ; j++){
        if(cryptoDataList[j].symbol.toString() == watchList[i].code.toString()){
          watchListCryptoDataList.add(cryptoDataList[j]);
        }
      }
    }
    //watchListCryptoDataList.addAll(cryptoDataList.where((a) => watchList.every((b) => a.symbol.toString() == b.code)));
  }

}













