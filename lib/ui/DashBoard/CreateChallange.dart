import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleOne.dart';

class CreateChallange extends StatefulWidget {


  @override
  _CreateChallangeState createState() => _CreateChallangeState();
}


class _CreateChallangeState extends State<CreateChallange> {

  TextEditingController phoneNumberController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            color: Colors.black,
            height: 70.h,
            child:Padding(
              padding: EdgeInsets.only(top: 35.sp),
              child: Row(
                children: [
                   Expanded(
                     child:  Row(
                     children: [
                       SizedBox(
                         width: 5.h,
                       ),
                       InkWell(
                         onTap: (){
                           Navigator.pop(context);
                         },
                         child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                       ),
                       SizedBox(
                         width: 0.h,
                       ),
                       Text(
                         'Create Challenge',
                         textAlign: TextAlign.center,
                         style: TextStyle(
                             fontFamily: 'RoMedium',
                             color: Colors.white,
                             fontSize: 15.sp
                         ),
                       ),
                     ],
                    )
                   ),
                  Image.asset('assets/images/view_challenge.png', width: 100.w ,height: 50.h),
                  SizedBox(width: 0.h,)
                ],
              ),
            )
          ),
        ),
        body: SafeArea(
            child:SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w,right: 20.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Card(
                      elevation: 2.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      child:new Container(
                          height: 40.h,
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(
                              color: Colors.black12,
                              width: 1.0,
                            ), borderRadius: BorderRadius.all(Radius.circular(4.h))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 15.h),
                            child: new TextField(
                              textAlign: TextAlign.start,
                              decoration: new InputDecoration(
                                hintText: 'Challenge Name',
                                hintStyle: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Card(
                      elevation: 2.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      child:new Container(
                          height: 40.h,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.black12,
                                width: 1.0,
                              ), borderRadius: BorderRadius.all(Radius.circular(4.h))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 10.h),
                            child: Row(
                              children: [
                                Expanded(child: new TextField(
                                  textAlign: TextAlign.start,
                                  decoration: new InputDecoration(
                                    hintText: 'Select League',
                                    hintStyle: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold),
                                    border: InputBorder.none,
                                  ),
                                ),),
                                Image.asset('assets/images/down_arrow.png', width: 15.w ,height: 20.h,)
                              ],
                            )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Card(
                      elevation: 2.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      child:new Container(
                          height: 40.h,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.black12,
                                width: 1.0,
                              ), borderRadius: BorderRadius.all(Radius.circular(4.h))
                          ),
                          child: Padding(
                              padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 10.h),
                              child: Row(
                                children: [
                                  Expanded(child: new TextField(
                                    textAlign: TextAlign.start,
                                    decoration: new InputDecoration(
                                      hintText: 'Select Match',
                                      hintStyle: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                    ),
                                  ),),
                                  Image.asset('assets/images/down_arrow.png', width: 15.w ,height: 20.h,)
                                ],
                              )
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Add Participent', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'RoMedium',
                                        color: Colors.black87,
                                        fontSize: 13.sp
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    TextButton(
                                        child: Text(
                                            "8871690880",
                                            style: TextStyle(fontSize: 14,color: Colors.black12,)
                                        ),
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5.sp)),
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black12),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.sp),
                                                    side: BorderSide(color: Colors.black12)
                                                )
                                            )
                                        ),
                                        onPressed: () {

                                        }
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    TextButton(
                                        child: Text(
                                            "8871690880",
                                            style: TextStyle(fontSize: 14,color: Colors.black12,)
                                        ),
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(5.sp)),
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.black12),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.sp),
                                                    side: BorderSide(color: Colors.black12)
                                                )
                                            )
                                        ),
                                        onPressed: () {

                                        }
                                    ),
                                  ],
                                )

                              ],
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Add More', style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'RoMedium',
                                        color: Colors.black87,
                                        fontSize: 10.sp
                                    ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Container(
                                        height: 30.h,
                                        width: 35.w,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              color: Colors.black12,
                                              width: 1.0,
                                            ), borderRadius: BorderRadius.all(Radius.circular(4.h))
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(5.h),
                                          child: Image.asset('assets/images/addmore.png', width: 20.w ,height: 20.h,color: Colors.grey,),
                                        )
                                    ),
                                  ],
                                )

                              ],
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Card(
                      elevation: 2.h,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.h),
                      ),
                      child:new Container(
                          height: 40.h,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: new Border.all(
                                color: Colors.black12,
                                width: 1.0,
                              ), borderRadius: BorderRadius.all(Radius.circular(4.h))
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h,bottom: 2.h,left: 15.h,right: 15.h),
                            child: new TextField(
                              textAlign: TextAlign.start,
                              decoration: new InputDecoration(
                                hintText: 'Enter Amount',
                                hintStyle: TextStyle(color: Colors.black12,fontWeight: FontWeight.bold),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            WidgetsBinding.instance.addPostFrameCallback((_){
                              //Navigator.push(context, MaterialPageRoute(builder: (Context)=>VerifyOtp()));
                            });
                          },
                          child: buttonStyleOne("SUBMIT",context),
                        )
                      ],
                    )
                  ],
                ),
              )
            )
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

}













