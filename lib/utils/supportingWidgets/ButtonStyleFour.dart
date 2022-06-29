import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';

Widget buttonStyleFour(BuildContext context){

  return Container(
    width: 150.h,
    height: 60.h,
    padding: EdgeInsets.only(bottom: 0.h),
    decoration: BoxDecoration(
        color: ColorConstants.colorBlack,
        borderRadius: BorderRadius.circular(20.h)
    ),
    child: Padding(
      padding: EdgeInsets.only(right: 0.h,top: 15.h),
      child: Text("Flip2Play" , textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22.sp ,color: ColorConstants.colorhintText),),
    )
  );

}