import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/AboutUs.dart';
import 'package:howzatt/ui/Authentication/LoginPage.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/ui/DashBoard/CreateChallange.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/CaptainAndVicecaptain.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/MyMatchesMain.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/TeamPreview.dart';
import 'package:howzatt/ui/DashBoard/WinningLeaderBoard/LeaderBoardMainPage.dart';
import 'package:howzatt/ui/FAQ.dart';
import 'package:howzatt/ui/HelpDesk.dart';
import 'package:howzatt/ui/HowToPlay.dart';
import 'package:howzatt/ui/PrivacyPolicy.dart';
import 'package:howzatt/ui/WalletDetails/MyWallet.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NavigationDrawerStateful extends StatefulWidget {


  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}


class _NavigationDrawerState extends State<NavigationDrawerStateful> {

  SharedPreferences? prefs;
  UserDataService userDataService =  getIt<UserDataService>();

  @override
  void initState() {
    super.initState();
    getSharedPreference();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: MediaQuery.of(context).size.width.w,
      color: Colors.white,
      child: Column(
        children: [
          Container(
              height: 60.h,
              color: Colors.black,
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 20.h,),
                    Image.asset('assets/images/profileimage_one.png', width: 30.w ,height: 30.h,color: Colors.white,),
                    SizedBox(width: 20.h,),
                    /*Text(
                      'Yashblaster team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RoThin',
                          color: Colors.white,
                          fontSize: 15.sp
                      ),
                    ),*/
                    Expanded(child: Text("")),
                    SizedBox(
                      width: 20.h,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                    ),
                    SizedBox(
                      width: 20.h,
                    ),
                  ],
                ),
              )
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              SizedBox(width: 20.h,),
              Image.asset('assets/images/mybalance.png', width: 30.w ,height: 30.h,),
              SizedBox(width: 10.h,),
              Expanded(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Get.to(MyWallet());
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => MyWallet()));
                        },
                        child:Text(
                          'My Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ),
                      SizedBox(width: 10.h,),
                      /*TextButton(
                          child: Text(
                              "Add Cash",
                              style: TextStyle(fontSize: 14,color: Colors.black87,)
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10.sp)),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.sp),
                                      side: BorderSide(color: Colors.grey)
                                  )
                              )
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => CreateChallange()));
                          }
                      ),*/
                    ],
                  )
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(HowToPlay());
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/joystick.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'How to Play',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          /*SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => LeaderBoardMainPage()));
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/leader_board.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Series Leader Board',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){

            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/settings.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'My info & Settings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),*/
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Share.share('Your Referal Code is '+userDataService.userData.referal.toString());
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/inviteearn.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Inivite & Earn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          /*SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => TeamPreview()));
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/mynetwork.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'My Network',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),*/
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(HelpDesk());
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/help_desk.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Help Desk',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(AboutUs());
            },
            child:Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/terms&conditions.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'About Us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(PrivacyPolicy());
            },
            child: Row(
              children: [
                SizedBox(width: 20.h,),
                Image.asset('assets/images/privacypolicy.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              Get.to(FAQ());
            },
            child: Row(
              children: [
                SizedBox(width: 26.h,),
                Image.asset('assets/images/faq.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'FAQ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: (){
              prefs!.setString("token", "");
              Get.to(LoginPage());
            },
            child:Row(
              children: [
                SizedBox(width: 26.h,),
                Image.asset('assets/images/logout.png', width: 30.w ,height: 30.h,),
                SizedBox(width: 10.h,),
                Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: Colors.black87,
                              fontSize: 15.sp
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void getSharedPreference() async{
    prefs = await SharedPreferences.getInstance();
  }




}
