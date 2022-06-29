import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/OTPBloc/OTPBloc.dart';
import 'package:howzatt/Repository/LoginRepository.dart';
import 'package:howzatt/Repository/OTPRepository.dart';
import 'package:howzatt/ui/Authentication/UserInformation.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleOne.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Bloc/LoginBloc/LoginBloc.dart';



class VerifyOtp extends StatelessWidget {

  String? mobileNumber;

  VerifyOtp(String? _value){
    mobileNumber = _value;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => OTPBloc(OTPRepository(Dio())),
        child: VerifyOtpStateful(mobileNumber),
      ),
    );
  }
}

class VerifyOtpStateful extends StatefulWidget {
  String? mobileNumber;

  VerifyOtpStateful(String? _value){
    mobileNumber = _value;
  }

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}


class _VerifyOtpState extends State<VerifyOtpStateful> {


  TextEditingController otpController = new TextEditingController();
  bool btnClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.colorPrimary,
        body: BlocListener<OTPBloc,OTPState>(
          listener: (context,state){
            if(state is OTPCompleteState){
              if(state.isNotRegistered == true){
                Get.to(UserInformation(widget.mobileNumber));
              }
              else{
                Get.to(HomePage());
              }
            }
            else if(state is ResendOTPCompleteState){
              DialogUtil.showInfoDialog("Info","OTP Sent on +91 "+widget.mobileNumber.toString(),context);
            }
          },
          child: SafeArea(
              child:Padding(
                  padding: EdgeInsets.only(left: 20.w,top: 20.h,bottom: 20.h,right: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.h))),
                                child: Container(
                                    height: 25.h,
                                    width: 25.h,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Center(
                                        child: Image.asset('assets/images/leftarrow.png', width: 15.w ,height: 15.h,)
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Verify Mobile Number', style: TextStyle(
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
                              'We have sent verification code to '+widget.mobileNumber.toString()+ ', \nEnter the code below boxes',
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
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/verifyotp.png' ,height: 150.h,)
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 240.w,
                              child: PinCodeTextField(
                                controller: otpController,
                                appContext: context,
                                pastedTextStyle: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                                length: 4,
                                obscureText:false,
                                blinkWhenObscuring: true,
                                animationType: AnimationType.fade,
                                validator: (v) {
                                  if (v!.length < 3) {
                                    return "";
                                  } else {
                                    return null;
                                  }
                                },
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5.h),
                                    fieldHeight: 50.h,
                                    fieldWidth: 40.w,
                                    activeFillColor: Colors.white,
                                    activeColor: Colors.white,
                                    selectedColor: ColorConstants.colorPrimary,
                                    selectedFillColor: Colors.white,
                                    inactiveColor: Colors.white,
                                    inactiveFillColor: Colors.white
                                ),
                                cursorColor: Colors.black,
                                animationDuration: Duration(milliseconds: 300),
                                enableActiveFill: true,

                                keyboardType: TextInputType.number,
                                boxShadows: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    color: Colors.black12,
                                    blurRadius: 10.h,
                                  )
                                ],
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onChanged: (value) {
                                  print(value);
                                  setState(() {

                                  });
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  return true;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 60.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                if(otpController.text.length < 4 || otpController.text.length > 4){
                                  DialogUtil.showInfoDialog("Info","Please Enter 4 Digit Valid OTP",context);
                                }
                                else{
                                  BlocProvider.of<OTPBloc>(context).add(VerifyOTPEvent(context:context,mobileNumber: widget.mobileNumber!,otpNumber:otpController.text,));
                                }
                              },
                              child: buttonStyleOne("Verify & Proceed",context),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Receive Code?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: ColorConstants.colorBlack,
                                  fontSize: 10.sp
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                BlocProvider.of<OTPBloc>(context).add(ReSendOTPEvent(context:context,mobileNumber: widget.mobileNumber!));
                              },
                              child:Text(
                                " Resend Code",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: ColorConstants.colorLoginBtn,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),

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













