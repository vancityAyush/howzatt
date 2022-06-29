import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Crypto/BuyBitcoin.dart';
import 'package:howzatt/ui/DashBoard/Crypto/PriceAlerts.dart';
import 'package:howzatt/ui/DashBoard/Crypto/SellBitcoin.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class Bitcoin extends StatefulWidget {
  const Bitcoin({Key? key}) : super(key: key);

  @override
  _BitcoinState createState() => _BitcoinState();
}


class _BitcoinState extends State<Bitcoin> {


  @override
  void initState() {
    super.initState();
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
                      'Bitcoin',
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
        padding: EdgeInsets.only(top: 20.h,bottom: 20.h,left: 15.w,right: 15.w),
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/bitcoin.png" ,width: 40.w,height: 40.h,),
                    SizedBox(width: 10.w,),
                    Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Current Bitcoin Buy Price",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.black87,
                                      fontSize: 15.sp
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset("assets/images/rupee_indian.png" ,width: 10.w,height: 10.h,),
                                Text(
                                  "22,652.52",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.black87,
                                      fontSize: 12.sp
                                  ),
                                ),
                                SizedBox(width: 15.w,),
                                Image.asset("assets/images/arrow_up.png" ,width: 10.w,height: 10.h,color: ColorConstants.colorGreenBtn,),
                                Text(
                                  "3.36%",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: ColorConstants.colorGreenBtn,
                                      fontSize: 12.sp
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => PriceAlerts()));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/images/notification.png" ,width: 20.w,height: 20.h,color: Colors.deepOrange,),
                          Text(
                            "Price Alert",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: Colors.deepOrange,
                                fontSize: 14.sp
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text("1D Highest",style: TextStyle(
                                fontFamily: 'RoLight',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12.sp
                            ),),
                            SizedBox(width: 7.w,),
                            Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,color: Colors.black,),
                            Text("21,985.73",style: TextStyle(
                                fontFamily: 'RoLight',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12.sp
                            ),),
                          ],
                        )
                    ),
                    SizedBox(width: 4.w,),
                    Container(
                      height:20.h,
                      width:1.w,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Text("1D Lowest",style: TextStyle(
                                fontFamily: 'RoLight',
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp
                            ),),
                            SizedBox(width: 7.w,),
                            Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,color: Colors.black,),
                            Text("21,985.73",style: TextStyle(
                                fontFamily: 'RoLight',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp
                            ),),
                          ],
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Card(
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
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => BuyBitcoin()));
                          },
                          child: Container(
                            width: 80.w,
                            height: 30.h,
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                              child: Text("1D",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 15.sp
                              ),),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => SellBitcoin()));
                          },
                          child: Container(
                            width: 80.w,
                            height: 30.h,
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.h),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                              child: Text("1W",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 15.sp
                              ),),
                            ),
                          ),
                        )
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: 80.w,
                          height: 30.h,
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.h),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Center(
                            child: Text("1M",style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: Colors.grey,
                                fontSize: 15.sp
                            ),),
                          ),
                        )
                    ),
                    SizedBox(width: 5.w,),
                    Expanded(
                        flex: 1,
                        child: Container(
                          width: 80.w,
                          height: 30.h,
                          padding: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.h),
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Center(
                            child: Text("1Y",style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: Colors.grey,
                                fontSize: 15.sp
                            ),),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 20.w,),
                    Text("Statistics",style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: Colors.black,
                        fontSize: 20.sp
                    ),),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  height: 0.5.h,
                  width: MediaQuery.of(context).size.width.w,
                  color: Colors.black87,
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Market Cap" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Volume 24 h" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("58.339 T" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("58.339 T" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Circulating Supply" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Max Supply" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("58.339 BTC" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("21 M BTC" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Total Supply" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Rank" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("18.339 M BTC" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("# 1" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("All Time High" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Expanded(
                      flex:1,
                      child:  Text("Mkt Dominance" , style: TextStyle(fontSize: 16.sp ,color: Colors.grey ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("8.339 M" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    ),
                    SizedBox(width: 15.w,),
                    Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                    Expanded(
                      flex:1,
                      child:  Text("47.20" , style: TextStyle(fontSize: 16.sp ,color: Colors.black ,fontFamily: 'RoMedium',),),
                    )
                  ],
                ),
              ],
            ),),
            Center(
              child: Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width.w,
                color: Colors.white,
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => SellBitcoin()));
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
                                  child: Text("SELL BITCOIN",style: TextStyle(
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => BuyBitcoin()));
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
                                  child: Text("BUY BITCOIN",style: TextStyle(
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
              ),
            )
          ],
        )
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }



}













