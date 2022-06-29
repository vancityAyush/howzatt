import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Crypto/AddMoney.dart';
import 'package:howzatt/ui/DashBoard/Crypto/BuyBitcoin.dart';
import 'package:howzatt/ui/DashBoard/Crypto/PriceAlerts.dart';
import 'package:howzatt/ui/DashBoard/Crypto/SellBitcoin.dart';
import 'package:howzatt/ui/DashBoard/Crypto/WithdrawFunds.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class IndianRupees extends StatefulWidget {
  const IndianRupees({Key? key}) : super(key: key);

  @override
  _IndianRupeesState createState() => _IndianRupeesState();
}


class _IndianRupeesState extends State<IndianRupees> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                          ),
                          SizedBox(
                            width: 0.h,
                          ),
                          Text(
                            'Indian Rupee',
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
      body: Padding(
        padding: EdgeInsets.only(top: 10.h,bottom: 10.h,left: 15.w,right: 15.w),
        child: Column(
          children: [
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    Card(
                      elevation: 1.h,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child:new Container(
                          height: 80.h,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                  color: ColorConstants.colorhintText,
                                  width: 0.5.w
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.h))
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 20.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text("AVAILABLE BALANCE",textAlign:TextAlign.start,style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorhintText,fontWeight: FontWeight.bold,fontFamily: 'RoLight',),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset('assets/images/rupee_indian.png', width: 15.w ,height: 15.h),
                                              SizedBox(width: 3.h,),
                                              Text("20.0",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),),
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                  Image.asset('assets/images/rupee_symbol.png', width: 60.w ,height: 60.h),
                                ],
                              )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10.w,),
                        Text("PAST TRANSACTION",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.sp,color: ColorConstants.colorhintText,fontWeight: FontWeight.bold,fontFamily: 'RoLight',),),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      height: 1.h,
                      width: MediaQuery.of(context).size.width.w,
                      color: ColorConstants.colorhintText,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Card(
                              elevation: 1.h,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.h),
                              ),
                              child:new Container(
                                  height: 80.h,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: ColorConstants.colorhintText,
                                          width: 0.5.w
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10.h))
                                  ),
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 10.h,right: 5.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset('assets/images/withdrawal.png', width: 30.w ,height: 30.h,color: Colors.deepOrange,),
                                          SizedBox(width: 20.w,),
                                          Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Withdraw",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.sp,color: Colors.deepOrange,fontWeight: FontWeight.bold,fontFamily: 'RoMedium',),),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 0.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("22 Feb'22,7:26PM",textAlign:TextAlign.start,style: TextStyle(fontSize: 12.sp,color: Colors.grey),),
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset('assets/images/rupee_indian.png', width: 15.w ,height: 15.h,color: Colors.grey,),
                                                  SizedBox(width: 3.h,),
                                                  Text("5375",textAlign:TextAlign.start,style: TextStyle(fontSize: 18.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("COMPLECATED",textAlign:TextAlign.start,style: TextStyle(fontSize: 10.sp,color: ColorConstants.colorGreenBtn,fontFamily: 'RoLight',fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5.w,),
                                          Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                                        ],
                                      )
                                  )
                              ),
                            ),
                          );
                        }
                    ),
                  ],
                ),
            ),
            Container(
              height: 100.h,
              width: MediaQuery.of(context).size.width.w,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => WithdrawFunds()));
                        },
                        child: Center(
                          child: Container(
                            width: 120.w,
                            height: 35.h,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10.h))
                            ),
                            child: Center(
                              child: Text("Withdraw Funds",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 12.sp
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
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => AddMoney()));
                        },
                        child: Center(
                          child: Container(
                            width: 120.w,
                            height: 35.h,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                                color: ColorConstants.colorGreenBtnThree,
                                borderRadius: BorderRadius.circular(10.h)
                            ),
                            child: Center(
                              child: Text("Add Funds",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.white,
                                  fontSize: 12.sp
                              ),),
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }



}













