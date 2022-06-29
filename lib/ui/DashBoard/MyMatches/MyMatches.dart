import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/CaptainAndVicecaptain.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/TeamPreview.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/DataNotAvailable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Bloc/MatchBloc/MatchBloc.dart';


class MyMatches extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => MatchBloc(MatchRepository(Dio())),
            ),
          ],
          child: MyMatchesStateful(),
        )
    );
  }
}

class MyMatchesStateful extends StatefulWidget {



  @override
  _MyMatchesState createState() => _MyMatchesState();
}


class _MyMatchesState extends State<MyMatchesStateful> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;
  UserDataService userDataService =  getIt<UserDataService>();
  Map<String,dynamic>? serverResponse;
  bool upcomingData = false , completedData = false ,liveData = false;

  @override
  void initState() {
    _controller = new TabController(length: 3, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    BlocProvider.of<MatchBloc>(context).add(FetchMyMatchEvent(context: context,userId: userDataService.userData.id.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.h),
        child: Column(
          children: [
            Container(
                color: Colors.black,
                height: 75.h,
                child: Padding(
                    padding: EdgeInsets.only(top: 38.h,bottom: 0.h),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Get.back();
                                      },
                                      child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                                    ),
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Text(
                                      "My Matches",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.white,
                                          fontSize: 15.sp
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    )
                )
            ),
            SizedBox(
              height: 5.h,
            ),
            TabBar(
              controller: _controller,
              indicatorColor: Colors.deepOrange,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorWeight: 5,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Live"),
                Tab(text: "Completed"),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: BlocListener<MatchBloc,MatchState>(
          listener: (context,state){
            if(state is MatchCompleteState){
              setState((){
                serverResponse = state.serverResponse;
                getDataStatus(serverResponse);
              });
            }
          },
          child: TabBarView(
            controller: _controller,
            children: <Widget> [
              (serverResponse != null && serverResponse!["data"].length > 0 && upcomingData == true) ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: serverResponse!["data"].length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    var nameArray = serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString().split("vs");
                    DateTime dt1 = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    DateTime dt2 = DateTime.now();
                    DateTime dateTime = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    int endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;
                    return dt1.isAfter(dt2) ? GestureDetector(
                      onTap: (){
                        setState((){
                          Get.to(ContestMainPage(serverResponse!["data"][index]["match_data"]["card"]["key"].toString(),serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString(),serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString()));
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                        child: Container(
                          height: 126.h,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.h), topLeft: Radius.circular(20.h),bottomRight: Radius.circular(20.h),topRight: Radius.circular(20.h))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h,right: 10.h,top: 7.h,bottom: 7.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:30.h,
                                        child:Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                serverResponse!["data"][index]["match_data"]["card"]["name"].toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoLight',
                                                    color: ColorConstants.colorBlack,
                                                    fontSize: 13.sp
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        height: 1.h,
                                        width: MediaQuery.of(context).size.width.w,
                                        color: Colors.black12,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.start,
                                                children: [
                                                  Text(nameArray[0].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 50.h,
                                                height:20.h,
                                                padding: EdgeInsets.all(2.h),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(20.h)
                                                ),
                                                child: Center(
                                                  child: Text("MEGA",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.white,
                                                      fontSize: 12.sp
                                                  ),),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                             /* Text("Rs. 75 Lakhs",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants.colorLoginBtn,
                                                  fontSize: 12.sp
                                              ),),*/
                                            ],
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.end,
                                                children: [
                                                  Text(nameArray[1].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height:35.h,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.colorLoginBtn,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.h) , bottomLeft: Radius.circular(20.h))
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5.h,),
                                        CountdownTimer(
                                          endTime: endTime,
                                          widgetBuilder: (context,time){
                                            if (time == null) {
                                              return Text('Live');
                                            }
                                            return Row(
                                              children: [
                                                (time.days != null) ? Text(time.days.toString()+" days ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.hours != null) ? Text(time.hours.toString()+" hrs ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.min != null) ? Text(time.min.toString()+" min ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.sec != null) ? Text(time.sec.toString()+" sec",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                              ],
                                            );
                                            // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                          },
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Transform.translate(
                                              offset: Offset(0.0, -40 / 3.4),
                                              child:  Image.asset('assets/images/trophy.png', width: 60.w ,height: 30.h,),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                        /*Image.asset('assets/images/movie.png', width: 20.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,),
                                        Image.asset('assets/images/tshirt.png', width: 25.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,)*/
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ) : SizedBox();
                  }
              ) : DataNotAvailable.dataNotAvailable("Data not available."),
              (serverResponse != null && serverResponse!["data"].length > 0 && liveData == true) ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: serverResponse!["data"].length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    var nameArray = serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString().split("vs");
                    DateTime dt1 = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    DateTime dt2 = DateTime.now();
                    DateTime dateTime = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    int endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;
                    return (dt2.compareTo(dt1)==0) ? GestureDetector(
                      onTap: (){
                        setState((){
                          Get.to(ContestMainPage(serverResponse!["data"][index]["match_data"]["card"]["key"].toString(),serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString(),serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString()));
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                        child: Container(
                          height: 126.h,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.h), topLeft: Radius.circular(20.h),bottomRight: Radius.circular(20.h),topRight: Radius.circular(20.h))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h,right: 10.h,top: 7.h,bottom: 7.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:30.h,
                                        child:Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                serverResponse!["data"][index]["match_data"]["card"]["name"].toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoLight',
                                                    color: ColorConstants.colorBlack,
                                                    fontSize: 13.sp
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        height: 1.h,
                                        width: MediaQuery.of(context).size.width.w,
                                        color: Colors.black12,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.start,
                                                children: [
                                                  Text(nameArray[0].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 50.h,
                                                height:20.h,
                                                padding: EdgeInsets.all(2.h),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(20.h)
                                                ),
                                                child: Center(
                                                  child: Text("MEGA",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.white,
                                                      fontSize: 12.sp
                                                  ),),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              /*Text("Rs. 75 Lakhs",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants.colorLoginBtn,
                                                  fontSize: 12.sp
                                              ),),*/
                                            ],
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.end,
                                                children: [
                                                  Text(nameArray[1].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height:35.h,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.colorLoginBtn,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.h) , bottomLeft: Radius.circular(20.h))
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5.h,),
                                        CountdownTimer(
                                          endTime: endTime,
                                          widgetBuilder: (context,time){
                                            if (time == null) {
                                              return Text('Live');
                                            }
                                            return Row(
                                              children: [
                                                (time.days != null) ? Text(time.days.toString()+" days ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.hours != null) ? Text(time.hours.toString()+" hrs ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.min != null) ? Text(time.min.toString()+" min ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.sec != null) ? Text(time.sec.toString()+" sec",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                              ],
                                            );
                                            // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                          },
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Transform.translate(
                                              offset: Offset(0.0, -40 / 3.4),
                                              child:  Image.asset('assets/images/trophy.png', width: 60.w ,height: 30.h,),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                       /* Image.asset('assets/images/movie.png', width: 20.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,),
                                        Image.asset('assets/images/tshirt.png', width: 25.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,)*/
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ) : SizedBox();
                  }
              ) : DataNotAvailable.dataNotAvailable("Data not available."),
              (serverResponse != null && serverResponse!["data"].length > 0 && completedData == true) ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: serverResponse!["data"].length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    print("id===>>>"+serverResponse!["data"][index].toString());
                    var nameArray = serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString().split("vs");
                    DateTime dt1 = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    DateTime dt2 = DateTime.now();
                    DateTime dateTime = DateTime.parse(serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString());
                    int endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;
                    return dt1.isBefore(dt2) ? GestureDetector(
                      onTap: (){
                        setState((){
                          Get.to(ContestMainPage(serverResponse!["data"][index]["match_data"]["card"]["key"].toString(),serverResponse!["data"][index]["match_data"]["card"]["short_name"].toString(),serverResponse!["data"][index]["match_data"]["card"]["start_date"]["iso"].toString()));
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                        child: Container(
                          height: 126.h,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.h), topLeft: Radius.circular(20.h),bottomRight: Radius.circular(20.h),topRight: Radius.circular(20.h))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.h,right: 10.h,top: 7.h,bottom: 7.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:30.h,
                                        child:Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                serverResponse!["data"][index]["match_data"]["card"]["name"].toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'RoLight',
                                                    color: ColorConstants.colorBlack,
                                                    fontSize: 13.sp
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        height: 1.h,
                                        width: MediaQuery.of(context).size.width.w,
                                        color: Colors.black12,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.start,
                                                children: [
                                                  Text(nameArray[0].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                width: 50.h,
                                                height:20.h,
                                                padding: EdgeInsets.all(2.h),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(20.h)
                                                ),
                                                child: Center(
                                                  child: Text("MEGA",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.white,
                                                      fontSize: 12.sp
                                                  ),),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              /*Text("Rs. 75 Lakhs",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants.colorLoginBtn,
                                                  fontSize: 12.sp
                                              ),),*/
                                            ],
                                          ),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.end,
                                                children: [
                                                  Text(nameArray[1].toString(),style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorBlack),)
                                                ],
                                              )
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 7.h,
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height:35.h,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.colorLoginBtn,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.h) , bottomLeft: Radius.circular(20.h))
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 5.h,),
                                        CountdownTimer(
                                          endTime: endTime,
                                          widgetBuilder: (context,time){
                                            if (time == null) {
                                              return Text('Completed',style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 13.sp
                                              ),);
                                            }
                                            return Row(
                                              children: [
                                                (time.days != null) ? Text(time.days.toString()+" days ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.hours != null) ? Text(time.hours.toString()+" hrs ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.min != null) ? Text(time.min.toString()+" min ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                                (time.sec != null) ? Text(time.sec.toString()+" sec",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 13.sp
                                                ),) : SizedBox(),
                                              ],
                                            );
                                            // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                          },
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            Transform.translate(
                                              offset: Offset(0.0, -40 / 3.4),
                                              child:  Image.asset('assets/images/trophy.png', width: 60.w ,height: 30.h,),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text("")
                                        ),
                                       /* Image.asset('assets/images/movie.png', width: 20.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,),
                                        Image.asset('assets/images/tshirt.png', width: 25.w ,height: 20.h,color: Colors.white,),
                                        SizedBox(width: 10.h,)*/
                                      ],
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ) : SizedBox();
                  }
              ) : DataNotAvailable.dataNotAvailable("Data not available."),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  void getDataStatus(Map<String, dynamic>? serverResponse) {
    for(int i=0 ; i<serverResponse!["data"].length ; i++){
      DateTime dt1 = DateTime.parse(serverResponse["data"][i]["match_data"]["card"]["start_date"]["iso"].toString());
      DateTime dt2 = DateTime.now();
      if(dt1.isAfter(dt2)){
        setState((){
          upcomingData = true;
        });
      }
      else  if(dt2.compareTo(dt1)==0){
        setState((){
          liveData = true;
        });
      }
      else if(dt1.isBefore(dt2)){
        setState((){
          completedData = true;
        });
      }
    }
  }



}













