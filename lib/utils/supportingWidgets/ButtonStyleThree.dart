import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';

Widget buttonStyleThree(String btnName,BuildContext context){

  return Container(
    width: 170.w,
    height: 40.h,
    decoration: BoxDecoration(
      color: ColorConstants.colorBtnOne,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.h),topLeft: Radius.circular(100.h))
    ),
    child: Card(
      elevation: 1,
      color: ColorConstants.colorBtnOne,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.h), topLeft: Radius.circular(100.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'RoMedium',
                color: ColorConstants.colorLoginBtn,
                fontSize: 15.sp
            ),
          ),
          SizedBox(width: 10.h,),
          Image.asset('assets/images/football.png', width: 50.w ,height: 100.h),
        ],
      ),
    )
  );

}