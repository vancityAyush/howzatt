import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

class PriceAlerts extends StatefulWidget {
  const PriceAlerts({Key? key}) : super(key: key);

  @override
  _PriceAlertsState createState() => _PriceAlertsState();
}


class _PriceAlertsState extends State<PriceAlerts> {


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
                      'Create Price Alerts',
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
        padding: EdgeInsets.only(top: 20.h,bottom: 20.h,left: 18.w,right: 18.w),
        child: Column(
          children: [
            Card(
              elevation: 1.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.h),
              ),
              child:new Container(
                //height: 47.h,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: new Border.all(
                        color: Colors.black12,
                        width: 1.0,
                      ), borderRadius: BorderRadius.all(Radius.circular(5.h))
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(top: 7.h,bottom: 7.h,left: 15.h,right: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/bitcoin.png', width: 25.w ,height: 25.h),
                                ],
                              )
                          ),
                          Image.asset('assets/images/fast_forward.png', width: 12.w ,height: 12.h,color: Colors.grey,),
                        ],
                      )
                  )
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Card(
              elevation: 1.h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.h),
              ),
              child:new Container(
                  height: 37.h,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: new Border.all(
                      color: Colors.black12,
                      width: 1.0,
                    ),
                      borderRadius: BorderRadius.all(Radius.circular(5.h))
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 7.h,bottom: 7.h,left: 15.h,right: 15.h),
                    child: new TextField(
                      textAlign: TextAlign.start,
                      decoration: new InputDecoration(
                        hintText: 'Enter Prices',
                        border: InputBorder.none,
                      ),
                    ),
                  )
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.h,
                ),
                Text("Current Price: ",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: ColorConstants.colorBlackHint,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                ),),
                Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,),
                Text("27,87,197.78 ",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: ColorConstants.colorBlackHint,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                ),),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width.w,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                  color: ColorConstants.colorLoginBtn,
                  borderRadius: BorderRadius.circular(5.h)
              ),
              child: Center(
                child: Text("Create Price Alert",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.white,
                    fontSize: 15.sp
                ),),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text("COIN NAME",textAlign:TextAlign.start,style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: Colors.grey,
                        fontSize: 15.sp
                    ),),
                ),
                Expanded(
                  flex: 1,
                  child: Text("ALERT PRICES",textAlign:TextAlign.end,style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: Colors.grey,
                      fontSize: 15.sp
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 0.h,bottom: 0.h),
              child: Container(
                height: 0.5.h,
                width: MediaQuery.of(context).size.width.w,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 0.h,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 155,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 20.h,bottom: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex:1,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/bitcoin.png",height: 30.h,width: 30.w,),
                                    Padding(
                                        padding: EdgeInsets.only(top: 5.h,left: 5.w),
                                        child: Text("Gala",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 17.sp
                                        ),),
                                    )
                                  ],
                                )
                            ),
                            Expanded(
                              flex:1,
                              child: Padding(
                                padding: EdgeInsets.only(top: 0.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset("assets/images/rupee_indian.png",height: 16.h,width: 16.w,color: Colors.black,),
                                    Text("10,000",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 17.sp
                                    ),),
                                    SizedBox(width: 10.w,),
                                    Image.asset("assets/images/delete.png",height: 25.h,width: 22.w,color: Colors.grey,),
                                  ],
                                ),
                              )
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.w,right: 5.w),
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
            )
          ],
        )
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }



}













