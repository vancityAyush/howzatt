import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/ContestBloc/ContestBloc.dart';
import 'package:howzatt/Bloc/MatchBloc/MatchBloc.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/MyMatchesMain.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stylish_dialog/stylish_dialog.dart';
import '../../../Repository/ContestRepository.dart';


class LeaderBoardMainPage extends StatelessWidget {

  String? matchId,amount,name,startDate,contest_id;
  Map<String,dynamic>? serverResponse;
  int? index;
  bool? fromMyContest;

  LeaderBoardMainPage(String? _matchId,String? _amount,String? _name,String? _startDate, Map<String,dynamic>? _serverResponse,int? _index,String? _contest_id,bool? _fromMyContest){
    matchId = _matchId;
    amount = _amount;
    name = _name;
    startDate = _startDate;
    serverResponse = _serverResponse;
    index = _index;
    contest_id = _contest_id;
    fromMyContest = _fromMyContest;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ContestBloc(ContestRepository(Dio())),
            ),
            BlocProvider(
              create: (_) => MatchBloc(MatchRepository(Dio())),
            ),
          ],
          child: LeaderBoardMainPageStateful(matchId,amount,name,startDate,serverResponse,index,contest_id,fromMyContest),
        )
    );
  }
}

class LeaderBoardMainPageStateful extends StatefulWidget {

  String? matchId,amount,name,startDate,contest_id;
  Map<String,dynamic>? serverResponse;
  int? index;
  bool? fromMyContest;

  LeaderBoardMainPageStateful(String? _matchId,String? _amount,String? _name,String? _startDate, Map<String,dynamic>? _serverResponse,int? _index,String? _contest_id,bool? _fromMyContest){
    matchId = _matchId;
    amount = _amount;
    name = _name;
    startDate = _startDate;
    serverResponse = _serverResponse;
    index = _index;
    contest_id = _contest_id;
    fromMyContest = _fromMyContest;
  }

  @override
  _LeaderBoardMainPageState createState() => _LeaderBoardMainPageState();
}


class _LeaderBoardMainPageState extends State<LeaderBoardMainPageStateful> with SingleTickerProviderStateMixin{

  List<int> listInt = [1,2,3,4,5];
  int _current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;
  int endTime = 0;
  double firstAmount = 0.0 , sumAmount = 0.0 ;
  int spotsLeft = 0;
  var valueRange;
  String key1= "" , value1= "";
  Map<String,dynamic> params = new Map<String,dynamic>();
  UserDataService userDataService =  getIt<UserDataService>();

  //
  Map<String,dynamic> match_details = new Map<String,dynamic>();
  String match_id = "" , amount = "" , disable_amount = "" , max_winners = "" , max_teams = "" , teams_joined = "" , description = "",user_id = "",type = "" , status = "" , max_one_person_teams = "",response = "",remarks = "";
  List rules = List.empty(growable: true);
  Map<String,dynamic>? serverResponse , playerDetailResponse;
  bool isTimeOver = false;
  var teamsArrayName ;
  int team1Count = 0 , team2Count = 0;

  //
  String mid = "", orderId = "", amounts = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  Map<String,dynamic>?  teamsResponse;
  List<PlayerData> wKplayerList = List.empty(growable: true);
  List<PlayerData> batplayerList = List.empty(growable: true);
  List<PlayerData> allrplayerList = List.empty(growable: true);
  List<PlayerData> bowlplayerList = List.empty(growable: true);
  int wkAdd = 0 , batAdd = 0 , arAdd = 0 , bowlAdd = 0;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    DateTime dateTime = DateTime.parse(widget.startDate.toString());
    endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;

    widget.serverResponse!["data"][widget.index]["prize_breakup"].forEach((element) {
      var data1 = element.toString().split(":");
      var data2 = data1[1].split("}");
      if(widget.fromMyContest == true){
        if(data2.length > 0 && data2[0] != "''")
        {
          var arr = data2[0].toString().split("'");
          sumAmount = sumAmount + double.parse(arr[1].toString());
        }
      }
      else{
        if(data2.length > 0 && data2[0] != "''")
        {
          sumAmount = sumAmount + double.parse(data2[0].toString());
        }
      }
    });

    var data1 = widget.serverResponse!["data"][widget.index]["prize_breakup"][0].toString().split(":");
    var data2 = data1[1].split("}");
    if(widget.fromMyContest == true){
      if(data2.length > 0 && data2[0] != "''")
      {
        var arr = data2[0].toString().split("'");
        firstAmount = double.parse(arr[1].toString());
      }
    }
    else{
      if(data2.length > 0 && data2[0] != "''")
      {
        firstAmount = double.parse(data2[0].toString());
      }
    }


    spotsLeft = int.parse(widget.serverResponse!["data"][widget.index]["max_teams"].toString()) - int.parse(widget.serverResponse!["data"][widget.index]["teams_joined"].toString());
    if(int.parse(widget.serverResponse!["data"][widget.index]["max_teams"].toString()) > int.parse(widget.serverResponse!["data"][widget.index]["teams_joined"].toString())){
      valueRange = (int.parse(widget.serverResponse!["data"][widget.index]["teams_joined"].toString()) - int.parse(widget.serverResponse!["data"][widget.index]["max_teams"].toString())) / 100;
    }
    else if(int.parse(widget.serverResponse!["data"][widget.index]["teams_joined"].toString()) >= int.parse(widget.serverResponse!["data"][widget.index]["max_teams"].toString())){
      valueRange = (int.parse(widget.serverResponse!["data"][widget.index]["max_teams"].toString()) - int.parse(widget.serverResponse!["data"][widget.index]["teams_joined"].toString())) / 100;
    }
    match_details.putIfAbsent("name", () => widget.serverResponse!["data"][widget.index]["match_details"]["name"].toString());
    match_details.putIfAbsent("team1", () => widget.serverResponse!["data"][widget.index]["match_details"]["team1"].toString());
    match_details.putIfAbsent("team2", () => widget.serverResponse!["data"][widget.index]["match_details"]["team2"].toString());

    match_id = widget.serverResponse!["data"][widget.index]["match_id"].toString();
    amount = widget.serverResponse!["data"][widget.index]["amount"].toString();
    disable_amount = widget.serverResponse!["data"][widget.index]["disable_amount"].toString();
    max_winners = widget.serverResponse!["data"][widget.index]["max_winners"].toString();
    max_teams = widget.serverResponse!["data"][widget.index]["max_teams"].toString();
    teams_joined = widget.serverResponse!["data"][widget.index]["teams_joined"].toString();
    description = widget.serverResponse!["data"][widget.index]["description"][0].toString();
    rules = widget.serverResponse!["data"][widget.index]["rules"];
    user_id = userDataService.userData.id;
    type = "private";
    status = widget.serverResponse!["data"][widget.index]["status"].toString();
    max_one_person_teams = widget.serverResponse!["data"][widget.index]["max_one_person_teams"].toString();
    response = widget.serverResponse!["data"][widget.index]["response"].toString();
    remarks = widget.serverResponse!["data"][widget.index]["remarks"].toString();

    teamsArrayName = widget.name!.split("vs");
    BlocProvider.of<MatchBloc>(context).add(FetchTeamEvent(context: context,contestId: widget.contest_id.toString()));
    BlocProvider.of<ContestBloc>(context).add(FetchContestAllTeamEvent(context: context,contestId: widget.contest_id.toString()));
    getSharedPreference();
    super.initState();
  }

  void getSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<ContestBloc>(context).add(FetchPlayerDetailAfterMatchEvent(context: context,contestId: widget.contest_id.toString(),matchKey: widget.matchId.toString(),accesstoken: prefs.getString("accesstoken").toString()));
  }


  Future<bool> _willPopCallback() async {
    Get.to(ContestMainPage(widget.matchId,widget.name,widget.startDate));
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child:  Container(
                color: Colors.black,
                height: 70.h,
                child: Padding(
                  padding: EdgeInsets.only(top: 25.h,bottom: 0.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.h,
                              ),
                              InkWell(
                                onTap: (){
                                  Get.to(ContestMainPage(widget.matchId,widget.name,widget.startDate));
                                },
                                child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                              ),
                              SizedBox(
                                width: 0.h,
                              ),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.name.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: Colors.white,
                                            fontSize: 15.sp
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CountdownTimer(
                                        endTime: endTime,
                                        widgetBuilder: (context,time){
                                          if (time == null) {
                                            isTimeOver = true;
                                            return Text('');
                                          }
                                          return Row(
                                            children: [
                                              (time.days != null) ? Text(time.days.toString()+" days ",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),) : SizedBox(),
                                              (time.hours != null) ? Text(time.hours.toString()+" hrs ",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),) : SizedBox(),
                                              (time.min != null) ? Text(time.min.toString()+" min ",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),) : SizedBox(),
                                              (time.sec != null) ? Text(time.sec.toString()+" sec",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),) : SizedBox(),
                                            ],
                                          );
                                          // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )),
                              InkWell(
                                onTap: (){
                                  showMyTeamsData();
                                },
                                child: Image.asset('assets/images/userprofile.png', width: 25.w ,height: 25.h),
                              ),
                              SizedBox(
                                width: 10.h,
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                )
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                BlocListener<MatchBloc,MatchState>(
                    listener: (context,state){
                      if(state is FetchTeamCompleteState){
                        setState((){
                          teamsResponse = state.serverResponse;
                        });
                      }
                    },
                    child:SizedBox()
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: 25.w,),
                            Column(
                              children: [
                                Text(
                                  "Prizes Pool",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RoLight',
                                      color: Colors.grey,
                                      fontSize: 15.sp
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: Colors.black,),
                                    SizedBox(width: 2.w,),
                                    Text(sumAmount.toString(),style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.sp
                                    ),),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    SizedBox(width: 20.w,)
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 5.h,bottom: 5.h,left: 15.h,right: 15.h),
                    child: LinearProgressIndicator(
                      value: valueRange,
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                      backgroundColor: Colors.grey,
                    )
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    SizedBox(width: 22.w,),
                    Expanded(child: Text(spotsLeft.toString()+" Spots Left",style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: Colors.deepOrange,
                        fontSize: 16.sp
                    ),),),
                    Text(widget.serverResponse!["data"][widget.index]["max_teams"].toString()+" Spots ",style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: Colors.grey,
                        fontSize: 16.sp
                    ),),
                    SizedBox(width: 22.w,),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: (){
                    if(isTimeOver == false )
                    {
                      if(int.parse(spotsLeft.toString()) > 0){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                                elevation: 0,
                                backgroundColor:Colors.white,
                                child: Container(
                                  height: 230.h,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Get.back();
                                            },
                                            child: Icon(Icons.close ,color: Colors.black,),
                                          ),
                                          SizedBox(
                                            width: 5.h,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Text("CONFIRMATION" , style: TextStyle(fontSize: 18.sp,color: Colors.black87,fontWeight: FontWeight.bold),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Expanded(child: Text("Entry Fee" , style: TextStyle(fontSize: 15.sp,color: Colors.black87,fontWeight: FontWeight.bold),)),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3.h),
                                            child:Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,color: Colors.green,),
                                          ),
                                          SizedBox(
                                            width: 3.h,
                                          ),
                                          Text(widget.serverResponse!["data"][widget.index]["amount"].toString(),style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.green,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          SizedBox(
                                            width: 20.h,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                          Expanded(child: Text("By joining this contest,you accept Flip2Play Terms and Conditions" , style: TextStyle(fontSize: 12.sp,color: Colors.black87),)),
                                          SizedBox(
                                            width: 10.h,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Get.back();
                                          if(isTimeOver == false){
                                            Get.to(MyMatchesMain(widget.serverResponse!["data"][widget.index]["match_id"].toString(),widget.amount.toString(),widget.contest_id,widget.name,widget.startDate));
                                          }
                                          else{
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You're not able to create Team.",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,));
                                          }
                                        },
                                        child: Container(
                                            width: 200.w,
                                            height:35.h,
                                            padding: EdgeInsets.all(2.h),
                                            margin: EdgeInsets.only(left: 20.w,right: 20.w),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(5.h)
                                            ),
                                            child: Row(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [
                                                Text("JOIN CONTEST",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                              ],
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                )
                            );
                          },
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Spots left , You're not able to join contest.",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,));
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You're not able to join contest.",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,));
                    }
                    //getTransactionToken(widget.serverResponse!["data"][widget.index]["amount"].toString());
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width.w,
                      height:35.h,
                      padding: EdgeInsets.all(2.h),
                      margin: EdgeInsets.only(left: 20.w,right: 20.w),
                      decoration: BoxDecoration(
                          color: (isTimeOver == false) ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(5.h)
                      ),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children: [
                          Text("JOIN",style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(width: 5.w,),
                          Image.asset('assets/images/rupee_indian.png', width: 15.w ,height: 15.h,color: Colors.white,),
                          SizedBox(width: 5.w,),
                          Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: Text(widget.serverResponse!["data"][widget.index]["amount"].toString(),style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold
                                ),),
                              )
                          ),
                        ],
                      )
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                    width: MediaQuery.of(context).size.width.w,
                    height:35.h,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorhintText,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex:1,
                            child: Row(
                              children: [
                                SizedBox(width:5.h),
                                Image.asset('assets/images/first.png', width: 17.w ,height: 17.h),
                                SizedBox(width: 5.h,),
                                Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: ColorConstants.colorBlackHint,),
                                SizedBox(width: 0.h,),
                                Text(firstAmount.toString(),style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: ColorConstants.colorBlackHint,
                                  fontSize: 13.sp,
                                ),),
                              ],
                            )
                        ),
                        Row(
                          children: [
                            /*SizedBox(width:10.h),
                          Image.asset('assets/images/prizetrophy.png', width: 17.w ,height: 17.h),
                          SizedBox(width: 2.h,),
                          Text("57%",style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: ColorConstants.colorBlackHint,
                              fontSize: 13.sp
                          ),),*/
                            SizedBox(width:15.h),
                            Image.asset('assets/images/letter_m.png', width: 17.w ,height: 17.h,color: ColorConstants.colorBlackHint,),
                            SizedBox(width: 4.h,),
                            Text("Upto "+widget.serverResponse!["data"][widget.index]["max_one_person_teams"].toString(),style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: ColorConstants.colorBlackHint,
                                fontSize: 13.sp
                            ),),
                            SizedBox(width:15.h),
                          ],
                        ),
                        Expanded(
                            flex:1,
                            child: Row(
                              children: [
                                SizedBox(width:15.h),
                                Image.asset('assets/images/check.png', width: 17.w ,height: 17.h,color: ColorConstants.colorBlackHint,),
                                SizedBox(width: 4.h,),
                                Text("Guaranteed",style: TextStyle(
                                    fontFamily: 'RoMedium',
                                    color: ColorConstants.colorBlackHint,
                                    fontSize: 13.sp
                                ),),
                              ],
                            )
                        ),
                      ],
                    )
                ),
                TabBar(
                  controller: _controller,
                  indicatorColor: Colors.deepOrange,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  tabs: [
                    Tab(text: "Winnings"),
                    Tab(text: "Leaderboard"),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(child: BlocListener<ContestBloc,ContestState>(
                  listener: (context,state){
                    if(state is FetchContestAllTeamCompleteState){
                      setState((){
                        serverResponse = state.serverResponse;
                      });
                    }
                    if(state is FetchPlayerDetailAfterMatchCompleteState){
                      setState((){
                        playerDetailResponse = state.serverResponse;
                      });
                    }
                  },
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 40.w,),
                              Expanded(child: Text("Rank",style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),),),
                              Text("Winnings",style: TextStyle(
                                fontFamily: 'RoMedium',
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),),
                              SizedBox(width: 40.w,),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width.w,
                            height: 0.5.sp,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget.serverResponse!["data"][widget.index]["prize_breakup"].length,
                                shrinkWrap: true,
                                itemBuilder: (context,index){
                                  key1= "" ; value1 = "";
                                  var prize_breakup = widget.serverResponse!["data"][widget.index]["prize_breakup"];
                                  print("prize_breakup====>>>"+prize_breakup[index].toString());
                                  if(widget.fromMyContest == false){
                                    Map map = prize_breakup[index];
                                    map.forEach((key,value){
                                      key1 = key.toString();
                                      value1 = value.toString();
                                    });
                                  }
                                  else{
                                    var arr = prize_breakup[index].toString().split(":");
                                    var arr1 = arr[0].split("'");
                                    key1 = arr1[1].toString();
                                    var arr2 = arr[1].split("'");
                                    value1 = arr2[1].toString();
                                  }
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 30.w,),
                                                    Text("#",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: Colors.grey,
                                                        fontSize: 15.sp
                                                    ),),
                                                    SizedBox(width: 2.h,),
                                                    Text(key1.toString(),style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: Colors.black,
                                                        fontSize: 15.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                            Row(
                                              children: [
                                                Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h),
                                                SizedBox(width: 0.h,),
                                                Text(value1.toString(),style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 15.sp
                                                ),),
                                                SizedBox(width: 30.w,),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height: 0.5.sp,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  );
                                }
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          (serverResponse != null && isTimeOver == false) ? Expanded(child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: serverResponse!["data"].length,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                    onTap: (){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content: Text("Please wait till the match starts to view other teams.",style: TextStyle(color: Colors.white,fontSize: 15.sp),)));
                                    },
                                    child:Padding(
                                        padding: EdgeInsets.only(top: 0.h,bottom: 10.h),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width.w,
                                              height: 0.5,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: 20.w,),
                                                Image.asset("assets/images/userprofile.png",height: 40.h,width: 40.w,),
                                                SizedBox(width: 15.w,),
                                                Expanded(child: Text(serverResponse!["data"][index]["user_name"].toString(),style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.bold),)),
                                                Container(
                                                    width: 100.w,
                                                    height:35.h,
                                                    padding: EdgeInsets.all(2.h),
                                                    margin: EdgeInsets.only(left: 20.w,right: 0.w),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(5.h)
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [
                                                        Text(serverResponse!["data"][index]["team_name"].toString(),textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(width: 15.w,),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width.w,
                                              height: 0.5,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        )
                                    )
                                );
                              }
                          )):SizedBox(),
                          (playerDetailResponse != null && isTimeOver == true) ? Expanded(
                              child: ListView(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 40.w,),
                                      Expanded(child: Text("All Teams",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),),),
                                      Text("Points",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),),
                                      SizedBox(width: 50.w,),
                                      Text("Rank",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),),
                                      SizedBox(width: 20.w,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: playerDetailResponse!["data"].length,
                                      shrinkWrap: true,
                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: (){
                                            getCounts(playerDetailResponse,index);
                                            showPreViewScreen(context,playerDetailResponse,index);
                                          },
                                          child: Padding(
                                              padding: EdgeInsets.only(top: 0.h,bottom: 10.h),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: MediaQuery.of(context).size.width.w,
                                                    height: 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Row(
                                                            children: [
                                                              SizedBox(width: 10.w,),
                                                              Image.asset("assets/images/userprofile.png",height: 30.h,width: 30.w,),
                                                              SizedBox(width: 15.w,),
                                                              Text(playerDetailResponse!["data"][index]["user_name"].toString(),style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.bold),),
                                                              SizedBox(width: 5.w,),
                                                              Container(
                                                                  width: 100.w,
                                                                  height:35.h,
                                                                  padding: EdgeInsets.all(2.h),
                                                                  margin: EdgeInsets.only(left: 20.w,right: 0.w),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.green,
                                                                      borderRadius: BorderRadius.circular(5.h)
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(playerDetailResponse!["data"][index]["team_name"].toString(),textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                                                    ],
                                                                  )
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                      Container(
                                                        width: 70.w,
                                                        child: (playerDetailResponse!["data"][index]["team_value"].toString() != "null") ? Text(playerDetailResponse!["data"][index]["team_value"].toString(),style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.grey,
                                                          fontSize: 16.sp,
                                                        ),):Text("0",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.grey,
                                                          fontSize: 16.sp,
                                                        ),),
                                                      ),
                                                      SizedBox(width: 20.w,),
                                                      Container(
                                                        width: 50.w,
                                                        child:  Text((index+1).toString(),style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.black,
                                                          fontSize: 16.sp,
                                                        ),)
                                                      ),
                                                      SizedBox(width: 0.w,),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width.w,
                                                    height: 0.5,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              )
                                          ),
                                        );
                                      }
                                  )
                                ],
                              )
                          ):SizedBox(),
                        ],
                      )
                    ],
                  ),
                ),)
              ],
            )
          )
      ),
    );
  }

  showMyTeamsData(){
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height.h/1.2.h,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                    color: Colors.black,
                    height: 40.h,
                    child: Padding(
                        padding: EdgeInsets.only(top: 15.h,bottom: 0.h),
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
                                          width: 0.h,
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),

                          ],
                        )
                    )
                ),
                Expanded(child: (teamsResponse != null ) ? Expanded(child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: teamsResponse!["data"].length,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      print(teamsResponse!["data"][index].toString());
                      return GestureDetector(
                        onTap: (){
                          //Get.back();
                          getCounts(teamsResponse,index);
                          showPreViewScreen(context,teamsResponse,index);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 0.h,bottom: 10.h),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20.w,),
                                    Image.asset("assets/images/userprofile.png",height: 30.h,width: 30.w,),
                                    SizedBox(width: 15.w,),
                                    Expanded(child: Text(teamsResponse!["data"][index]["user_name"].toString(),style: TextStyle(color: Colors.black,fontSize: 13.sp,fontWeight: FontWeight.bold),)),
                                    Container(
                                        width: 100.w,
                                        height:35.h,
                                        padding: EdgeInsets.all(2.h),
                                        margin: EdgeInsets.only(left: 20.w,right: 0.w),
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(5.h)
                                        ),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Text(teamsResponse!["data"][index]["team_name"].toString(),textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 10.sp,fontWeight: FontWeight.bold),),
                                          ],
                                        )
                                    ),
                                    SizedBox(width: 5.w,),
                                  ],
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                              ],
                            )
                        ),
                      );
                    }
                )):SizedBox(),)
              ],
            )
          );
        }
    );
  }



  getCounts(Map<String, dynamic>? serverResponse,int index){
    team1Count = 0 ; team2Count = 0;
    for(int i=0 ; i<serverResponse!["data"][index]["players"].length ; i++){
      print(teamsArrayName[0].toString()+"\t\t\t"+serverResponse["data"][index]["players"][i]["team"].toString());
      if(teamsArrayName[0].trim().toString() == serverResponse["data"][index]["players"][i]["team"].toString()){
        setState((){
          team1Count = team1Count + 1;
        });
      }
      if(teamsArrayName[1].trim().toString() == serverResponse["data"][index]["players"][i]["team"].toString()){
        setState((){
          team2Count = team2Count + 1;
        });
      }
    }
  }

  showPreViewScreen(BuildContext context,Map<String,dynamic>? playerDetailResponse,int index1){
    team1Count = 0 ; team2Count = 0;
    wkAdd = 0 ; batAdd = 0 ; arAdd = 0 ; bowlAdd = 0;
    wKplayerList.clear();
    batplayerList.clear();
    allrplayerList.clear();
    bowlplayerList.clear();
    for(int i=0 ; i<playerDetailResponse!["data"]![index1]["players"].length ; i++){
      if(teamsArrayName[0].trim().toString() == playerDetailResponse["data"][index1]["players"][i]["team"].toString()){
        setState((){
          team1Count = team1Count + 1;
        });
      }
      if(teamsArrayName[1].trim().toString() == playerDetailResponse["data"][index1]["players"][i]["team"].toString()){
        setState((){
          team2Count = team2Count + 1;
        });
      }
      if(playerDetailResponse["data"][index1]["players"][i]["position"].toString() == "WK"){
        wKplayerList.add(PlayerData(playerDetailResponse["data"][index1]["players"][i]["name"].toString(),playerDetailResponse["data"][index1]["players"][i]["pre_cp"].toString(),playerDetailResponse["data"][index1]["players"][i]["position"].toString(),playerDetailResponse["data"][index1]["players"][i]["team"].toString(),playerDetailResponse["data"][index1]["players"][i]["id"].toString(),playerDetailResponse["data"][index1]["players"][i]["index"].toString(),playerDetailResponse["data"][index1]["players"][i]["type"].toString(),playerDetailResponse["data"][index1]["players"][i]["captain"].toString(),playerDetailResponse["data"][index1]["players"][i]["vc"].toString()));
        wkAdd = wkAdd + 1;
      }
      else if(playerDetailResponse["data"][index1]["players"][i]["position"] == "BAT"){
        batplayerList.add(PlayerData(playerDetailResponse["data"][index1]["players"][i]["name"].toString(),playerDetailResponse["data"][index1]["players"][i]["pre_cp"].toString(),playerDetailResponse["data"][index1]["players"][i]["position"].toString(),playerDetailResponse["data"][index1]["players"][i]["team"].toString(),playerDetailResponse["data"][index1]["players"][i]["id"].toString(),playerDetailResponse["data"][index1]["players"][i]["index"].toString(),playerDetailResponse["data"][index1]["players"][i]["type"].toString(),playerDetailResponse["data"][index1]["players"][i]["captain"].toString(),playerDetailResponse["data"][index1]["players"][i]["vc"].toString()));
        batAdd = batAdd + 1;
      }
      else if(playerDetailResponse["data"][index1]["players"][i]["position"] == "ALL-R"){
        allrplayerList.add(PlayerData(playerDetailResponse["data"][index1]["players"][i]["name"].toString(),playerDetailResponse["data"][index1]["players"][i]["pre_cp"].toString(),playerDetailResponse["data"][index1]["players"][i]["position"].toString(),playerDetailResponse["data"][index1]["players"][i]["team"].toString(),playerDetailResponse["data"][index1]["players"][i]["id"].toString(),playerDetailResponse["data"][index1]["players"][i]["index"].toString(),playerDetailResponse["data"][index1]["players"][i]["type"].toString(),playerDetailResponse["data"][index1]["players"][i]["captain"].toString(),playerDetailResponse["data"][index1]["players"][i]["vc"].toString()));
        arAdd = arAdd + 1;
      }
      else if(playerDetailResponse["data"][index1]["players"][i]["position"] == "BOWL"){
        bowlplayerList.add(PlayerData(playerDetailResponse["data"][index1]["players"][i]["name"].toString(),playerDetailResponse["data"][index1]["players"][i]["pre_cp"].toString(),playerDetailResponse["data"][index1]["players"][i]["position"].toString(),playerDetailResponse["data"][index1]["players"][i]["team"].toString(),playerDetailResponse["data"][index1]["players"][i]["id"].toString(),playerDetailResponse["data"][index1]["players"][i]["index"].toString(),playerDetailResponse["data"][index1]["players"][i]["type"].toString(),playerDetailResponse["data"][index1]["players"][i]["captain"].toString(),playerDetailResponse["data"][index1]["players"][i]["vc"].toString()));
        bowlAdd = bowlAdd + 1;
      }
    }

    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Column(
            children: [
              Container(
                  color: Colors.black,
                  height: 105.h,
                  child: Padding(
                      padding: EdgeInsets.only(top: 25.h,bottom: 0.h),
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
                                        width: 0.h,
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Players",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(playerDetailResponse["data"][index1]["players"].length.toString()+"/11",style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),),
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Expanded(
                                flex:1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(teamsArrayName[0].toString(),style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                    SizedBox(width:35.h),
                                    Text("$team1Count",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex:1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width:10.h),
                                    Text(teamsArrayName[1].toString(),style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                    SizedBox(width:35.h),
                                    Text("$team2Count",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                  ],
                                ),
                              ),
                              /*Expanded(
                                  flex:1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Credits Left",style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp
                                          ),),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("creditsLeft".toString(),style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp
                                          ),),
                                        ],
                                      )
                                    ],
                                  )
                              ),*/
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      )
                  )
              ),
              Expanded(
                  child: Center(
                    child:  Container(
                        height: MediaQuery.of(context).size.height.h,
                        width: MediaQuery.of(context).size.width.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/previewbackground.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              children: [
                                Text("WICKET-KEEPERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (wkAdd > 0) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (wKplayerList[0].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (wKplayerList[0].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/wicketkeeper.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(wKplayerList[0].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (wkAdd > 2) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (wKplayerList[2].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (wKplayerList[2].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/wicketkeeper.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(wKplayerList[2].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (wkAdd > 3) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (wKplayerList[3].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (wKplayerList[3].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/wicketkeeper.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(wKplayerList[3].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (wkAdd > 1) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (wKplayerList[1].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (wKplayerList[1].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/wicketkeeper.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(wKplayerList[1].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Text("BATTERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (batAdd > 0) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (batplayerList[0].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (batplayerList[0].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(batplayerList[0].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (batAdd > 1) ? Expanded(flex:1,child: Center(child:Padding(
                                                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            (batplayerList[1].captain.toString() == "2") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                            (batplayerList[1].vc.toString() == "1.5") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(width:2.h),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                            Stack(
                                                              children: [
                                                                Transform.translate(
                                                                  offset: Offset(0.0, -25.0 / 2.0),
                                                                  child: Container(
                                                                    width: 70.w,
                                                                    height: 30.h,
                                                                    padding: EdgeInsets.all(2.h),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants.colorBlackHint,
                                                                        borderRadius: BorderRadius.circular(10.h)
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(batplayerList[1].name.toString(),
                                                                        textAlign:TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 10.sp
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                            ))) : SizedBox(),
                                            (batAdd > 2) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (batplayerList[2].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (batplayerList[2].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(batplayerList[2].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (batAdd > 3) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (batplayerList[3].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (batplayerList[3].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(batplayerList[3].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (batAdd > 4) ? Expanded(flex:1,child: Center(child:Padding(
                                                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            (batplayerList[4].captain.toString() == "2") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                            (batplayerList[4].vc.toString() == "1.5") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(width:2.h),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                            Stack(
                                                              children: [
                                                                Transform.translate(
                                                                  offset: Offset(0.0, -25.0 / 2.0),
                                                                  child: Container(
                                                                    width: 70.w,
                                                                    height: 30.h,
                                                                    padding: EdgeInsets.all(2.h),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants.colorBlackHint,
                                                                        borderRadius: BorderRadius.circular(10.h)
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(batplayerList[4].name.toString(),
                                                                        textAlign:TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 10.sp
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                            ))) : SizedBox(),
                                            (batAdd > 5) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (batplayerList[5].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (batplayerList[5].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/batsman.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(batplayerList[5].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                /*Center(
                                    child: Container(
                                        height: 75.h,
                                        child:Center(
                                          child:  ListView.builder(
                                              itemCount : playerList.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context,index){
                                                return (playerList[index].position == "BAT") ? Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (playerList[index].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (playerList[index].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/homeuser.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(playerList[index].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                ) : SizedBox();
                                              }
                                          ),
                                        )
                                    ),
                                  ),*/
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Text("ALL ROUNDERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (arAdd > 0) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (allrplayerList[0].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (allrplayerList[0].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/allrounder.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(allrplayerList[0].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (arAdd > 2) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (allrplayerList[2].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (allrplayerList[2].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/allrounder.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(allrplayerList[2].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (arAdd > 3) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (allrplayerList[3].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (allrplayerList[3].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/allrounder.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(allrplayerList[3].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (arAdd > 1) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (allrplayerList[1].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (allrplayerList[1].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/allrounder.png",height: 40.h,width: 40.w),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(allrplayerList[1].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Column(
                              children: [
                                Text("BOWLERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (bowlAdd > 0) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (bowlplayerList[0].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (bowlplayerList[0].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(bowlplayerList[0].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (bowlAdd > 1) ? Expanded(flex:1,child: Center(child:Padding(
                                                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            (bowlplayerList[1].captain.toString() == "2") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                            (bowlplayerList[1].vc.toString() == "1.5") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(width:2.h),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                            Stack(
                                                              children: [
                                                                Transform.translate(
                                                                  offset: Offset(0.0, -25.0 / 2.0),
                                                                  child: Container(
                                                                    width: 70.w,
                                                                    height: 30.h,
                                                                    padding: EdgeInsets.all(2.h),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants.colorBlackHint,
                                                                        borderRadius: BorderRadius.circular(10.h)
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(bowlplayerList[1].name.toString(),
                                                                        textAlign:TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 10.sp
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                            ))) : SizedBox(),
                                            (bowlAdd > 2) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (bowlplayerList[2].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (bowlplayerList[2].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(bowlplayerList[2].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Center(
                                  child: Container(
                                    //height: 70.h,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            (bowlAdd > 3) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (bowlplayerList[3].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (bowlplayerList[3].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(bowlplayerList[3].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                            (bowlAdd > 4) ? Expanded(flex:1,child: Center(child:Padding(
                                                padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                child:Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            (bowlplayerList[4].captain.toString() == "2") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                            (bowlplayerList[4].vc.toString() == "1.5") ? Container(
                                                              width: 25.w,
                                                              height: 25.h,
                                                              child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: ColorConstants.colorBlack
                                                              ),
                                                            ) : SizedBox(),
                                                          ],
                                                        ),
                                                        SizedBox(width:2.h),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                            Stack(
                                                              children: [
                                                                Transform.translate(
                                                                  offset: Offset(0.0, -25.0 / 2.0),
                                                                  child: Container(
                                                                    width: 70.w,
                                                                    height: 30.h,
                                                                    padding: EdgeInsets.all(2.h),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorConstants.colorBlackHint,
                                                                        borderRadius: BorderRadius.circular(10.h)
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(bowlplayerList[4].name.toString(),
                                                                        textAlign:TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 10.sp
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                            ))) : SizedBox(),
                                            (bowlAdd > 5) ? Expanded(flex:1,child: Center(
                                                child:Padding(
                                                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                                                    child:Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                (bowlplayerList[5].captain.toString() == "2") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                                (bowlplayerList[5].vc.toString() == "1.5") ? Container(
                                                                  width: 25.w,
                                                                  height: 25.h,
                                                                  child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape.circle,
                                                                      color: ColorConstants.colorBlack
                                                                  ),
                                                                ) : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(width:2.h),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/bowler.png",height: 40.h,width: 40.w,),
                                                                Stack(
                                                                  children: [
                                                                    Transform.translate(
                                                                      offset: Offset(0.0, -25.0 / 2.0),
                                                                      child: Container(
                                                                        width: 70.w,
                                                                        height: 30.h,
                                                                        padding: EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color: ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(bowlplayerList[5].name.toString(),
                                                                            textAlign:TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        //Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                      ],
                                                    )
                                                )
                                            )) : SizedBox(),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),

                          ],
                        )
                    ),
                  )
              )
            ],
          );
        }
    );
  }


}













