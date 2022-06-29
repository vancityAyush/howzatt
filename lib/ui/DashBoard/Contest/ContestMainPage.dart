import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/Bloc/ContestBloc/ContestBloc.dart';
import 'package:howzatt/Bloc/MatchBloc/MatchBloc.dart';
import 'package:howzatt/Repository/ContestRepository.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/modal/UserData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/ui/DashBoard/WinningLeaderBoard/LeaderBoardMainPage.dart';
import 'package:howzatt/ui/Notifications/Notifications.dart';
import 'package:howzatt/ui/WalletDetails/MyWallet.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:howzatt/utils/DataNotAvailable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ContestMainPage extends StatelessWidget {

  String? matchId,name,startDate;

  ContestMainPage(String? _matchId,String? _name,String? _startDate){
    matchId = _matchId;
    name = _name;
    startDate = _startDate;
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
          child: ContestMainPageStateful(matchId,name,startDate),
        )
    );
  }
}



class ContestMainPageStateful extends StatefulWidget {
  String? matchId,name,startDate;

  ContestMainPageStateful(String? _matchId,String? _name,String? _startDate){
    matchId = _matchId;
    name = _name;
    startDate = _startDate;
  }

  @override
  _ContestMainPageState createState() => _ContestMainPageState();
}


class _ContestMainPageState extends State<ContestMainPageStateful> with SingleTickerProviderStateMixin{

  List<int> listInt = [1,2,3,4,5];
  int _current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;
  Map<String,dynamic>? serverResponse , myServerResponse , teamsResponse;
  double firstAmount = 0.0 , sumAmount = 0.0 ;
  int spotsLeft = 0;
  int endTime = 0;
  late List<UserData> usersList;
  UserDataService userDataService =  getIt<UserDataService>();

  TextEditingController amountController = new TextEditingController();
  TextEditingController disableamountController = new TextEditingController();
  TextEditingController maxTeamsController = new TextEditingController();
  TextEditingController prizeController = new TextEditingController();
  List prize_breakup = List.empty(growable: true);
  BuildContext? providerContext;
  String user_id ="";
  Map<String,dynamic> match_details = new Map<String,dynamic>();
  bool isTimeOver = false;
  int myContestLength = 0 ;
  List<UserData> serachUsersList = List.empty(growable: true);


  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    BlocProvider.of<ContestBloc>(context).add(FetchContestEvent(context: context,matchId: widget.matchId.toString()));
    BlocProvider.of<ContestBloc>(context).add(FetchMyContestEvent(context: context,matchId: widget.matchId.toString()));
    BlocProvider.of<ContestBloc>(context).add(FetchAllUsersEvent(context: context));

    DateTime dateTime = DateTime.parse(widget.startDate.toString());
    endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;

    user_id = userDataService.userData.id;
    var nameArray = widget.name.toString().split("vs");
    match_details.putIfAbsent("name", () => widget.name.toString());
    match_details.putIfAbsent("team1", () => nameArray[0].toString());
    match_details.putIfAbsent("team2", () => nameArray[1].toString());

    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Get.to(HomePage());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(150.h),
              child: Container(
                height: 119.h,
                child: Column(
                  children: [
                    Container(
                        color: Colors.black,
                        height: 80.h,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.h,bottom: 0.h),
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
                                          Get.to(HomePage());
                                        },
                                        child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                                      ),
                                      SizedBox(
                                        width: 0.h,
                                      ),
                                      Column(
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
                                                          fontSize: 15.sp
                                                      ),) : SizedBox(),
                                                      (time.hours != null) ? Text(time.hours.toString()+" hrs ",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.white,
                                                          fontSize: 15.sp
                                                      ),) : SizedBox(),
                                                      (time.min != null) ? Text(time.min.toString()+" min ",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.white,
                                                          fontSize: 15.sp
                                                      ),) : SizedBox(),
                                                      (time.sec != null) ? Text(time.sec.toString()+" sec",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.white,
                                                          fontSize: 15.sp
                                                      ),) : SizedBox(),
                                                    ],
                                                  );
                                                  // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.to(Notifications());
                                    },
                                    child: Image.asset('assets/images/homenotification.png', width: 22.w ,height: 22.h),
                                  ),
                                  SizedBox(width: 10.h,),
                                  InkWell(
                                    onTap: (){
                                      Get.to(MyWallet());
                                    },
                                    child: Image.asset('assets/images/homewallet.png', width: 22.w ,height: 22.h),
                                  ),
                                  SizedBox(width: 10.h,),
                                ],
                              )
                            ],
                          ),
                        )
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
                        Tab(text: "Contests"),
                        Tab(text: "My Contest($myContestLength)"),
                        //Tab(text: "My Teams(1)"),
                      ],
                    ),
                  ],
                ),
              )
          ),
          body: Column(
            children: [

              Expanded(
                  child: BlocListener<ContestBloc,ContestState>(
                listener: (context,state){
                  providerContext = context;
                  if(state is FetchContestCompleteState){
                    setState((){
                      serverResponse = state.serverResponse;
                    });
                  }
                  if(state is FetchMyContestCompleteState){
                    setState((){
                      myServerResponse = state.serverResponse;
                      myContestLength = myServerResponse!["data"].length;
                    });
                  }
                  if(state is FetchAllUsersCompleteState){
                    setState((){
                      usersList = state.usersList;
                    });
                  }
                  if(state is CreateContestCompleteState){
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Get.back();
                      Get.to(ContestMainPage(widget.matchId,widget.name,widget.startDate));
                    });
                  }
                },
                child:TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    (serverResponse != null && serverResponse!["data"] != null && serverResponse!["data"].length > 0) ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: serverResponse!["data"].length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          firstAmount = 0.0 ; sumAmount = 0.0; spotsLeft = 0;
                          List prizeBreakups = serverResponse!["data"][index]["prize_breakup"];
                          spotsLeft = int.parse(serverResponse!["data"][index]["max_teams"].toString()) - int.parse(serverResponse!["data"][index]["teams_joined"].toString());
                          var valueRange;
                          if(int.parse(serverResponse!["data"][index]["max_teams"].toString()) > int.parse(serverResponse!["data"][index]["teams_joined"].toString())){
                            valueRange = (int.parse(serverResponse!["data"][index]["teams_joined"].toString()) - int.parse(serverResponse!["data"][index]["max_teams"].toString())) / 100;
                          }
                          else if(int.parse(serverResponse!["data"][index]["teams_joined"].toString()) >= int.parse(serverResponse!["data"][index]["max_teams"].toString())){
                            valueRange = (int.parse(serverResponse!["data"][index]["max_teams"].toString()) - int.parse(serverResponse!["data"][index]["teams_joined"].toString())) / 100;
                          }
                          if(prizeBreakups != null && prizeBreakups.length > 0){
                            var data1 = prizeBreakups[0].toString().split(":");
                            var data2 = data1[1].split("}");
                            firstAmount = double.parse(data2[0].toString());
                          }
                          prizeBreakups.forEach((element) {
                            var data1 = element.toString().split(":");
                            var data2 = data1[1].split("}");
                            sumAmount = sumAmount + double.parse(data2[0].toString());
                          });
                          return GestureDetector(
                            onTap: (){
                              Get.to(LeaderBoardMainPage(widget.matchId.toString(),serverResponse!["data"][index]["amount"].toString(),widget.name.toString(),widget.startDate.toString(),serverResponse,index,serverResponse!["data"][index]["_id"].toString(),false));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                              child: Container(
                                height: 150.h,
                                child: Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.h), topLeft: Radius.circular(20.h),bottomRight: Radius.circular(20.h),topRight: Radius.circular(20.h))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h,bottom: 7.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        Image.asset('assets/images/prize.png', width: 22.w ,height: 22.h),
                                                        SizedBox(width: 5.h,),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text(
                                                              "Prizes Pool",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'RoLight',
                                                                  color: ColorConstants.colorBlack,
                                                                  fontSize: 15.sp
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),
                                                InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Image.asset('assets/images/entry.png', width: 22.w ,height: 22.h),
                                                ),
                                                SizedBox(width: 5.h,),
                                                Text("Entry",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 13.sp
                                                ),),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              height: 1.h,
                                              width: MediaQuery.of(context).size.width.w,
                                              color: ColorConstants.colorLoginBtn,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10.w,),
                                                        Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: Colors.black,),
                                                        SizedBox(width: 5.w,),
                                                        Text(sumAmount.toString(),style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            color: Colors.black,
                                                            fontSize: 17.sp
                                                        ),),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    width: 60.h,
                                                    height:25.h,
                                                    padding: EdgeInsets.all(2.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(20.h)
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: Colors.white,),
                                                        Center(
                                                          child: Text(serverResponse!["data"][index]["amount"].toString(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontSize: 14.sp
                                                          ),),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                                alignment: Alignment.topCenter,
                                                margin: EdgeInsets.only(top: 5.h,bottom: 5.h,left: 5.h,right: 5.h),
                                                child: LinearProgressIndicator(
                                                  value: valueRange,
                                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                                                  backgroundColor: Colors.grey,
                                                )
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10.w,),
                                                        Text(spotsLeft.toString()+" Spots Left",style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            color: ColorConstants.colorLoginBtn,
                                                            fontSize: 14.sp
                                                        ),),
                                                      ],
                                                    )
                                                ),
                                                Text(serverResponse!["data"][index]["max_teams"].toString()+" Spots ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.grey,
                                                    fontSize: 14.sp
                                                ),),
                                              ],
                                            ),
                                          ],
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
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.h) , bottomLeft: Radius.circular(20.h))
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex:2,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width:15.h),
                                                      Image.asset('assets/images/gold_medal.png', width: 20.w ,height: 20.h),
                                                      SizedBox(width: 5.h,),
                                                      Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h),
                                                      SizedBox(width: 2.h,),
                                                      Text(firstAmount.toString(),style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.black,
                                                          fontSize: 13.sp
                                                      ),),
                                                    ],
                                                  )
                                              ),
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  SizedBox(width:10.h),
                                                  Text("Up to "+serverResponse!["data"][index]["max_one_person_teams"].toString(),style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ],
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset('assets/images/guarantee.png', width: 20.w ,height: 20.h),
                                                      SizedBox(width: 5.h,),
                                                      Text("Gurantee",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.black,
                                                          fontSize: 13.sp
                                                      ),),
                                                      SizedBox(width: 10.h,),
                                                    ],
                                                  )
                                              )
                                            ],
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ) : DataNotAvailable.dataNotAvailable("Data not available."),
                    (myServerResponse != null && myServerResponse!["data"] != null && myServerResponse!["data"].length > 0) ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: myServerResponse!["data"].length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){

                          firstAmount = 0.0 ; sumAmount = 0.0; spotsLeft = 0;
                          List prizeBreakups = myServerResponse!["data"][index]["prize_breakup"];
                          spotsLeft = int.parse(myServerResponse!["data"][index]["max_teams"].toString()) - int.parse(myServerResponse!["data"][index]["teams_joined"].toString());
                          var valueRange;
                          if(int.parse(myServerResponse!["data"][index]["max_teams"].toString()) > int.parse(myServerResponse!["data"][index]["teams_joined"].toString())){
                            valueRange = (int.parse(myServerResponse!["data"][index]["teams_joined"].toString()) - int.parse(myServerResponse!["data"][index]["max_teams"].toString())) / 100;
                          }
                          else if(int.parse(myServerResponse!["data"][index]["teams_joined"].toString()) >= int.parse(myServerResponse!["data"][index]["max_teams"].toString())){
                            valueRange = (int.parse(myServerResponse!["data"][index]["max_teams"].toString()) - int.parse(myServerResponse!["data"][index]["teams_joined"].toString())) / 100;
                          }
                          if(prizeBreakups != null && prizeBreakups.length > 0){
                            var data1 = prizeBreakups[0].toString().split(":");
                            var data2 = data1[1].split("}");
                            if(data2.length > 0 && data2[0] != "''")
                           {
                             var amoutnArray = data2[0].toString().split("'");
                             firstAmount = double.parse(amoutnArray[1].toString());
                           }
                          }
                          prizeBreakups.forEach((element) {
                            var data1 = element.toString().split(":");
                            var data2 = data1[1].split("}");
                            if(data2.length > 0 && data2[0] != "''")
                            {
                              var amoutnArray = data2[0].toString().split("'");
                              sumAmount = sumAmount + double.parse(amoutnArray[1].toString());
                            }
                          });
                          return GestureDetector(
                            onTap: (){
                              Get.to(LeaderBoardMainPage(widget.matchId.toString(),myServerResponse!["data"][index]["amount"].toString(),widget.name.toString(),widget.startDate.toString(),myServerResponse,index,myServerResponse!["data"][index]["_id"].toString(),true));
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                              child: Container(
                                height: 150.h,
                                child: Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.h), topLeft: Radius.circular(20.h),bottomRight: Radius.circular(20.h),topRight: Radius.circular(20.h))),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h,bottom: 7.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        Image.asset('assets/images/prize.png', width: 22.w ,height: 22.h),
                                                        SizedBox(width: 5.h,),
                                                        Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 5.h,
                                                            ),
                                                            Text(
                                                              "Prizes Pool",
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'RoLight',
                                                                  color: ColorConstants.colorBlack,
                                                                  fontSize: 15.sp
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),
                                                InkWell(
                                                  onTap: (){

                                                  },
                                                  child: Image.asset('assets/images/entry.png', width: 22.w ,height: 22.h),
                                                ),
                                                SizedBox(width: 5.h,),
                                                Text("Entry",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 13.sp
                                                ),),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Container(
                                              height: 1.h,
                                              width: MediaQuery.of(context).size.width.w,
                                              color: ColorConstants.colorLoginBtn,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10.w,),
                                                        Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: Colors.black,),
                                                        SizedBox(width: 5.w,),
                                                        Text(sumAmount.toString(),style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            color: Colors.black,
                                                            fontSize: 17.sp
                                                        ),),
                                                      ],
                                                    )
                                                ),
                                                Container(
                                                    width: 60.h,
                                                    height:25.h,
                                                    padding: EdgeInsets.all(2.h),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(20.h)
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h,color: Colors.white,),
                                                        Center(
                                                          child: Text(myServerResponse!["data"][index]["amount"].toString(),style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontSize: 14.sp
                                                          ),),
                                                        ),
                                                      ],
                                                    ))
                                              ],
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Container(
                                                alignment: Alignment.topCenter,
                                                margin: EdgeInsets.only(top: 5.h,bottom: 5.h,left: 5.h,right: 5.h),
                                                child: LinearProgressIndicator(
                                                  value: valueRange,
                                                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                                                  backgroundColor: Colors.grey,
                                                )
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 10.w,),
                                                        Text(spotsLeft.toString()+" Spots Left",style: TextStyle(
                                                            fontFamily: 'RoMedium',
                                                            color: ColorConstants.colorLoginBtn,
                                                            fontSize: 14.sp
                                                        ),),
                                                      ],
                                                    )
                                                ),
                                                Text(myServerResponse!["data"][index]["max_teams"].toString()+" Spots ",style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.grey,
                                                    fontSize: 14.sp
                                                ),),
                                              ],
                                            ),
                                          ],
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
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.h) , bottomLeft: Radius.circular(20.h))
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex:2,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width:15.h),
                                                      Image.asset('assets/images/gold_medal.png', width: 20.w ,height: 20.h),
                                                      SizedBox(width: 5.h,),
                                                      Image.asset('assets/images/rupee_indian.png', width: 12.w ,height: 12.h),
                                                      SizedBox(width: 2.h,),
                                                      Text(firstAmount.toString(),style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.black,
                                                          fontSize: 13.sp
                                                      ),),
                                                    ],
                                                  )
                                              ),
                                              Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  SizedBox(width:10.h),
                                                  Text("Up to "+myServerResponse!["data"][index]["max_one_person_teams"].toString(),style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.black,
                                                      fontSize: 13.sp
                                                  ),),
                                                ],
                                              ),
                                              Expanded(
                                                  flex: 2,
                                                  child: (userDataService.userData.id.toString() == myServerResponse!["data"][index]["user_id"].toString()) ?
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(width: 5.h,),
                                                        Image.asset('assets/images/userprofile.png', width: 25.w ,height: 25.h),
                                                        SizedBox(width: 5.h,),
                                                        GestureDetector(
                                                          onTap: (){
                                                            inviteFriends(context,usersList,myServerResponse!["data"][index]["_id"].toString(),widget.matchId,widget.name,widget.startDate);
                                                          },
                                                          child:Text("Invite",style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.black,
                                                              fontSize: 13.sp
                                                          ),),
                                                        ),
                                                        SizedBox(width: 10.h,),
                                                      ],
                                                    )
                                                  : SizedBox()
                                              )
                                            ],
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ) : DataNotAvailable.dataNotAvailable("Data not available."),
                    /*(teamsResponse != null && teamsResponse!["data"] != null && teamsResponse!["data"].length > 0) ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: teamsResponse!["data"].length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(left: 15.h,right: 15.h,top: 7.h),
                            child: Container(
                              height: 150.h,
                              child: Card(
                                elevation: 3,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(17.h), topLeft: Radius.circular(17.h),bottomRight: Radius.circular(17.h),topRight: Radius.circular(17.h))),
                                child: Column(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height:35.h,
                                        decoration: BoxDecoration(
                                            color: ColorConstants.colordarkloginBtn,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(17.h) , topLeft: Radius.circular(17.h))
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:15.h),
                                                    Text("Yashblaster team (T1)",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: Colors.white,
                                                        fontSize: 13.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                            Image.asset("assets/images/edit.png" , height: 20.h, width: 20.w, color: Colors.white,),
                                            SizedBox(width: 10.w,),
                                            Image.asset("assets/images/data_copy.png" , height: 20.h, width: 20.w, color: Colors.white,),
                                            SizedBox(width: 20.w,)
                                          ],
                                        )
                                    ),
                                    Expanded(
                                      child: Container(
                                          width: MediaQuery.of(context).size.width.w,
                                          decoration: BoxDecoration(
                                            color: ColorConstants.colorLoginBtn,
                                          ),
                                          child: Padding(
                                              padding: EdgeInsets.only(left: 5.h,right: 5.h,top: 7.h,bottom: 7.h),
                                              child: Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(width:5.h),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text("DT-W",style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 13.sp
                                                          ),),
                                                          Text("7",style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp
                                                          ),),
                                                        ],
                                                      ),
                                                      SizedBox(width:15.h),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text("DD-W",style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 13.sp
                                                          ),),
                                                          Text("4",style: TextStyle(
                                                              fontFamily: 'RoMedium',
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 15.sp
                                                          ),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width:20.h),
                                                  Expanded(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width:0.h),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                width: 25.w,
                                                                height: 25.h,
                                                                child: Center(child:  Text("C" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: ColorConstants.colorBlack
                                                                ),
                                                              ),
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
                                                                      height: 25.h,
                                                                      padding: EdgeInsets.all(0.h),
                                                                      decoration: BoxDecoration(
                                                                          color: ColorConstants.colorBlackHint,
                                                                          borderRadius: BorderRadius.circular(10.h)
                                                                      ),
                                                                      child: Center(
                                                                        child: Text("U. Chetry",style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 12.sp
                                                                        ),),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width:2.h),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                width: 25.w,
                                                                height: 25.h,
                                                                child: Center(child:  Text("VC" , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape.circle,
                                                                    color: ColorConstants.colorBlack
                                                                ),
                                                              ),
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
                                                                      height: 25.h,
                                                                      padding: EdgeInsets.all(0.h),
                                                                      decoration: BoxDecoration(
                                                                          color: ColorConstants.colorBlackHint,
                                                                          borderRadius: BorderRadius.circular(10.h)
                                                                      ),
                                                                      child: Center(
                                                                        child: Text("U. Chetry",style: TextStyle(
                                                                            fontFamily: 'RoMedium',
                                                                            color: Colors.white,
                                                                            fontSize: 12.sp
                                                                        ),),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(width:2.h),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ))
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width.w,
                                        height:25.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(17.h) , bottomLeft: Radius.circular(17.h))
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex:1,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:15.h),
                                                    Text("WK",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontSize: 13.sp
                                                    ),),
                                                    SizedBox(width: 5.h,),
                                                    Text("1",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex:1,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:15.h),
                                                    Text("BAT",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontSize: 13.sp
                                                    ),),
                                                    SizedBox(width: 5.h,),
                                                    Text("3",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex:1,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:15.h),
                                                    Text("AR",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontSize: 13.sp
                                                    ),),
                                                    SizedBox(width: 5.h,),
                                                    Text("2",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex:1,
                                                child: Row(
                                                  children: [
                                                    SizedBox(width:15.h),
                                                    Text("BOWL",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontSize: 13.sp
                                                    ),),
                                                    SizedBox(width: 5.h,),
                                                    Text("5",style: TextStyle(
                                                        fontFamily: 'RoMedium',
                                                        color: ColorConstants.colorBlackHint,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13.sp
                                                    ),),
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ) : DataNotAvailable.dataNotAvailable("Data not available."),*/
                  ],
                ),
              )
              )
            ],
          ),
          floatingActionButton: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox()
              ),
              FloatingActionButton.extended(
                  backgroundColor: ColorConstants.colorBlackHint,
                  heroTag: "Create Contest",
                  onPressed:(){
                    if(isTimeOver == false){
                      showPreViewScreen(context);
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You're not able to create Contest.",style: TextStyle(color: Colors.white,fontSize: 15.sp,fontWeight: FontWeight.bold),),backgroundColor: Colors.red,));
                    }
                  },
                  label: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    transitionBuilder: (Widget child, Animation<double> animation) =>
                        FadeTransition(
                          opacity: animation,
                          child: SizeTransition(child:
                          child,
                            sizeFactor: animation,
                            axis: Axis.horizontal,
                          ),
                        ) ,
                    child:  Row(
                      children: [
                        Icon(Icons.add ,color: Colors.white,size: 15.sp,),
                        SizedBox(width: 5.w,),
                        Text("Create Contest" , style: TextStyle(color: ColorConstants.colorWhite,fontSize: 12.sp),)
                      ],
                    ),
                  )
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox()
              ),
            ],
          )
      ),
    );
  }

  showPreViewScreen(BuildContext context){
    return showMaterialModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height.h,
              color: Colors.white,
              margin: EdgeInsets.only(top: 100.h),
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
                                            width: 10.h,
                                          ),
                                          Text("Create Contest",style: TextStyle(fontSize: 12.sp,color: Colors.white,fontWeight: FontWeight.bold),),
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
                  Expanded(
                      child: BlocProvider(
                      create: (_) => ContestBloc(ContestRepository(Dio())),
                      child:BlocListener<ContestBloc,ContestState>(
                        listener: (context,state){
                          providerContext = context;
                          if(state is CreateContestCompleteState){
                            Get.to(ContestMainPage(widget.matchId.toString(),widget.name.toString(),widget.startDate.toString()));
                          }
                        },
                        child:Column(
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300.w,
                                  child:Text("Amount",style: TextStyle(fontSize: 12.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 40.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 1.5.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.w,),
                                        Expanded(
                                            child: TextFormField(
                                                controller: amountController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  errorMaxLines: 1,
                                                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  setState((){
                                                    if(amountController.text != "" && maxTeamsController.text != ""){
                                                      var prize = double.parse(amountController.text) * double.parse(maxTeamsController.text);
                                                      prizeController = new TextEditingController(text: prize.toString());
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
                            SizedBox(
                              height: 15.h,
                            ),
                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300.w,
                                  child:Text("Disable Amount",style: TextStyle(fontSize: 12.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 40.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 1.5.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.w,),
                                        Expanded(
                                            child: TextFormField(
                                                controller: disableamountController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  errorMaxLines: 1,
                                                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  setState((){

                                                  });
                                                }
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),*/
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300.w,
                                  child:Text("Max teams",style: TextStyle(fontSize: 12.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 40.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 1.5.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.w,),
                                        Expanded(
                                            child: TextFormField(
                                                controller: maxTeamsController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  errorMaxLines: 1,
                                                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  setState((){
                                                    if(amountController.text != "" && maxTeamsController.text != ""){
                                                      var prize = double.parse(amountController.text) * double.parse(maxTeamsController.text);
                                                      prizeController.text = prize.toString();
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
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300.w,
                                  child:Text("Prize",style: TextStyle(fontSize: 12.sp,color: Colors.grey,fontWeight: FontWeight.bold),),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: 40.h,
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey,width: 1.5.w),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //                 <--- border radius here
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.w,),
                                        Expanded(
                                            child: TextFormField(
                                                enabled: false,
                                                controller: prizeController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  errorMaxLines: 1,
                                                  errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
                                                ),
                                                keyboardType: TextInputType.number,
                                                onChanged: (value) {
                                                  setState((){

                                                  });
                                                }
                                            )
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25.w,right: 25.w),
                              child:GestureDetector(
                                  onTap: (){

                                    String prize = prizeController.text;
                                    prize_breakup.add("{'1':'$prize'}");

                                    BlocProvider.of<ContestBloc>(providerContext!).add(CreateContestEvent(context:context,match_details:match_details,match_id:widget.matchId.toString(),amount:amountController.text,disable_amount:"0",max_winners:"1",max_teams:maxTeamsController.text,teams_joined:"0",description:"",user_id:user_id,type:"private",status:"upcoming",max_one_person_teams:"1",response:"",remarks:"",prizebreakups: prize_breakup ));
                                  },
                                  child:Container(
                                    width: 300.w,
                                    height: 40.h,
                                    padding: EdgeInsets.all(10.h),
                                    decoration: BoxDecoration(
                                        color: ColorConstants.colorLoginBtn,
                                        borderRadius: BorderRadius.circular(5.h)
                                    ),
                                    child: Center(
                                      child: Text("Add Contest",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.white,
                                          fontSize: 15.sp
                                      ),),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                  )
                  )
                ],
              )
          );
        }
    );
  }

  inviteFriends(BuildContext context,List<UserData>? usersList,String? contest_id,String? matchId,String? name,String? startDate){
    return showMaterialModalBottomSheet(
        context: context,
        elevation: 0,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height.h,
              color: Colors.white,
              margin: EdgeInsets.only(top: 100.h),
              child: BlocProvider(
                  create: (_) => ContestBloc(ContestRepository(Dio())),
                  child:BlocListener<ContestBloc,ContestState>(
                      listener: (context,state){
                        if(state is InviteUserCompleteState){
                          Get.to(ContestMainPage(widget.matchId, widget.name, widget.startDate));
                        }
                      },
                      child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate){
                          return Column(
                            children: [
                              Container(
                                height: 55.h,
                                width:MediaQuery.of(context).size.width,
                                color: Colors.black12,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 10.w,),
                                    InkWell(
                                        onTap: (){
                                          Get.back();
                                        },child: Icon(Icons.arrow_back, size: 30,)),
                                    SizedBox(width: 10.w,),
                                    Expanded(child: Container(
                                      height: 40.h,
                                      //width: 220.w,
                                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.black26, width: 2),
                                          color: Colors.white
                                      ),
                                      child: Center(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            hintText: "Search.......",
                                            hintMaxLines: 2,
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.transparent),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            serachUsersList.clear();
                                            if(value != "" && value != null){
                                              usersList!.forEach((element) {
                                                if(value.contains(element.name.toString()) || value.contains(element.phone.toString())){
                                                  mystate((){
                                                    serachUsersList.add(element);
                                                  });
                                                }
                                              });
                                              /*for(int i=0 ; i<usersList!.length ; i++){
                                                if(value.contains(usersList[i].name.toString()) || value.contains(usersList[i].phone.toString())){
                                                  mystate((){
                                                    serachUsersList.add(usersList[i]);
                                                  });
                                                }
                                              }*/
                                            }
                                            else{
                                              mystate((){
                                                serachUsersList.clear();
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),),
                                    SizedBox(width: 15.w,),
                                    InkWell(onTap: (){},child: Icon(Icons.search, size: 30,)),
                                    SizedBox(width: 10.w,),
                                  ],
                                ),
                              ),
                              Expanded(child: (serachUsersList != null && serachUsersList.length > 0) ? ListView.builder(
                                  itemCount: serachUsersList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return Card(
                                      child: Container(
                                        height: 50.h,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10.w,),
                                            (serachUsersList[index].image == "") ? Image.asset("assets/images/userprofile.png",height: 30.h,width: 30.w,) : Image.network(ApiConstants.BASE_URL+serachUsersList![index].image,height: 30.h,width: 30.w,),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text(serachUsersList[index].name,style: TextStyle(color: ColorConstants.colorBlack,fontSize: 14.sp),),),
                                            SizedBox(width: 10.w,),
                                            GestureDetector(
                                              onTap: (){
                                                BlocProvider.of<ContestBloc>(context).add(InviteForMatchEvent(context: context,contest_id: contest_id.toString(),invite_to: serachUsersList![index].id,invite_by: userDataService.userData.id));
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 30.h,
                                                padding: EdgeInsets.all(5.h),
                                                decoration: BoxDecoration(
                                                    color: ColorConstants.colorLoginBtn,
                                                    borderRadius: BorderRadius.circular(5.h)
                                                ),
                                                child: Center(
                                                  child: Text("Invite",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.white,
                                                      fontSize: 15.sp
                                                  ),),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ) : ListView.builder(
                                  itemCount: usersList!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    return Card(
                                      child: Container(
                                        height: 50.h,
                                        child: Row(
                                          children: [
                                            SizedBox(width: 10.w,),
                                            (usersList[index].image == "") ? Image.asset("assets/images/userprofile.png",height: 30.h,width: 30.w,) : Image.network(ApiConstants.BASE_URL+usersList[index].image,height: 30.h,width: 30.w,),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text(usersList[index].name,style: TextStyle(color: ColorConstants.colorBlack,fontSize: 14.sp),),),
                                            SizedBox(width: 10.w,),
                                            GestureDetector(
                                              onTap: (){
                                                BlocProvider.of<ContestBloc>(context).add(InviteForMatchEvent(context: context,contest_id: contest_id.toString(),invite_to: usersList[index].id,invite_by: userDataService.userData.id));
                                              },
                                              child: Container(
                                                width: 70.w,
                                                height: 30.h,
                                                padding: EdgeInsets.all(5.h),
                                                decoration: BoxDecoration(
                                                    color: ColorConstants.colorLoginBtn,
                                                    borderRadius: BorderRadius.circular(5.h)
                                                ),
                                                child: Center(
                                                  child: Text("Invite",style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: Colors.white,
                                                      fontSize: 15.sp
                                                  ),),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                              ))
                            ],
                          );
                        },
                      )
                  )
              )
          );
        }
    );
  }

}





class UserListDialog extends StatefulWidget {

  List<UserData>? usersList;
  String? contest_id,matchId,name,startDate;

  UserListDialog(List<UserData>? _usersList,String? _contest_id,String? _matchId,String? _name,String? _startDate){
    usersList = _usersList;
    contest_id = _contest_id;
    matchId = _matchId;
    name = _name;
    startDate = _startDate;
  }

  @override
  _UserListDialogState createState() => _UserListDialogState();
}


class _UserListDialogState extends State<UserListDialog> with SingleTickerProviderStateMixin{

  double containerHeight = 0.0;
  UserDataService userDataService = getIt<UserDataService>();

  @override
  void initState() {
    super.initState();
    setState((){
      containerHeight = widget.usersList!.length * 60;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      child: Container(
        height: containerHeight.h,
        child:  Padding(
            padding:  EdgeInsets.all(12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocProvider(
                  create: (_) => ContestBloc(ContestRepository(Dio())),
                  child:BlocListener<ContestBloc,ContestState>(
                      listener: (context,state){
                        if(state is InviteUserCompleteState){
                          Get.back();
                          Get.to(ContestMainPage(widget.matchId, widget.name, widget.startDate));
                        }
                      },
                      child: ListView.builder(
                          itemCount: widget.usersList!.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            return Card(
                              child: Container(
                                height: 50.h,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10.w,),
                                    (widget.usersList![index].image == "") ? Image.asset("assets/images/userprofile.png",height: 30.h,width: 30.w,) : Image.network(ApiConstants.BASE_URL+widget.usersList![index].image,height: 30.h,width: 30.w,),
                                    SizedBox(width: 10.w,),
                                    Expanded(child: Text(widget.usersList![index].name,style: TextStyle(color: ColorConstants.colorBlack,fontSize: 14.sp),),),
                                    SizedBox(width: 10.w,),
                                    GestureDetector(
                                      onTap: (){
                                        BlocProvider.of<ContestBloc>(context).add(InviteForMatchEvent(context: context,contest_id: widget.contest_id.toString(),invite_to: widget.usersList![index].id,invite_by: userDataService.userData.id));
                                      },
                                      child: Container(
                                        width: 70.w,
                                        height: 30.h,
                                        padding: EdgeInsets.all(5.h),
                                        decoration: BoxDecoration(
                                            color: ColorConstants.colorLoginBtn,
                                            borderRadius: BorderRadius.circular(5.h)
                                        ),
                                        child: Center(
                                          child: Text("Invite",style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.white,
                                              fontSize: 15.sp
                                          ),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w,),
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                  )
                )
              ],
            ),
          ),)
    );
  }



}









