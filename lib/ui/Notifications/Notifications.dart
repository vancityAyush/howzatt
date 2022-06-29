import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/Bloc/HomePageBloc/HomePageBloc.dart';
import 'package:howzatt/Repository/HomePageRepository.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/DataNotAvailable.dart';

class Notifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomePageBloc(HomePageRepository(dio.Dio())),
            ),
          ],
          child: NotificationsStateful(),
        )
    );
  }
}


class NotificationsStateful extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<NotificationsStateful> {


  @override
  void initState() {
    super.initState();
    //BlocProvider.of<HomePageBloc>(context).add(GetNotificationDataEvent(context: context));
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body: BlocListener<HomePageBloc,HomePageState>(
            listener: (context,state){
              if(state is GetNotificationDataCompleteState){
                setState((){

                });
              }
            },
            child: Center(
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
                    SizedBox(height: 0.h,),
                    Row(
                      children: [
                        SizedBox(width: 10.h,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child:Container(
                            width: 40.w,
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
                              child: Text("Notifications ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        )),
                        SizedBox(width: 20.h,),
                      ],
                    ),
                    SizedBox(
                        height:0.h
                    ),
                    Expanded(
                        child:(false) ? ListView.builder(
                            itemCount: 10,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                //height: 70.h,
                                  width: MediaQuery.of(context).size.width.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                                  padding: EdgeInsets.only(top: 15.h, bottom: 15.h,right: 10.w,left: 10.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.notifications,color: ColorConstants.colorGolden,size: 25.sp,),
                                          SizedBox(width: 10.w,),
                                          Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "Title",
                                                          style: TextStyle(
                                                              color: ColorConstants.colorWhite,
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "message",
                                                          style: TextStyle(
                                                              color: ColorConstants.colorWhite,
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "24-06-2022",
                                                style: TextStyle(
                                                    color: ColorConstants.colorWhite,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ));
                            }) : DataNotAvailable.dataNotAvailable("No Notifications Avaialable.")
                    ),
                    SizedBox(
                        height:10.h
                    ),
                  ],
                ),
              ),
            ),
          )
        )
    ) ;

  }



}
