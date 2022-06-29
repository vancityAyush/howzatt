import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/WalletBloc/WalletBloc.dart';
import 'package:howzatt/Repository/WalletRepository.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/utils/ColorConstants.dart';


class MyWallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => WalletBloc(WalletRepository(Dio())),
        child: MyWalletStateful(),
      ),
    );
  }
}

class MyWalletStateful extends StatefulWidget {


  @override
  _MyWalletState createState() => _MyWalletState();
}


class _MyWalletState extends State<MyWalletStateful> {


  String totalWalletAmount = "";


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
                                      Get.to(HomePage());
                                    },
                                    child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                                  ),
                                  SizedBox(
                                    width: 0.h,
                                  ),
                                  Text(
                                    'My Wallet',
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
              body: SafeArea(
                  child:SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/rupee_indian.png', width: 13.w ,height: 13.h),
                                SizedBox(width: 5.h,),
                                (totalWalletAmount != "" && totalWalletAmount != "null") ? Text(
                                  totalWalletAmount.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.black,
                                      fontSize: 15.sp
                                  ),
                                ) : Text(
                                  '00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.black,
                                      fontSize: 15.sp
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.h,
                                ),
                                Text(
                                  'Total Balance',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoThin',
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 5.h,
                                ),
                                Container(
                                  width: 100.h,
                                  padding: EdgeInsets.all(5.h),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(1.h)
                                  ),
                                  child: Center(
                                    child: Text("ADD MONEY",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.white,
                                        fontSize: 14.sp
                                    ),),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    elevation: 2.h,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child:new Container(
                                        height: 47.h,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ), borderRadius: BorderRadius.all(Radius.circular(8.h))
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 5.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text("Deposited Amount",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: ColorConstants.colorBlackHint,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp
                                                ),),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 13.h,
                                                    ),
                                                    Image.asset('assets/images/mybalance.png', width: 30.w ,height: 22.h),
                                                    SizedBox(
                                                      width: 4.h,
                                                    ),
                                                    Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGolden,),
                                                    SizedBox(width: 1.h,),
                                                    (totalWalletAmount != "" && totalWalletAmount != "null") ? Text(
                                                      totalWalletAmount,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorGolden,
                                                          fontSize: 13.sp
                                                      ),
                                                    ):Text(
                                                      '0.00',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorGolden,
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    elevation: 2.h,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child:new Container(
                                        height: 47.h,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ), borderRadius: BorderRadius.all(Radius.circular(8.h))
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 5.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text("Wining Amount",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: ColorConstants.colorBlackHint,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp
                                                ),),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20.h,
                                                    ),
                                                    Image.asset('assets/images/trophy.png', width: 30.w ,height: 22.h),
                                                    SizedBox(
                                                      width: 4.h,
                                                    ),
                                                    Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: ColorConstants.colorPinkHint,),
                                                    SizedBox(width: 1.h,),
                                                    Text(
                                                      '0.00',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorPinkHint,
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    elevation: 2.h,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child:new Container(
                                        height: 47.h,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ), borderRadius: BorderRadius.all(Radius.circular(8.h))
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 5.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text("Network Commission",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: ColorConstants.colorBlackHint,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp
                                                ),),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 10.h,
                                                    ),
                                                    Image.asset('assets/images/wifi_signal.png', width: 30.w ,height: 22.h),
                                                    SizedBox(
                                                      width: 4.h,
                                                    ),
                                                    Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGolden,),
                                                    SizedBox(width: 1.h,),
                                                    Text(
                                                      '0.00',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorGolden,
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    elevation: 2.h,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.h),
                                    ),
                                    child:new Container(
                                        height: 47.h,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ), borderRadius: BorderRadius.all(Radius.circular(8.h))
                                        ),
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 5.h),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Text("Bonus Amount",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: ColorConstants.colorBlackHint,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp
                                                ),),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20.h,
                                                    ),
                                                    Image.asset('assets/images/bonus.png', width: 30.w ,height: 22.h),
                                                    SizedBox(
                                                      width: 4.h,
                                                    ),
                                                    Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: ColorConstants.colorPinkHint,),
                                                    SizedBox(width: 1.h,),
                                                    Text(
                                                      '50.00',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorPinkHint,
                                                          fontSize: 13.sp
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Card(
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
                                                  Text("Manage Account",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants.colorBlackHint,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.sp
                                                  ),),
                                                  SizedBox(width: 5.h,),
                                                  Container(
                                                    width: 70.h,
                                                    padding: EdgeInsets.all(0.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(1.h),
                                                        border: Border.all(color: ColorConstants.colorGreenHint,)
                                                    ),
                                                    child: Center(
                                                      child: Text("Verified",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: ColorConstants.colorGreenHint,
                                                          fontSize: 15.sp
                                                      ),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 0.h,
                                                  ),
                                                  Text(
                                                    'Your Bank Account, PAN & others Details',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 10.sp
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          )),
                                          Image.asset('assets/images/fast_forward.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGreenHint,),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Card(
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
                                                  Text("Transaction History",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants.colorBlackHint,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.sp
                                                  ),),
                                                  SizedBox(width: 5.h,),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 0.h,
                                                  ),
                                                  Text(
                                                    'Your Bank Account, PAN & others Details',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 10.sp
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          )),
                                          Image.asset('assets/images/fast_forward.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGreenHint,),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Card(
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
                                                  Text("Rewards",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants.colorBlackHint,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.sp
                                                  ),),
                                                  SizedBox(width: 5.h,),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 0.h,
                                                  ),
                                                  Text(
                                                    'View Rewards',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 10.sp
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          )),
                                          Image.asset('assets/images/fast_forward.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGreenHint,),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Card(
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
                                                  Text("Help",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants.colorBlackHint,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.sp
                                                  ),),
                                                  SizedBox(width: 5.h,),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 0.h,
                                                  ),
                                                  Text(
                                                    'Contact to support',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 10.sp
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                            ],
                                          )),
                                          Image.asset('assets/images/fast_forward.png', width: 12.w ,height: 12.h,color: ColorConstants.colorGreenHint,),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Card(
                              elevation: 2.h,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.h),
                              ),
                              child:new Container(
                                  width: 120.h,
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("WITHDRAW",style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp
                                          ),),
                                        ],
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Message Amount 30.00",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp
                                ),),
                              ],
                            )
                          ],
                        ),
                      )
                  )
              )
          ),
        )
    );
  }


}













