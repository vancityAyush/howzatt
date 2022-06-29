import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/WalletBloc/WalletBloc.dart';
import 'package:howzatt/Repository/WalletRepository.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/ui/WalletDetails/AddWallet.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/DataNotAvailable.dart';
import 'package:howzatt/utils/DateTimeFormatter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';


class TransactionHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => WalletBloc(WalletRepository(Dio())),
        child: TransactionHistoryStateful(),
      ),
    );
  }
}

class TransactionHistoryStateful extends StatefulWidget {


  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}


class _TransactionHistoryState extends State<TransactionHistoryStateful> {


  String totalWalletAmount = "";
  Map<String,dynamic>? serverResponse;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<WalletBloc>(context).add(GetWalletEvent(context: context));
  }

  Future<bool> _willPopCallback() async {
    Get.to(HomePage());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: BlocListener<WalletBloc,WalletState>(
          listener: (context,state){
            if(state is GetWalletCompleteState)
            {
              setState((){
                totalWalletAmount = state.totalWalletAmount;
                serverResponse = state.serverResponse;
              });
            }
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.h),
                child: Container(
                    color: Colors.black,
                    height: 70.h,
                    child:Padding(
                      padding: EdgeInsets.only(top: 35.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child:  Row(
                                children: [
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                                  ),
                                  SizedBox(
                                    width: 0.h,
                                  ),
                                  Text(
                                    'Transaction History',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.white,
                                        fontSize: 15.sp
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                ),
              ),
              body: (serverResponse != null && serverResponse!["data"] != null && serverResponse!["data"].length > 0) ?
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: serverResponse!["data"].length,
                  itemBuilder: (context,index){
                    DateTime dateTime = DateTime.parse(serverResponse!["data"][index]["created_at"].toString()).toLocal();
                    var dateTimeArray = dateTime.toString().split(" ");
                    var date = dateTimeArray[0].split("-");
                    var time = dateTimeArray[1].split(":");
                    print("date2===>>"+date[2].toString());
                    String date1 = Jiffy({
                      "year":int.parse(date[0]),
                      "month":int.parse(date[1]),
                      "day":int.parse(date[2]),
                      "hour": int.parse(time[0]),
                      "minutes":int.parse(time[1]),
                    }).yMMMd;
                    String time1 = Jiffy({
                      "year":int.parse(date[2]),
                      "month":int.parse(date[1]),
                      "day":int.parse(date[0]),
                      "hour": int.parse(time[0]),
                      "minutes":int.parse(time[1]),
                    }).jm;
                    return Padding(
                      padding: EdgeInsets.only(top: 10.h,left: 10.w,right: 10.w),
                      child: Card(
                        elevation: 2.h,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.h),
                        ),
                        child:new Container(
                          //height: 47.h,
                            decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: new Border.all(
                                  color: Colors.black12,
                                  width: 1.0,
                                ), borderRadius: BorderRadius.all(Radius.circular(3.h))
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 10.h,right: 10.h),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      children: [
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 5.h,),
                                            Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,),
                                            SizedBox(width: 5.h,),
                                            Text(serverResponse!["data"][index]["amount"].toString(),style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: ColorConstants.colorBlack,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp
                                            ),),
                                            SizedBox(width: 5.h,),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4.h,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 5.h,
                                            ),
                                            Text(
                                              date1.toString()+" "+time1.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 12.sp
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                      ],
                                    )),
                                    Text(
                                      serverResponse!["data"][index]["type"].toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12.sp
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                  ],
                                )
                            )
                        ),
                      ),
                    );
                  }
              ) : DataNotAvailable.dataNotAvailable("No Transactions Available.")
          ),
        )
    );
  }


}













