import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}


class _OrdersState extends State<Orders> {


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
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/images/back_arrow.png', width: 50.w ,height: 20.h,color: Colors.white,),
                    ),
                    SizedBox(
                      width: 0.h,
                    ),
                    Text(
                      'Orders',
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
      body:  ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 155,
          shrinkWrap: true,
          itemBuilder: (context,index){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 20.h,bottom: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("SELL",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.colorPinkHint,
                                          fontSize: 14.sp
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Fantom",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15.sp
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("22 Feb'22 , 7:08",textAlign:TextAlign.start,style: TextStyle(
                                          fontFamily: 'RoThin',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 11.sp
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
                          Row(
                            children: [
                              Text("Qty 84.26 FTM",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 13.sp
                              ),),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text("Price:",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 13.sp
                              ),),
                              Image.asset("assets/images/rupee_indian.png",height: 10.h,width: 10.w,color: Colors.grey,),
                              Text("123.15",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 13.sp
                              ),),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text("Total",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13.sp
                              ),),
                              Image.asset("assets/images/rupee_indian.png",height: 10.h,width: 10.w,color: Colors.black,),
                              Text("10,000",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 13.sp
                              ),),
                            ],
                          ),
                        ],
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
            );
          }
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }



}













