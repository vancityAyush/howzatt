import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';

Widget buttonStyleOne(String btnName,BuildContext context){

  return Container(
    width: MediaQuery.of(context).size.width.w/1.5,
    padding: EdgeInsets.all(10.h),
    decoration: BoxDecoration(
        color: ColorConstants.colorLoginBtn,
        borderRadius: BorderRadius.circular(5.h)
    ),
    child: Center(
      child: Text(btnName,style: TextStyle(
          fontFamily: 'RoMedium',
          color: Colors.white,
          fontSize: 15.sp
      ),),
    ),
  );

}