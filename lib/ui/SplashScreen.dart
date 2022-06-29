import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/UI/Authentication/LoginPage.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  UserDataService userDataService =  getIt<UserDataService>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child:  Image.asset('assets/images/howzattlogo.png', width: 300.w,height: 300.h,)
      ),
    );
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startHome();
  }
  
  Future<void> startHome() async {
    await Future.delayed(Duration( milliseconds: 2000));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token').toString() == "" || prefs.getString('token').toString() == "null"){
      Get.to(LoginPage());
    }
    else{
      Get.to(HomePage());
    }
  }
}













