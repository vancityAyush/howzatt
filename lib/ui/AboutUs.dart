
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class AboutUs extends StatefulWidget {

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

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
                          Navigator.pop(context);
                        },
                        child:Container(
                          width: 20.w,
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
                            child: Text("About ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                          Center(
                            child: Text("Flip2Play ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
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
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w,),
                            Expanded(child: Text("For the past two decades, Fantasy sports is now one of the most enhanced fast-growing, and profitable online businesses. The present market size is around the US \$18.6 billion and it is expected to rise by \$48.6 billion by the end of 2027. For those who are new to this sector, Fantasy sports are online competitive games where the player can set up its own team of real-life players. The fantasy points are then gained on the basis of real-life statistics and competing with other players having their individual real-life sports player team. Just like real-life sports teams the players can manage their team by adding, dropping, buying, and selling players to keep them up to date.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                            SizedBox(width: 10.w,),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.w,),
                            Expanded(child: Text("Our fantasy sports Flip2Play mainly includes cricket and football games. In which you can easily create your fantasy team and select its players too which is based on real-life that will help you to earn maximum points and you can gain exciting prizes.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                            SizedBox(width: 10.w,),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

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
