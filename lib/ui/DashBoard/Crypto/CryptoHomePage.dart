import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/modal/CryptoData.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Crypto/Bitcoin.dart';
import 'package:howzatt/ui/DashBoard/Crypto/Markets.dart';
import 'package:howzatt/ui/DashBoard/Crypto/Orders.dart';
import 'package:howzatt/ui/DashBoard/Crypto/PriceAlerts.dart';
import 'package:howzatt/ui/HelpDesk.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../Bloc/CryptoBloc/CryptoBloc.dart';
import '../../../Repository/CryptoRepository.dart';
import 'package:dio/dio.dart' as dio;

class CryptoHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => CryptoBloc(CryptoRepository(Dio())),
            ),
          ],
          child: CryptoHomePageStateful(),
        )
    );
  }
}

class CryptoHomePageStateful extends StatefulWidget {


  @override
  _CryptoHomePageState createState() => _CryptoHomePageState();
}


class _CryptoHomePageState extends State<CryptoHomePageStateful> with SingleTickerProviderStateMixin{

  dio.Response? serverResponse,marketDepthResponse;
  List<CryptoData> cryptoDataList = new List.empty(growable: true);
  List<CryptoData> loosercryptoDataList = new List.empty(growable: true);
  late CryptoData cryptoData;
  late BuildContext cryptoContext;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CryptoBloc>(context).add(FetchCryptoEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
              color: Colors.black,
              height: 55.h,
              child: Padding(
                padding: EdgeInsets.only(top: 8.h,bottom: 5.h),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20.h,
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Image.asset('assets/images/homeuser.png', width: 35.w ,height: 35.h),
                            ),
                          ],
                        )
                    ),
                    Stack(
                      children: [
                        Transform.translate(
                          offset: Offset(0.0, 40.h / 2.h),
                          child: buttonStyleFour(context),
                        )
                      ],
                    ),
                    Expanded(
                        flex: 2,
                        child: Text("")
                    )
                  ],
                ),
              )
          ),
      ),
      body: BlocListener<CryptoBloc,CryptoState>(
        listener: (context,state){
          setState((){
            cryptoContext = context;
          });
          if(state is CryptoCompleteState){
            setState((){
              serverResponse = state.serverResponse;
              getData(serverResponse);
            });
          }
          if(state is MarketDepthCompleteState){
            setState((){
              marketDepthResponse = state.serverResponse;
              showPreViewScreen(context,cryptoData);
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
            child: ListView(
              children: [
                SizedBox(height: 20.h,),
                Text(
                  "Welcome to Flip2Play",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RoMedium',
                      color: Colors.black87,
                      fontSize: 18.sp
                  ),
                ),
                SizedBox(height: 5.h,),
                Text(
                  "Make Your first investment today",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'RoLight',
                      color: Colors.grey,
                      fontSize: 14.sp
                  ),
                ),
                SizedBox(height: 15.h,),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w),
                  child: Card(
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.w), topRight: Radius.circular(15.w),bottomLeft: Radius.circular(15.w),bottomRight: Radius.circular(15.w))
                    ),
                    child: Container(
                        height: 100.h,
                        width: MediaQuery.of(context).size.width.w,
                        color:Colors.white,
                        child:Padding(
                          padding: EdgeInsets.only(top: 0.h,bottom: 2.h),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(Markets());
                                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => Markets()));
                                        },
                                        child:Card(
                                            elevation: 3,
                                            shape: const CircleBorder(),
                                            child: Container(
                                                width: 60.w,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                ),
                                                child: Center(
                                                  child: Image.asset('assets/images/market.png', width: 35.w ,height: 35.h,),
                                                )
                                            )
                                        ),
                                      ),
                                      Text(
                                        'Market',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RoBlack',
                                            color: ColorConstants.colorBlack,
                                            fontSize: 13.sp
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Fluttertoast.showToast(
                                            msg: "Coming Soon",
                                            toastLength: Toast.LENGTH_LONG,
                                            fontSize: 18.0,
                                          );
                                          //Get.to(Orders());
                                        },
                                        child: Card(
                                            elevation: 3,
                                            shape: const CircleBorder(),
                                            child: Container(
                                                width: 60.w,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                ),
                                                child: Center(
                                                  child: Image.asset('assets/images/order.png', width: 40.w ,height: 40.h,color: ColorConstants.colorPinkHint,),
                                                )
                                            )
                                        ),
                                      ),
                                      Text(
                                        'Order',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RoBlack',
                                            color: ColorConstants.colorBlack,
                                            fontSize: 13.sp
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              /*Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Get.to(PriceAlerts());
                                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => PriceAlerts()));
                                        },
                                        child: Card(
                                            elevation: 3,
                                            shape: const CircleBorder(),
                                            child: Container(
                                                width: 60.w,
                                                height: 60.h,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white
                                                ),
                                                child: Center(
                                                  child: Image.asset('assets/images/pricealerts.png', width: 35.w ,height: 35.h,),
                                                )
                                            )
                                        ),
                                      ),
                                      Text(
                                        'Price Alerts',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RoBlack',
                                            color: ColorConstants.colorBlack,
                                            fontSize: 13.sp
                                        ),
                                      ),
                                    ],
                                  )
                              ),*/
                            ],
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                Padding(
                    padding: EdgeInsets.only(left: 15.w,right: 15.w),
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Image.asset("assets/images/cryptocurrency.jpeg" , width: MediaQuery.of(context).size.width.w,height: 100.h,fit: BoxFit.fill,),
                    )
                ),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Top Gainers",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'RoBlack',
                                color: Colors.black87,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Coin that have gained the most in 24 hours",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RoLight',
                                color: Colors.black54,
                                fontSize: 14.sp
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                (cryptoDataList.length > 0) ? Padding(
                  padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
                  child: Container(
                    height: 160.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              //Get.to(Markets());
                              setState((){
                                cryptoData =  cryptoDataList[index];
                              });
                              BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: cryptoDataList[index].symbol,limit: "5",fromWhere: true ));
                            },
                            child: Card(
                                elevation: 1,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: SizedBox(
                                    height: 150.h,
                                    width: 100.h,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.w,right: 5.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset("assets/images/bitcoin.png" , height: 33.h, width: 33.w,)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                cryptoDataList[index].baseAsset.toString().toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black87,
                                                    fontSize: 14.sp
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset("assets/images/rupee_indian.png",width: 12.w,height: 12.h,),
                                              Text(
                                                cryptoDataList[index].lastPrice.toString(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black87,
                                                    fontSize: 12.sp
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                double.parse(cryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: 'RoBlack',
                                                    color: ColorConstants.colorGreenBtn,
                                                    fontSize: 18.sp
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                )
                            ),
                          );
                        }
                    ),
                  )
                ):SizedBox(),
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.only(left: 15.w,right: 15.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Top Losers",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'RoBlack',
                                color: Colors.black87,
                                fontSize: 18.sp
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Coin that have loose the most in 24 hours",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RoLight',
                                color: Colors.black54,
                                fontSize: 14.sp
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                (loosercryptoDataList.length > 0) ? Padding(
                    padding: EdgeInsets.only(left: 5.w,right: 5.w,top: 5.h),
                    child: Container(
                      height: 160.h,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: (){
                                setState((){
                                  cryptoData =  loosercryptoDataList[index];
                                });
                                BlocProvider.of<CryptoBloc>(context).add(FetchMarketDepthEvent(context: context,symbol: loosercryptoDataList[index].symbol,limit: "5",fromWhere: true ));
                                //Get.to(Markets());
                              },
                              child: Card(
                                  elevation: 1,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: SizedBox(
                                      height: 150.h,
                                      width: 100.h,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.w,right: 5.w),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset("assets/images/bitcoin.png" , height: 33.h, width: 33.w,)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  loosercryptoDataList[index].baseAsset.toString().toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black87,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset("assets/images/rupee_indian.png",width: 12.w,height: 12.h,),
                                                Text(
                                                  loosercryptoDataList[index].lastPrice.toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black87,
                                                      fontSize: 12.sp
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  double.parse(loosercryptoDataList[index].lastPricePercent).toStringAsFixed(02)+"%",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'RoBlack',
                                                      color: ColorConstants.colorGreenBtn,
                                                      fontSize: 18.sp
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                  )
                              ),
                            );
                          }
                      ),
                    )
                ):SizedBox(),
                Padding(
                    padding: EdgeInsets.only(left: 15.w,right: 15.w,top: 0.h),
                    child:Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text(
                              "Watch : Beginners Guide to Go app !",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RoMedium',
                                  color: Colors.black87,
                                  fontSize: 16.sp
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Row(
                          children: [
                            Expanded(child: Text(
                              "Worried about how to get started ? watch this video to learn the basis.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'RoLight',
                                  color: Colors.grey,
                                  fontSize: 13.sp
                              ),
                            ),)
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: EdgeInsets.only(left: 0.w,right: 0.w),
                          child: Card(
                            elevation: 1,
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black12, width: 1),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w),bottomLeft: Radius.circular(20.w),bottomRight: Radius.circular(20.w))
                            ),
                            child: Container(
                              height: 150.h,
                              width: MediaQuery.of(context).size.width.w,
                              color:Colors.white,
                              child:Image.asset("assets/images/cryptocurrency.jpeg" , width: MediaQuery.of(context).size.width.w,height: 100.h,fit: BoxFit.fill,),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                            Get.to(HelpDesk());
                          },
                          child: Padding(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/chat.png",width: 45.w,height: 45.h,),
                                  SizedBox(width: 10.w,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Need Help ? we are here for you",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: 'RoBlack',
                                                color: Colors.black87,
                                                fontSize: 15.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "24 * 7 Customer Support",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RoLight',
                                                color: Colors.black54,
                                                fontSize: 12.sp
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Visit Help Center",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'RoMedium',
                                                color: ColorConstants.colorblue,
                                                fontSize: 14.sp
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                        SizedBox(height: 15.h,),
                      ],
                    )
                )

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
        loosercryptoDataList.add(CryptoData(serverResponse.data[i]["symbol"].toString(), serverResponse.data[i]["baseAsset"].toString(), serverResponse.data[i]["quoteAsset"].toString(), serverResponse.data[i]["openPrice"].toString(), serverResponse.data[i]["lowPrice"].toString(), serverResponse.data[i]["highPrice"].toString(), serverResponse.data[i]["lastPrice"].toString(), serverResponse.data[i]["volume"].toString(), serverResponse.data[i]["bidPrice"].toString(), serverResponse.data[i]["askPrice"].toString(), serverResponse.data[i]["at"].toString(),changePercent.toString()));

      }
    }
    cryptoDataList.sort((a, b) => b.lastPrice.compareTo(a.lastPrice));
    loosercryptoDataList.sort((a, b) => a.lastPrice.compareTo(b.lastPrice));
  }


  showPreViewScreen(BuildContext context, CryptoData cryptoData){
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
                        /*Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                  BlocProvider.of<CryptoBloc>(cryptoContext).add(AddtoWatchList(context: context,code: cryptoData.symbol));
                              },
                              child: Image.asset("assets/images/eye.png",height: 20.h,width: 20.w,color: ColorConstants.indigoAccent,),
                            ),
                            Text("Watchlist",style: TextStyle(color: ColorConstants.indigoAccent),)
                          ],
                        ),*/
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

    });
  }

}













