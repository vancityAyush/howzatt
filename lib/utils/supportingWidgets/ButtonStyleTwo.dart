import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';

Widget buttonStyleTwo(String btnName,BuildContext context){

  return SizedBox(
    width: 170.w,
    height: 40.h,
    child: Card(
      elevation: 1,
      color: ColorConstants.colorBtnOne,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.h), topRight: Radius.circular(100.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/cricket.png', width: 40.w ,height: 100.h),
          SizedBox(width: 10.h,),
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
        ],
      ),
    )
  );

}