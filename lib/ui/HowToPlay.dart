
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class HowToPlay extends StatefulWidget {

  @override
  _HowToPlayState createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {

  bool acceptConditions = true;
  final buttonHeight = 50.h;

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
                          Navigator.pop(context);
                        },
                        child:Container(
                         // width: 40.w,
                          height: 20.h,
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
                            child: Text("How to Play ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 18.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      )),
                      SizedBox(width: 20.h,),
                    ],
                  ),
                  SizedBox(
                      height:20.h
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.h,right: 20.w,top: 30.h),
                            child: Container(
                              height: 140.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                gradient: LinearGradient(
                                    colors: [
                                       Color(0xFF9E9E9E),
                                       Color(0xFFBDBDBD),
                                    ],
                                    begin:  FractionalOffset(0.0, 0.0),
                                    end:  FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: SizedBox()
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(height: buttonHeight, color: Colors.transparent),
                                      Transform.translate(
                                        offset: Offset(0.0, -buttonHeight/1.h ),
                                        child: Padding(
                                            padding: EdgeInsets.only(right: 10.w,left: 10.w),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        child: Center(
                                                          child: Text("1" , style: TextStyle(color: Colors.white,fontSize: 18.sp, fontWeight: FontWeight.bold,
                                                            fontFamily: 'RoRegular',),),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Color(0xFF8D070E),
                                                                Color(0xFF9B0D1C),
                                                              ],
                                                              begin:  FractionalOffset(0.0, 0.0),
                                                              end:  FractionalOffset(1.0, 0.0),
                                                              stops: [0.0, 1.0],
                                                              tileMode: TileMode.clamp
                                                          ),
                                                      ),
                                                    )
                                                ),),
                                                SizedBox(width: 40.w,),
                                                Image.asset("assets/images/htp1.png",height: 80.h,)
                                              ],
                                            )
                                        )
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(width: 10.w,),
                                              Text(
                                                "Select a match",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 16.sp
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(width: 10.w,),
                                              Text(
                                                "Choose an upcoimng match that you want to play",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoLight',
                                                    color: Colors.black,
                                                    fontSize: 14.sp
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h,right: 20.w,top: 50.h),
                            child: Container(
                              height: 140.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF9E9E9E),
                                      Color(0xFFBDBDBD),
                                    ],
                                    begin:  FractionalOffset(0.0, 0.0),
                                    end:  FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: SizedBox()
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(height: buttonHeight, color: Colors.transparent),
                                      Transform.translate(
                                          offset: Offset(0.0, -buttonHeight/1.h ),
                                          child: Padding(
                                              padding: EdgeInsets.only(right: 10.w,left: 10.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: Center(
                                                            child: Text("2" , style: TextStyle(color: Colors.white,fontSize: 18.sp, fontWeight: FontWeight.bold,
                                                              fontFamily: 'RoRegular',),),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Color(0xFF8D070E),
                                                                  Color(0xFF9B0D1C),
                                                                ],
                                                                begin:  FractionalOffset(0.0, 0.0),
                                                                end:  FractionalOffset(1.0, 0.0),
                                                                stops: [0.0, 1.0],
                                                                tileMode: TileMode.clamp
                                                            ),
                                                          ),
                                                        )
                                                    ),),
                                                  SizedBox(width: 40.w,),
                                                  Image.asset("assets/images/htp2.png",height: 80.h,)
                                                ],
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w,),
                                                Text(
                                                  "Create Team",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black,
                                                      fontSize: 16.sp
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w,),
                                                Text(
                                                  "Use your skills to pick the right players",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'RoLight',
                                                      color: Colors.black,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.h,right: 20.w,top: 50.h),
                            child: Container(
                              height: 140.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF9E9E9E),
                                      Color(0xFFBDBDBD),
                                    ],
                                    begin:  FractionalOffset(0.0, 0.0),
                                    end:  FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: SizedBox()
                                    ),
                                  ),
                                  Stack(
                                    children: [
                                      Container(height: buttonHeight, color: Colors.transparent),
                                      Transform.translate(
                                          offset: Offset(0.0, -buttonHeight/1.h ),
                                          child: Padding(
                                              padding: EdgeInsets.only(right: 10.w,left: 10.w),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: Center(
                                                            child: Text("3" , style: TextStyle(color: Colors.white,fontSize: 18.sp, fontWeight: FontWeight.bold,
                                                              fontFamily: 'RoRegular',),),
                                                          ),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            gradient: LinearGradient(
                                                                colors: [
                                                                  Color(0xFF8D070E),
                                                                  Color(0xFF9B0D1C),
                                                                ],
                                                                begin:  FractionalOffset(0.0, 0.0),
                                                                end:  FractionalOffset(1.0, 0.0),
                                                                stops: [0.0, 1.0],
                                                                tileMode: TileMode.clamp
                                                            ),
                                                          ),
                                                        )
                                                    ),),
                                                  SizedBox(width: 40.w,),
                                                  Image.asset("assets/images/htp3.png",height: 80.h,)
                                                ],
                                              )
                                          )
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w,),
                                                Text(
                                                  "Join Contests",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black,
                                                      fontSize: 16.sp
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 10.w,),
                                                Text(
                                                  "Choose between different contests and win money",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'RoLight',
                                                      color: Colors.black,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
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
