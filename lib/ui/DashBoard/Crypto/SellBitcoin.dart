import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Crypto/PriceAlerts.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class SellBitcoin extends StatefulWidget {
  const SellBitcoin({Key? key}) : super(key: key);

  @override
  _SellBitcoinState createState() => _SellBitcoinState();
}


class _SellBitcoinState extends State<SellBitcoin> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimary,
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
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/back_arrow.png', width: 50.w ,height: 20.h,color: Colors.white,),
                    ),
                    SizedBox(
                      width: 0.h,
                    ),
                    Text(
                      'Sell Bitcoin',
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
      body: Padding(
        padding: EdgeInsets.only(top: 50.h,bottom: 20.h,left: 15.w,right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("INR Amount",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp
                ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/rupee_indian.png",height: 20.h,width: 20.w,),
                Text("22,680.20",style: TextStyle(
                    fontFamily: 'RoMedium',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.sp
                ),),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Available Balance",style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: Colors.grey,
                            fontSize: 18.sp
                        ),),
                        SizedBox(width: 5.w,),
                        Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,color: Colors.black,),
                        Text("610",style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: Colors.black,
                            fontSize: 18.sp
                        ),),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex:1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Minimum",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.grey,
                                    fontSize: 18.sp
                                ),),
                                SizedBox(width: 5.w,),
                                Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,color: Colors.black,),
                                Text("100",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.black,
                                    fontSize: 18.sp
                                ),),
                              ],
                            )
                        ),
                        SizedBox(width: 20.w,),
                        Container(
                          height: 20.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                            flex:1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Minimum",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.grey,
                                    fontSize: 18.sp
                                ),),
                                SizedBox(width: 5.w,),
                                Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,color: Colors.black,),
                                Text("100",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.black,
                                    fontSize: 18.sp
                                ),),
                              ],
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/buybitcoin.png",height: 200.h,width: 300.w,),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width.w/1.5,
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                          color: ColorConstants.colorLoginBtn,
                          borderRadius: BorderRadius.circular(5.h)
                      ),
                      child: Center(
                        child: Text("FILL AMOUNT TO BUY",style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: Colors.white,
                            fontSize: 15.sp
                        ),),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }



}













