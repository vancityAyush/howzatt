import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class HelpDesk extends StatefulWidget {

  @override
  _HelpDeskState createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {

  bool acceptConditions = true;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: ColorConstants.colorPrimary
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      SizedBox(width: 10.h,),
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child:Container(
                          width: 10.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), //here we set the circular figure
                              color: ColorConstants.colorWhite
                          ),
                          child: Center(
                              child:Icon(Icons.arrow_back)
                          ),
                        ),),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("Help ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      )),
                      SizedBox(width: 20.h,),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/help_desk.png", width: 130.w ,height: 130.h,),
                          ],
                        ),
                        SizedBox(
                            height:20.h
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0.h,bottom: 10.h,left: 10.w,right: 10.w),
                          child: Container(
                            height: 230.h,
                            width: MediaQuery.of(context).size.width.w,
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h,bottom: 10.h,left: 10.w,right: 10.w),
                                child: Column(
                                  children: [
                                     Row(
                                       children: [
                                         Icon(Icons.email , color: Colors.black,size: 30.sp,),
                                         SizedBox(width: 10.w,),
                                         Text("Email/Call",style: TextStyle(fontSize: 18.sp,color: Colors.black,fontWeight: FontWeight.bold),)
                                       ],
                                     ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Text("In case of any query,",style: TextStyle(fontSize: 14.sp,color: Colors.grey,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Please contact us to below details",style: TextStyle(fontSize: 14.sp,color: Colors.grey,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Email will be sent to:",style: TextStyle(fontSize: 12.sp,color: ColorConstants.colorBlackHint,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("info@flip2play.com",style: TextStyle(fontSize: 18.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("OR",style: TextStyle(fontSize: 20.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("9871953371/9999267080",style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlackHint,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("(9 AM TO 9 PM)",style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),)
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          )
                        )
                      ],
                    )
                  )

                ],
              ),
            ),
          ),
        )) ;

  }

  @override
  void initState() {
    super.initState();
  }


}
