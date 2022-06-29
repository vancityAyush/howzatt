import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/LoginBloc/LoginBloc.dart';
import 'package:howzatt/Repository/LoginRepository.dart';
import 'package:howzatt/ui/Authentication/VerifyOtp.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleOne.dart';


class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => LoginBloc(LoginRepository(Dio())),
        child: LoginPageStateful(),
      ),
    );
  }
}

class LoginPageStateful extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPageStateful> {

  TextEditingController phoneNumberController = new TextEditingController();
  bool btnClick = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.colorPrimary,
      body: BlocListener<LoginBloc,LoginState>(
        listener: (context,state){
          if(state is LoginCompleteState){
            Get.to(VerifyOtp(phoneNumberController.text));
          }
        },
        child: SafeArea(
            child:Padding(
                padding: EdgeInsets.only(left: 20.w,top: 20.h,bottom: 20.h,right: 20.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue With Phone', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RoMedium',
                              color: ColorConstants.colorBlack,
                              fontSize: 18.sp
                          ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'We will send One time Password \non this phone Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: ColorConstants.colorBlack,
                                fontSize: 14.sp
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/loginpagephone.png', width: 120.w ,height: 120.h,)
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter Your Phone Number',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RoThin',
                                color: ColorConstants.colorBlack,
                                fontSize: 14.sp
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              //height: 40.h,
                              width: 240.w,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide( //                   <--- left side
                                    color: Colors.black54,
                                    width: 0.5.sp,
                                  ),)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CountryCodePicker(
                                    onChanged: print,
                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    initialSelection: 'IN',
                                    favorite: ['+91','IN'],
                                    // optional. Shows only country name and flag
                                    showCountryOnly: false,
                                    // optional. Shows only country name and flag when popup is closed.
                                    showOnlyCountryWhenClosed: false,
                                    // optional. aligns the flag and the Text left
                                    alignLeft: false,
                                  ),
                                  Expanded(
                                      child: TextFormField(
                                          controller: phoneNumberController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            errorMaxLines: 1,
                                            errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
                                          ),
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            setState((){
                                              if(phoneNumberController.text.length > 10) {
                                                btnClick = false;
                                              }
                                            });
                                          }
                                      )
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      (btnClick == true && phoneNumberController.text == "") ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 40.w,),
                          Text("Please enter phone no.", style: TextStyle(fontFamily: "RoRegular", fontSize: 12.sp, color: Colors.red, ),)
                        ],
                      ):SizedBox(),
                      SizedBox(
                        height: 70.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState((){
                                btnClick = true;
                                if(phoneNumberController.text != ""){
                                  BlocProvider.of<LoginBloc>(context).add(SendOTPEvent(context:context,mobileNumber: phoneNumberController.text));
                                }
                              });
                            },
                            child: buttonStyleOne("NEXT",context),
                          )
                        ],
                      )
                    ],
                  ),
                )
            )
        ),
      )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

}













