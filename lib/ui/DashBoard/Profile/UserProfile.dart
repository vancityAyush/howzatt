import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/MyMatches.dart';
import 'package:howzatt/ui/DashBoard/Profile/IndianRupees.dart';
import 'package:howzatt/ui/DashBoard/Profile/KYCUpdate.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:share_plus/share_plus.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}


class _UserProfileState extends State<UserProfile> {
  UserDataService userDataService =  getIt<UserDataService>();

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
            color: Colors.white,
            height: 70.h,
            child: Padding(
                padding: EdgeInsets.only(top: 30.h,bottom: 5.h,left: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.w,),
                            Text(
                              userDataService.userData.name.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18.sp
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: 10.w,),
                            Text(
                              userDataService.userData.email.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 14.sp
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )
            )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h,bottom: 20.h,left: 15.w,right: 15.w),
        child: ListView(
          children: [
            GestureDetector(
              onTap: (){
                Fluttertoast.showToast(
                    msg: "Crypto Wallet Coming Soon.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1
                );
                //Get.to(IndianRupees());
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context) => IndianRupees()));
              },
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
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("Available to Invest",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    /*Row(
                                      children: [
                                        SizedBox(
                                          width: 0.h,
                                        ),
                                        Image.asset("assets/images/rupee_indian.png",height: 15.h,width: 15.w,),
                                        Text("0.08",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                      ],
                                    ),*/
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            /*GestureDetector(
              onTap: (){

              },
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
                            Image.asset("assets/images/account.png",height: 18.h,width: 18.w,),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("Account Settings",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.h,
                                        ),
                                        Text("Manage Your KYC , Bank Details etc",style: TextStyle(
                                            fontFamily: 'RoLight',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),*/

            GestureDetector(
              onTap: (){
                Share.share('Your Referal Code is '+userDataService.userData.referal.toString());
              },
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
                            Image.asset("assets/images/profileinviteearn.png",height: 25.h,width: 25.w,),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("Invite and Earn",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.h,
                                        ),
                                        Text("Invite Your friends and earn Reward",style: TextStyle(
                                            fontFamily: 'RoLight',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: (){
                Get.to(MyMatches());
              },
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
                            Image.asset("assets/images/profilemymatches.png",height: 25.h,width: 25.w,),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("My Matches",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            /*Card(
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
                          Image.asset("assets/images/about.png",height: 18.h,width: 18.w,),
                          SizedBox(
                            width: 6.w,
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("About Flip2Play",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: ColorConstants.colorBlackHint,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp
                                      ),),
                                      SizedBox(width: 5.h,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 0.h,
                                      ),
                                      Text("About , Terms of Use , Privacy Policy",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12.sp
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              )),
                          Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                        ],
                      )
                  )
              ),
            ),
            SizedBox(
              height: 15.h,
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
                          Image.asset("assets/images/customersupport.png",height: 25.h,width: 25.w,),
                          SizedBox(
                            width: 6.w,
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("Help & Support",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: ColorConstants.colorBlackHint,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp
                                      ),),
                                      SizedBox(width: 5.h,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 0.h,
                                      ),
                                      Text("Get help with your account",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12.sp
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              )),
                          Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                        ],
                      )
                  )
              ),
            ),
            SizedBox(
              height: 15.h,
            ),*/
            GestureDetector(
              onTap: (){
                Get.to(KYCUpdate());
              },
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
                            Image.asset("assets/images/profileimage_one.png",height: 25.h,width: 25.w,),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("KYC Details",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.h,
                                        ),
                                        Text("Manage Your KYC , Bank Details etc ,\n KYC Pending",style: TextStyle(
                                            fontFamily: 'RoLight',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            ),
            /*SizedBox(
              height: 15.h,
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
                          Image.asset("assets/images/account.png",height: 25.h,width: 25.w,),
                          SizedBox(
                            width: 6.w,
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      Text("Profile Details",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: ColorConstants.colorBlackHint,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp
                                      ),),
                                      SizedBox(width: 5.h,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.h,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 0.h,
                                      ),
                                      Text("Manage details, password & security",style: TextStyle(
                                          fontFamily: 'RoLight',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          fontSize: 12.sp
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                ],
                              )),
                          Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                        ],
                      )
                  )
              ),
            ),*/
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: (){
              },
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
                            Image.asset("assets/images/bank_account.png",height: 18.h,width: 18.w,),
                            SizedBox(
                              width: 6.w,
                            ),
                            Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("Bank Account",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorBlackHint,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp
                                        ),),
                                        SizedBox(width: 5.h,),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 0.h,
                                        ),
                                        Text("Manage Bank Details ",style: TextStyle(
                                            fontFamily: 'RoLight',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                            fontSize: 12.sp
                                        ),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                )),
                            Image.asset('assets/images/right_arrow.png', width: 18.w ,height: 18.h,color: ColorConstants.colorBlackHint,),
                          ],
                        )
                    )
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }



}













