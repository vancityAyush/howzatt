import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}


class _PortfolioState extends State<Portfolio> with SingleTickerProviderStateMixin{

  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.h),
        child: Container(
            color: Colors.black,
            height: 200.h,
            child: Padding(
                padding: EdgeInsets.only(top: 25.h,bottom: 5.h,left: 20.w),
                child: Column(
                  children: [
                    Row(
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
                          'Portfolio',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: Colors.white,
                              fontSize: 18.sp
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex:1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Current Balance",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstants.colorGreenBtn,
                                      fontSize: 18.sp
                                  ),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/briefcase.png",height: 20.h,width: 25.w,color: Colors.white,),
                                      SizedBox(width: 4.w,),
                                      Image.asset("assets/images/rupee_indian.png",height: 20.h,width: 15.w,color: Colors.white,),
                                      SizedBox(width: 4.w,),
                                      Text("1300.00",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18.sp
                                      ),),
                                    ],
                                  ),
                                  Text("+2,588.40(24)",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: ColorConstants.colorGreenBtn,
                                      fontSize: 18.sp
                                  ),),
                                ],
                              )
                          ),
                          Expanded(
                              flex:1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text("INR 650.00",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp
                                      ),),
                                      Text("Bitcoin Total",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12.sp
                                      ),),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ))
                  ],
                )
            )
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 0.w,top: 0.h,bottom: 0.h,right: 0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 8.h,bottom: 8.h),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Expanded(
                      flex:2,
                      child:Text("Your Assets",style: TextStyle(
                          fontFamily: 'RoLight',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15.sp
                      ),),
                    ),
                    Expanded(
                        flex:3,
                        child:Text("")
                    ),
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 7.h,bottom: 7.h),
                child: Row(
                  children: [
                    SizedBox(width: 5.w,),
                    Expanded(
                      flex:2,
                        child:Text("Assets",style: TextStyle(
                            fontFamily: 'RoLight',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15.sp
                        ),),
                    ),
                    Expanded(
                        flex:3,
                        child:Row(
                          children: [
                            Expanded(
                                flex:1,
                                child:Text("Price",style: TextStyle(
                                    fontFamily: 'RoLight',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15.sp
                                ),),
                            ),
                            Expanded(
                                flex:1,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Center(
                                      child:Text("Holdings",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15.sp
                                      ),),
                                    ),
                                    Image.asset("assets/images/downarrowtwo.png",height: 10.h,width: 10.h,color: Colors.black,)
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
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
              ),
              Expanded(child: ListView.builder(
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
                                  flex:2,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/images/bitcoin.png",height: 25.h,width: 25.w,),
                                      SizedBox(width: 5.w,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Bitcoin",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 15.sp
                                              ),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("BTC",textAlign:TextAlign.start,style: TextStyle(
                                                  fontFamily: 'RoThin',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  fontSize: 11.sp
                                              ),),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Expanded(
                                  flex:3,
                                  child:Row(
                                    children: [
                                      Expanded(
                                          flex:1,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                  Text("5,904.20",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Image.asset("assets/images/arrow_up.png",height: 10.h,width: 10.w,color: ColorConstants.colorGreenBtn,),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text(" 6.75%",style: TextStyle(
                                                          fontFamily: 'RoThin',
                                                          fontWeight: FontWeight.bold,
                                                          color: ColorConstants.colorGreenBtn,
                                                          fontSize: 12.sp
                                                      ),),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      Expanded(
                                          flex:1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                                                  Text("5,904.20",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 3.h,
                                                      ),
                                                      Text("0.5 BTC",style: TextStyle(
                                                          fontFamily: 'RoThin',
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 12.sp
                                                      ),),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                    ],
                                  )
                              ),
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
              ),)
            ],
          )
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }



}













