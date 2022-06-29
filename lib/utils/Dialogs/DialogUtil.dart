import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stylish_dialog/stylish_dialog.dart';




class DialogUtil{
  static  BuildContext? dialogContext;

  static showProgressDialog(String message,BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor:Colors.transparent,
          child: JumpingDotsProgressIndicator(
            fontSize: 100.sp,
            color: ColorConstants.colorLoginBtn,
          ),
        );
      },
    );
  }

  static dismissProgressDialog(BuildContext context){
    Get.back();
  }

  static showInfoDialog(String title,String message,BuildContext context){
    return StylishDialog(
        context: context,
        backgroundColor: ColorConstants.colorWhite,
        alertType: StylishDialogType.INFO,
        style:  Style.Default,
        progressColor: ColorConstants.colorWhite,
        titleText: title,
        titleStyle: TextStyle(
          fontSize: 15.sp,
          color: ColorConstants.colorBlack,
          fontWeight: FontWeight.bold
        ),
        contentStyle: TextStyle(
        fontSize: 15.sp,
        color: ColorConstants.colorBlackHint,
        ),
        contentText: message,
        confirmButton: ElevatedButton(
          child: Text('Dismiss',style: TextStyle(
              fontSize: 15.sp,
              color: ColorConstants.colorhintText,
              fontWeight: FontWeight.bold)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              primary: ColorConstants.colorLoginBtn,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorConstants.colorWhite,
                  fontWeight: FontWeight.bold)
          ),
        ),
        dismissOnTouchOutside: true
    ).show();
  }

}