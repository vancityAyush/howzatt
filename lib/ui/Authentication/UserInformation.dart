import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/ui/Authentication/LoginPage.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleOne.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Bloc/UserInformationBloc/UserInformationBloc.dart';
import '../../Repository/UserInformationRepository.dart';


class UserInformation extends StatelessWidget {

  String? mobileNumber;

  UserInformation(String? _value){
    mobileNumber = _value;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => UserInformationBloc(UserInformationRepository(Dio())),
        child: UserInformationStateful(mobileNumber),
      ),
    );
  }
}

class UserInformationStateful extends StatefulWidget {
  String? mobileNumber;

  UserInformationStateful(String? _value){
    mobileNumber = _value;
  }

  @override
  _UserInformationState createState() => _UserInformationState();
}


class _UserInformationState extends State<UserInformationStateful> {


  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileNumberController = new TextEditingController();
  TextEditingController referalCodeController = new TextEditingController();
  bool btnClick = false;
  bool maleClick = true , femaleClick = false;

  @override
  void initState() {
    super.initState();
    mobileNumberController = new TextEditingController(text: widget.mobileNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.colorPrimary,
        body: BlocListener<UserInformationBloc,UserInformationState>(
          listener: (Context,state){
            if(state is UserInformationCompleteState){
              Get.to(HomePage());
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
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10.h),
                            Text(
                              'Your Information', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RoMedium',
                                color: ColorConstants.colorBlack,
                                fontSize: 20.sp
                            ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Padding(
                          padding:EdgeInsets.only(left: 5.w,top: 0.h,bottom: 0.h,right: 5.h),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 10.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: Offset(
                                    2.0, // Move to right 10  horizontally
                                    2.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 40.h,bottom: 40.h,left: 20.h,right: 20.h),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 0.h,left: 5.h,right: 0.h),
                                        child: Text(
                                          'Your Name', style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorhintText,
                                            fontSize: 12.sp
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Card(
                                        elevation: 1.h,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.h),
                                        ),
                                        child:new Container(
                                            height: 30.h,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 15.h),
                                              child: new TextField(
                                                controller: nameController,
                                                textAlign: TextAlign.start,
                                                decoration: new InputDecoration(
                                                  hintText: '',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      (btnClick == true && nameController.text == "") ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 5.w,),
                                          Text("Please enter name.", style: TextStyle(fontFamily: "RoRegular", fontSize: 12.sp, color: Colors.red, ),)
                                        ],
                                      ):SizedBox(),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 0.h,left: 5.h,right: 0.h),
                                        child: Text(
                                          'Email', style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorhintText,
                                            fontSize: 12.sp
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Card(
                                        elevation: 1.h,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.h),
                                        ),
                                        child:new Container(
                                            height: 30.h,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 15.h),
                                              child: new TextField(
                                                controller: emailController,
                                                textAlign: TextAlign.start,
                                                decoration: new InputDecoration(
                                                  hintText: '',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      (btnClick == true && emailController.text == "") ? Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 5.w,),
                                          Text("Please enter email.", style: TextStyle(fontFamily: "RoRegular", fontSize: 12.sp, color: Colors.red, ),)
                                        ],
                                      ):SizedBox(),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 0.h,left: 5.h,right: 0.h),
                                        child: Text(
                                          'Phone Number', style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorhintText,
                                            fontSize: 12.sp
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Card(
                                        elevation: 1.h,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.h),
                                        ),
                                        child:new Container(
                                            height: 30.h,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 15.h),
                                              child: new TextField(
                                                enabled: false,
                                                controller: mobileNumberController,
                                                textAlign: TextAlign.start,
                                                decoration: new InputDecoration(
                                                  hintText: '',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 0.h,left: 5.h,right: 0.h),
                                        child: Text(
                                          'Referal Code', style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorhintText,
                                            fontSize: 12.sp
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Card(
                                        elevation: 1.h,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.h),
                                        ),
                                        child:new Container(
                                            height: 30.h,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              border: new Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 5.h,right: 15.h),
                                              child: new TextField(
                                                controller: referalCodeController,
                                                textAlign: TextAlign.start,
                                                decoration: new InputDecoration(
                                                  hintText: '',
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 0.h,left: 5.h,right: 0.h),
                                        child: Text(
                                          'Gender', style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: ColorConstants.colorhintText,
                                            fontSize: 12.sp
                                        ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex:1,
                                            child: GestureDetector(
                                              onTap: (){
                                                setState((){
                                                  maleClick = true;
                                                  femaleClick = false;
                                                });
                                              },
                                              child: Card(
                                                elevation: 1.h,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.h),
                                                ),
                                                child:new Container(
                                                    height: 30.h,
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      border: new Border.all(
                                                        color: maleClick ? Colors.green : Colors.white,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 15.h),
                                                        child: Center(
                                                          child: Text(
                                                            'Male',  textAlign:TextAlign.center, style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: ColorConstants.colorBlack,
                                                              fontSize: 12.sp
                                                          ),
                                                          ),
                                                        )
                                                    )
                                                ),
                                              ),
                                            )
                                          ),
                                          Expanded(
                                              flex:1,
                                              child: GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    maleClick = false;
                                                    femaleClick = true;
                                                  });
                                                },
                                                child:Card(
                                                  elevation: 1.h,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.h),
                                                  ),
                                                  child:new Container(
                                                    height: 30.h,
                                                    decoration: new BoxDecoration(
                                                      shape: BoxShape.rectangle,
                                                      border: new Border.all(
                                                        color: femaleClick ? Colors.green : Colors.white,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 15.h),
                                                        child: Center(
                                                          child: Text(
                                                            'Female',  textAlign:TextAlign.center,style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: ColorConstants.colorBlack,
                                                              fontSize: 12.sp
                                                          ),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                )
                                              )
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                setState((){
                                  btnClick = true;
                                  if(nameController.text != "" && emailController.text != ""){
                                    BlocProvider.of<UserInformationBloc>(context).add(CreateUserEvent(context:context,name:nameController.text,mobileNumber: widget.mobileNumber!,email:emailController.text,referalCode:referalCodeController.text));
                                  }
                                });
                              },
                              child: buttonStyleOne("NEXT",context),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                      ],
                    ),
                  )
              )
          ),
        )
    );
  }



}













