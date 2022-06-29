import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/ui/DashBoard/Crypto/CryptoHomePage.dart';
import 'package:howzatt/ui/DashBoard/Crypto/Portfolio.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/MyMatches.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/MyMatchesMain.dart';
import 'package:howzatt/ui/DashBoard/Profile/UserProfile.dart';
import 'package:howzatt/utils/ColorConstants.dart';

Widget bottomNavgation(BuildContext context){
  return  Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Container(
          height: 50.h,
          width: MediaQuery.of(context).size.width.w,
          color:Colors.white,
          child:Padding(
        padding: EdgeInsets.only(top: 2.h,bottom: 0.h),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    Get.to(HomePage());
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => HomePage()));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Image.asset('assets/images/home.png', width: 20.w ,height: 20.h,),
                      Text(
                        'Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RoThin',
                            color: ColorConstants.colorBlack,
                            fontSize: 10.sp
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap:(){
                    Get.to(MyMatches());
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => MyMatchesMain()));
                  },
                  child:Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Image.asset('assets/images/mymatches.png', width: 20.w ,height: 20.h,),
                      Text(
                        'My Matches',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RoThin',
                            color: ColorConstants.colorBlack,
                            fontSize: 10.sp
                        ),
                      ),
                    ],
                  )
                )
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    Get.to(CryptoHomePage());
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => CryptoHomePage()));
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/crypto.png', width: 25.w ,height: 25.h,),
                      Text(
                        'Crypto',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RoThin',
                            color: ColorConstants.colorBlack,
                            fontSize: 10.sp
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    Fluttertoast.showToast(
                      msg: "Coming Soon",
                      toastLength: Toast.LENGTH_LONG,
                      fontSize: 18.0,
                    );
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => Portfolio()));
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Image.asset('assets/images/portfolio.png', width: 20.w ,height: 20.h,),
                      Text(
                        'Portfolio',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RoThin',
                            color: ColorConstants.colorBlack,
                            fontSize: 10.sp
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){
                    Get.to(UserProfile());
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Image.asset('assets/images/userprofile.png', width: 20.w ,height: 20.h,),
                      Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RoThin',
                            color: ColorConstants.colorBlack,
                            fontSize: 10.sp
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      )
    ),
  );
}