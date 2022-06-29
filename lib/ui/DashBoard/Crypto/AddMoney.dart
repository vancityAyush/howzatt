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

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}


class _AddMoneyState extends State<AddMoney> {


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
                      'Add Money',
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
                Text("Add Money",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.sp
                ),),
              ],
            ),
            SizedBox(
              height: 10.h,
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
                    Padding(
                        padding: EdgeInsets.only(left: 10.w,right: 10.w),
                        child: Card(
                          elevation: 1.h,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.h),
                          ),
                          child:new Container(
                              height: 50.h,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: new Border.all(
                                  color: ColorConstants.colorhintText,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 15.h,bottom: 2.h,left: 15.h,right: 15.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,color: Colors.black,),
                                    SizedBox(width: 5.h,),
                                    new TextField(
                                      textAlign: TextAlign.start,
                                      decoration: new InputDecoration(
                                        hintText: 'Enter Amount',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                )
                              )
                          ),
                        ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20.w,),
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
                        SizedBox(width: 10.w,),
                        Container(
                          height: 20.h,
                          width: 1.w,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10.w,),
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
                                Text("10000",style: TextStyle(
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
                      children: [
                        Expanded(
                          flex: 1,
                            child: Center(
                              child: Container(
                                width: 100.w,
                                height: 35.h,
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstants.colorhintText,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.h))
                                ),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("+",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.w,),
                                        Image.asset("assets/images/rupee_indian.png",height: 10.h,width: 10.w,color: ColorConstants.colorGreenBtn,),
                                        SizedBox(width: 2.w,),
                                        Text("1000",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    )
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: 100.w,
                                height: 35.h,
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstants.colorhintText,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.h))
                                ),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("+",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.w,),
                                        Image.asset("assets/images/rupee_indian.png",height: 10.h,width: 10.w,color: ColorConstants.colorGreenBtn,),
                                        SizedBox(width: 2.w,),
                                        Text("5000",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    )
                                ),
                              ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: 100.w,
                                height: 35.h,
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstants.colorhintText,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10.h))
                                ),
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("+",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.w,),
                                        Image.asset("assets/images/rupee_indian.png",height: 10.h,width: 10.w,color: ColorConstants.colorGreenBtn,),
                                        SizedBox(width: 2.w,),
                                        Text("10000",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorGreenBtn,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    )
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      height: 120.h,
                      width: 120.w,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width.w/1.5,
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                          color: ColorConstants.colorBlack,
                          borderRadius: BorderRadius.circular(5.h)
                      ),
                      child: Center(
                        child: Text("Continue",style: TextStyle(
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













