
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class PrivacyPolicy extends StatefulWidget {

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  bool acceptConditions = true;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: ColorConstants.colorPrimary
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Row(
                    children: [
                      SizedBox(width: 10.h,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:Container(
                          width: 20.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                              shape: CircleBorder(), //here we set the circular figure
                              color: ColorConstants.colorWhite
                          ),
                          child: Center(
                              child:Icon(Icons.arrow_back)
                          ),
                        ),),
                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text("Privacy Policy ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      )),
                      SizedBox(width: 20.h,),
                    ],
                  ),
                  SizedBox(
                      height:20.h
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Flip2play(“Flip2play” or “Us” or “We” or “Our”) respects the data provided by our users and we are committed to protecting the personal information collected about, or provided by you, your Agents and End-Users. To that end, we have designed the Flip2play’s Privacy Policy (this “Policy”) to guide how we store, collect, manage and use the personal information we obtain in connection with our Services. This Policy applies only to information submitted and collected directly by Flip2play through use of the Services.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("By using and accessing our website, mobile application and its Services, you agree to be bound by the terms of this Policy. We may, from time to time, make changes to this Policy. If we make any material change to this Policy, we will notify you of those changes by posting them on this site, mobile application and we will indicate the date of last revision. Your continued use of the Services after changes have been posted to the Policy will constitute your acceptance of those changes.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Last updated: March 15, 2020",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("This Policy describes the treatment of information provided or collected on or through our website, which is currently located at www.Flip2play.com (the “Site”). This policy applies to the Services, but not to websites maintained by other companies or organizations to which Flip2play may provide links. When you connect to these websites via a link, this Policy no longer applies. We, therefore, not responsible for the content or activities provided or created on such sites. If you have any questions about this Policy or our data practices, please do not hesitate to contact us.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Definitions",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Agents",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Any authorised person or representatives of a Business Partners or Subscribers who interact with the Customers and provides data and information to us and conduct business on behalf of the Business Partners or Subscribers.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Business Partners or Subscribers",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp,fontWeight: FontWeight.bold),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Business Partners are companies in our network that have registered for, or are Subscribers of our Services. The scope of Business Partners shall be governed with the separate contract executed with them from time to time.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Customers",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Customers are those individuals/ end-users who download online games (“Games/ Services”), use or otherwise interact or play the Games using tools and related services provided by Flip2play. This may include, but is not limited to, website users, social messaging users, or mobile application users.",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("The Information We Collect",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(child: Text("Personal Information is information that others can use to identify, locate, or contact you, including but not limited to, your name, email address, postal address, and phone numbers (collectively “Personally Identifiable Information” or “PII”). Specifically, Flip2play may collect the following PII in connection with your use of the Services:",style: TextStyle(color: ColorConstants.colorBlack,fontSize: 15.sp),)),
                              SizedBox(width: 10.w,),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                width: 10.w,
                                height: 10.h,
                                child: SizedBox(),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Name",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Email Address",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Company Name",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Phone Number",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Age",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Date of Birth",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Gender",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("In addition to the PII listed above, Flip2play may also collect:",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child:  Text("Generic geographic location, such as the city in which you are located",textAlign: TextAlign.start, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Operating System",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("Connection speed",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black,),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 20.w,),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:Container(
                                  width: 10.w,
                                  height: 10.h,
                                  child: SizedBox(),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                ),),
                              SizedBox(width: 10.w,),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text("IP Address",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 15.sp, color: Colors.black,),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("In some cases, we may assign an identification number to you (“ID Number”).ID Numbers may be linked with PII only for the purposes of providing the Services or for internal reporting purposes. You can enable or disable geolocation services when you use our Services at anytime, through your device settings.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("For additional information regarding the steps we take to safeguard your information, please refer to the Data Security, Integrity and Retention section of the Policy.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black,),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("How the Information is Collected",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Customers",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("Depending on the nature of your interaction with the Services, Flip2play may collect information from you automatically and/or when you voluntarily choose to provide us with information. We may also acquire information from other trusted sources to update or supplement the information that you voluntarily provide to us or that we collect automatically.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("Flip2play may track this information over time and across multiple applications (and may also combine the device information with anonymous information from other sources) in order to deliver the Services. In addition, Flip2play may collect information from Customers through use of a cookie, web beacon or similar tracking technologies if the Customers accesses the Services from a browser or is redirected to a browser by links provided through the Services. Certain links may redirect you to a browser where Flip2play may use a cookie to track Customer activities.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("A “cookie” is a small bit of record-keeping information that sites often store on a user’s computer or mobile device. Cookies are typically used to quickly identify a user’s device and to “remember” things about the user’s visit. For example, we may use cookies or a similar method to keep track of your app session. Information contained in a cookie may be linked to your personal information for this purpose. You can disable cookies or set your browser to alert you when cookies are being sent by your device or computer although this may affect your ability to use many of the features of the Services.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Business Partners",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("If you are a Business Partner, we collect information that you voluntarily provide us during your interaction and registration with the Services. For example, you may choose to provide Flip2play with information when you directly request information or services from us, submit or receive a payment, or complete the online forms available on the Site.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("We may also collect certain types of information automatically, including through the use of cookies, web beacons and other similar tracking technologies. These tracking technologies allow Flip2play to personalize your experience with the Services and keep track of certain online behavior in order to help us determine the things that you find most interesting.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Center(
                                child: Text("Third Party Sites",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoBold", fontSize: 20.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("We may share certain personal information we collect about you with our service providers who perform functions necessary to providing the Services on our behalf. Examples include analyzing data, and providing marketing assistance and customer service. These service providers are not authorized by us to use or disclose personal information except as needed to perform their functions or comply with legal requirements, and they may not use it for any other purposes. Further, they must process the personal information in accordance with this Privacy Policy. We do not disclose or transfer your personal information to third parties for any other purpose.",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Text("",textAlign: TextAlign.start, style: TextStyle(fontSize: 15.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ],
                      )
                  )

                ],
              ),
            ),
          ),
        )) ;

  }

  @override
  void initState() {
    super.initState();
  }


}
