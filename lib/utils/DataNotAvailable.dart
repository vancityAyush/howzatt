import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';


class DataNotAvailable {


  static Widget dataNotAvailable(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Image.asset("assets/images/datanotfound.png",),
           Text(message ,style: TextStyle(color: Colors.grey,fontSize: 20.sp),)
        ],
      ),
    );
  }



}

