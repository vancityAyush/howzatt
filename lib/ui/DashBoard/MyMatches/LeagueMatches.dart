import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/HomePageBloc/HomePageBloc.dart';
import 'package:howzatt/Repository/HomePageRepository.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:howzatt/utils/DataNotAvailable.dart';
import '../../../Bloc/MatchBloc/MatchBloc.dart';


class LeagueMatches extends StatelessWidget {
  String? leagueKey, leagueName;
  LeagueMatches(String? _leagueKey, String? _leagueName){
    leagueKey = _leagueKey;
    leagueName = _leagueName;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => HomePageBloc(HomePageRepository(Dio())),
            ),
          ],
          child: LeagueMatchesStateful(leagueKey.toString(),leagueName.toString()),
        )
    );
  }
}

class LeagueMatchesStateful extends StatefulWidget {
  String? leagueKey, leagueName;
  LeagueMatchesStateful(String? _leagueKey, String? _leagueName){
    leagueKey = _leagueKey;
    leagueName = _leagueName;
  }


  @override
  _LeagueMatchesState createState() => _LeagueMatchesState();
}


class _LeagueMatchesState extends State<LeagueMatchesStateful> with SingleTickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserDataService userDataService =  getIt<UserDataService>();
  dio.Response? response;
  bool getData = false , haveData = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageBloc>(context).add(AuthenticationEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
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
                                      widget.leagueName.toString(),
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
          ],
        ),
      ),
      body: BlocListener<HomePageBloc,HomePageState>(
        listener: (context,state){
          if(state is AuthenticationCompleteState){
            if(state.accessToken != null && state.accessToken != ""){
              BlocProvider.of<HomePageBloc>(context).add(GetScheduleMatchDataEvent(context: context,accessToken: state.accessToken));
            }
          }
          if(state is GetMatchDataCompleteState){
            setState((){
              response = state.response;
              getData = true;
              getLeaguesData(response);
            });
          }
        },
        child: Padding(
            padding: EdgeInsets.only(left: 0.w,top: 10.h,bottom: 0.h,right: 0.h),
            child: (getData == true) ? (response != null && haveData == true)  ? ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: response!.data["data"]["months"][0]["days"].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: response!.data["data"]["months"][0]["days"][index]["matches"].length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index1){
                        print("response!.data====>>"+response!.data["data"]["months"][0]["days"][index]["matches"][index1].toString());
                        var nameArray = response!.data["data"]["months"][0]["days"][index]["matches"][index1]["short_name"].toString().split("vs");
                        var startDate = response!.data["data"]["months"][0]["days"][index]["matches"][index1]["start_date"]["iso"].toString().split("T");
                        var time = startDate[1].split("+");
                        DateTime dt1 = DateTime.parse(startDate[0].toString()+" "+time[0]+":00");
                        DateTime dt2 = DateTime.now();
                        DateTime dateTime = DateTime.parse(response!.data["data"]["months"][0]["days"][index]["matches"][index1]["start_date"]["iso"].toString());
                        int endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;
                        return ((dt1.isAfter(dt2)) && response!.data["data"]["months"][0]["days"][index]["matches"][index1]["season"]["key"].toString() == widget.leagueKey.toString()) ? GestureDetector(
                          onTap: (){
                            Get.to(ContestMainPage(response!.data["data"]["months"][0]["days"][index]["matches"][index1]["key"].toString(),response!.data["data"]["months"][0]["days"][index]["matches"][index1]["short_name"].toString(),response!.data["data"]["months"][0]["days"][index]["matches"][index1]["start_date"]["iso"].toString()));
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
                                                    response!.data["data"]["months"][0]["days"][index]["matches"][index1]["season"]["name"].toString(),
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
                                                  return Text('Game over');
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
                  );
                }
            ) : DataNotAvailable.dataNotAvailable("No matches Avaialble") : SizedBox(),
        ),
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  void getLeaguesData(dio.Response? response) {
    for(int i=0 ; i<response!.data["data"]["months"][0]["days"].length ; i++){
      for(int j=0 ; j<response.data["data"]["months"][0]["days"][i]["matches"].length ; j++){
        var startDate = response.data["data"]["months"][0]["days"][i]["matches"][j]["start_date"]["iso"].toString().split("T");
        var time = startDate[1].split("+");
        DateTime dt1 = DateTime.parse(startDate[0].toString()+" "+time[0]+":00");
        DateTime dt2 = DateTime.now();
         if((dt1.isAfter(dt2)) && response.data["data"]["months"][0]["days"][i]["matches"][j]["season"]["key"].toString() == widget.leagueKey.toString()){
           setState((){
             haveData = true;
           });
         }
      }
    }
  }




}













