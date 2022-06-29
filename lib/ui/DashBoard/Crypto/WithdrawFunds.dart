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

class WithdrawFunds extends StatefulWidget {
  const WithdrawFunds({Key? key}) : super(key: key);

  @override
  _WithdrawFundsState createState() => _WithdrawFundsState();
}


class _WithdrawFundsState extends State<WithdrawFunds> {


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
                      'INR Withdrawl',
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
        padding: EdgeInsets.only(top: 10.h,bottom: 20.h,left: 15.w,right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("Withdraw INR to your bank account",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp
                ),),)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text("Rs. 4500.00",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp
                ),),)
              ],
            ),
            Text("Current Balance",style: TextStyle(
                fontFamily: 'RoMedium',
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp
            ),),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Expanded(child: Text("Money Would Be Deposited To The Following Bank Account",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp
                ),),)
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  flex: 1,
                  child: Text("BANK NAME",style: TextStyle(
                    fontFamily: 'RoMedium',
                    color: ColorConstants.colorBlackHint,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp
                ),),),
                SizedBox(width: 0.w,),
                Expanded(
                  child: Text("ABCDEFGH",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  flex: 1,
                  child: Text("IFSC CODE",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
                SizedBox(width: 0.w,),
                Expanded(
                  child: Text("9876543",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  flex: 1,
                  child: Text("BRANCH NAME",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
                SizedBox(width: 0.w,),
                Expanded(
                  child: Text("ABCDEFGH",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  flex: 1,
                  child: Text("HOLDER NAME",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
                SizedBox(width: 0.w,),
                Expanded(
                  child: Text("ABCDEFGH",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(width: 10.w,),
                Expanded(
                  flex: 1,
                  child: Text("ACCOUNT NUMBER",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
                SizedBox(width: 0.w,),
                Expanded(
                  child: Text("ABCDEFGH",style: TextStyle(
                      fontFamily: 'RoMedium',
                      color: ColorConstants.colorBlackHint,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp
                  ),),),
              ],
            ),


          ],
        ),
      ),
    );
  }



}













