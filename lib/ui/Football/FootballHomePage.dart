import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class FootballHomePage extends StatefulWidget {

  @override
  _FootballHomePageState createState() => _FootballHomePageState();
}

class _FootballHomePageState extends State<FootballHomePage> {



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
                          //height: 40.h,
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
                            child: Text(" ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.bold),),
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
                              Image.asset("assets/images/football.png", width: 200.w ,height: 200.h,),
                            ],
                          ),
                          SizedBox(
                              height:20.h
                          ),
                          Text("Coming Soon",style: TextStyle(fontSize: 25.sp,color: Colors.black,fontWeight: FontWeight.bold),)
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
