import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/Profile/UserProfile.dart';
import 'package:howzatt/utils/ColorConstants.dart';

import '../../../Bloc/UserInformationBloc/UserInformationBloc.dart';
import '../../../Repository/UserInformationRepository.dart';

class KYCUpdate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => UserInformationBloc(UserInformationRepository(Dio())),
        child: KYCUpdateStateful(),
      ),
    );
  }
}

class KYCUpdateStateful extends StatefulWidget {
  @override
  _KYCUpdateState createState() => _KYCUpdateState();
}

class _KYCUpdateState extends State<KYCUpdateStateful> {
  UserDataService userDataService = getIt<UserDataService>();
  int _radioSelected = 1;
  String? _radioVal = "Male";
  DateTime selectedDate = DateTime.now();
  TextEditingController nameController = new TextEditingController();
  TextEditingController dateOfBirth = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController accountNumberController = new TextEditingController();
  TextEditingController accountHolderNameController =
      new TextEditingController();
  TextEditingController ifscCodeController = new TextEditingController();
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController panNumberController = new TextEditingController();
  TextEditingController aadharNumberController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
              color: Colors.black,
              height: 70.h,
              child: Padding(
                padding: EdgeInsets.only(top: 35.sp),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        SizedBox(
                          width: 5.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            'assets/images/back_arrow.png',
                            width: 40.w,
                            height: 15.h,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 0.h,
                        ),
                        Text(
                          'KYC UPDATE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: Colors.white,
                              fontSize: 15.sp),
                        ),
                      ],
                    )),
                  ],
                ),
              )),
        ),
        body: BlocListener<UserInformationBloc, UserInformationState>(
          listener: (context, state) {
            if (state is UserInformationCompleteState) {
              Get.to(UserProfile());
            }
            if (state is UploadPanImageCompleteState) {
              setState(() {
                userDataService = state.userDataService;
              });
            }
            if (state is UploadAadharFrontImageCompleteState) {
              setState(() {
                userDataService = state.userDataService;
              });
            }
            if (state is UploadAadharBackImageCompleteState) {
              setState(() {
                userDataService = state.userDataService;
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: 20.h, bottom: 20.h, left: 15.w, right: 15.w),
            child: ListView(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "NAME*",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  elevation: 1.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                  child: new Container(
                      height: 35.h,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: ColorConstants.colorhintText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 2.h, bottom: 2.h, left: 15.h, right: 15.h),
                        child: new TextField(
                          controller: nameController,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "DATE OF BIRTH(DD-MM-YYYY)*",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                    elevation: 1.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.h),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                          height: 35.h,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(
                              color: ColorConstants.colorhintText,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 2.h,
                                  left: 15.h,
                                  right: 15.h),
                              child: new Text(selectedDate.toString()))),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Gender*",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  elevation: 1.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                  child: new Container(
                      height: 35.h,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: ColorConstants.colorhintText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 2.h, bottom: 2.h, left: 15.h, right: 15.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Male'),
                              Radio(
                                value: 1,
                                groupValue: _radioSelected,
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected =
                                        int.parse(value.toString());
                                    _radioVal = 'male';
                                  });
                                },
                              ),
                              Text('Female'),
                              Radio(
                                value: 2,
                                groupValue: _radioSelected,
                                activeColor: Colors.pink,
                                onChanged: (value) {
                                  setState(() {
                                    _radioSelected =
                                        int.parse(value.toString());
                                    _radioVal = 'female';
                                  });
                                },
                              )
                            ],
                          ))),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "ADDRESS*",
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  elevation: 1.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                  child: new Container(
                      height: 80.h,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: ColorConstants.colorhintText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 2.h, bottom: 2.h, left: 15.h, right: 15.h),
                        child: new TextField(
                          maxLines: 4,
                          textAlign: TextAlign.start,
                          decoration: new InputDecoration(
                            hintText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "Bank Details*",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  elevation: 1.h,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.h),
                  ),
                  child: new Container(
                      height: 270.h,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: ColorConstants.colorhintText,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 5.h, bottom: 5.h, left: 5.h, right: 5.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Account NUMBER*",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Card(
                                elevation: 1.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: new Container(
                                    height: 35.h,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: ColorConstants.colorhintText,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 2.h,
                                          left: 15.h,
                                          right: 15.h),
                                      child: new TextField(
                                        controller: accountNumberController,
                                        textAlign: TextAlign.start,
                                        decoration: new InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "Account Holder*",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Card(
                                elevation: 1.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: new Container(
                                    height: 35.h,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: ColorConstants.colorhintText,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 2.h,
                                          left: 15.h,
                                          right: 15.h),
                                      child: new TextField(
                                        controller: accountHolderNameController,
                                        textAlign: TextAlign.start,
                                        decoration: new InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "IFSC*",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Card(
                                elevation: 1.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: new Container(
                                    height: 35.h,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: ColorConstants.colorhintText,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 2.h,
                                          left: 15.h,
                                          right: 15.h),
                                      child: new TextField(
                                        controller: ifscCodeController,
                                        textAlign: TextAlign.start,
                                        decoration: new InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "BANK NAME*",
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Card(
                                elevation: 1.h,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: new Container(
                                    height: 35.h,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: new Border.all(
                                        color: ColorConstants.colorhintText,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 2.h,
                                          left: 15.h,
                                          right: 15.h),
                                      child: new TextField(
                                        controller: bankNameController,
                                        textAlign: TextAlign.start,
                                        decoration: new InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ))),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Card(
                    elevation: 3.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "PAN NUMBER*",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 1.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: new Container(
                                height: 35.h,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: ColorConstants.colorhintText,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h,
                                      bottom: 2.h,
                                      left: 15.h,
                                      right: 15.h),
                                  child: new TextField(
                                    controller: panNumberController,
                                    textAlign: TextAlign.start,
                                    decoration: new InputDecoration(
                                      hintText: '',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Please your PAN Number",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 1.h,
                            color: ColorConstants.colorhintText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: new Container(
                                height: 80.h,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: ColorConstants.colorhintText,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        bottom: 2.h,
                                        left: 15.h,
                                        right: 20.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Upload PAN Card",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: ColorConstants
                                                      .colorGreenHint,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            (userDataService
                                                        .userData.pan_image !=
                                                    "")
                                                ? Image.network(
                                                    "https://picsum.photos/250?image=9",
                                                    height: 50.h,
                                                    width: 100.w,
                                                  )
                                                : Text(
                                                    "Add your file in this field",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ],
                                        )),
                                        GestureDetector(
                                          onTap: () async {
                                            FilePickerResult? result =
                                                await FilePicker.platform
                                                    .pickFiles(
                                              type: FileType.custom,
                                              allowedExtensions: [
                                                'jpg',
                                                'pdf',
                                                'doc'
                                              ],
                                            );
                                            if (result != null) {
                                              File file = File(result
                                                  .files.single.path
                                                  .toString());
                                              BlocProvider.of<
                                                          UserInformationBloc>(
                                                      context)
                                                  .add(UploadPanImageEvent(
                                                      context: context,
                                                      panCardImage: file));
                                            } else {}
                                          },
                                          child: Image.asset(
                                              'assets/images/upload_arrow.png',
                                              width: 25.w,
                                              height: 25.h),
                                        )
                                      ],
                                    ))),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Card(
                    elevation: 3.h,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.h),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "AADHAR NUMBER*",
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 1.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: new Container(
                                height: 35.h,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: ColorConstants.colorhintText,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 2.h,
                                      bottom: 2.h,
                                      left: 15.h,
                                      right: 15.h),
                                  child: new TextField(
                                    controller: aadharNumberController,
                                    textAlign: TextAlign.start,
                                    decoration: new InputDecoration(
                                      hintText: '',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 5.w,
                              ),
                              Text(
                                "Please your Aadhar Number",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 1.h,
                            color: ColorConstants.colorhintText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: new Container(
                                height: 80.h,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: ColorConstants.colorhintText,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        bottom: 2.h,
                                        left: 15.h,
                                        right: 20.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Upload Aadhar Card FrontImage",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: ColorConstants
                                                      .colorGreenHint,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            (userDataService.userData
                                                        .aadhaar_front_image !=
                                                    "")
                                                ? Image.network(
                                                    "https://picsum.photos/250?image=9",
                                                    height: 50.h,
                                                    width: 100.w,
                                                  )
                                                : Text(
                                                    "Add your file in this field",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ],
                                        )),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              'assets/images/upload_arrow.png',
                                              width: 25.w,
                                              height: 25.h),
                                        )
                                      ],
                                    ))),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Card(
                            elevation: 1.h,
                            color: ColorConstants.colorhintText,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.h),
                            ),
                            child: new Container(
                                height: 80.h,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: ColorConstants.colorhintText,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 2.h,
                                        bottom: 2.h,
                                        left: 15.h,
                                        right: 20.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Upload Aadhar Card BackImage",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: ColorConstants
                                                      .colorGreenHint,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            (userDataService.userData
                                                        .aadhaar_back_image !=
                                                    "")
                                                ? Image.network(
                                                    "https://picsum.photos/250?image=9",
                                                    height: 50.h,
                                                    width: 100.w,
                                                  )
                                                : Text(
                                                    "Add your file in this field",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                          ],
                                        )),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Image.asset(
                                              'assets/images/upload_arrow.png',
                                              width: 25.w,
                                              height: 25.h),
                                        )
                                      ],
                                    ))),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                GestureDetector(
                  onTap: () {
                    var bank = {
                      'account-no': accountNumberController.text,
                      'account-holder': accountHolderNameController.text,
                      'ifsc-code': ifscCodeController.text,
                      'bankname': bankNameController.text
                    };
                    BlocProvider.of<UserInformationBloc>(context).add(
                        UploadUserProfileEvent(
                            context: context,
                            name: nameController.text.toString(),
                            gender: _radioVal.toString(),
                            address: addressController.text.toString(),
                            bank: bank,
                            pan: panNumberController.text.toString(),
                            aadhaar: aadharNumberController.text.toString(),
                            dob: selectedDate.toString(),
                            fcm_token: "",
                            kyc: "true"));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width.w / 1.5,
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                        color: ColorConstants.colorLoginBtn,
                        borderRadius: BorderRadius.circular(5.h)),
                    child: Center(
                      child: Text(
                        "UPDATE",
                        style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: Colors.white,
                            fontSize: 15.sp),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
