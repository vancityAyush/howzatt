import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/WalletBloc/WalletBloc.dart';
import 'package:howzatt/Repository/MatchRepository.dart';
import 'package:howzatt/Repository/WalletRepository.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/utils/ApiConstants.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import '../../../Bloc/MatchBloc/MatchBloc.dart';

class CaptainAndViceCaptain extends StatelessWidget {

  String? startDate,amount,teamName,contest_id,name,matchId,userid,username,team1,team2,team1Count,team2Count,credit_left;
  List<PlayerData>? playerList;

  CaptainAndViceCaptain(String? _startDate,String? _amount,String? _teamName,String? _contest_id,String? _name,List<PlayerData>? _playerList,String _matchId,String _userid,String _username,String _team1,String _team2,String _team1Count,String _team2Count,String _credit_left){
    startDate = _startDate;
    amount = _amount;
    teamName = _teamName;
    contest_id = _contest_id;
    name = _name;
    playerList = _playerList;
    matchId = _matchId;
    userid = _userid;
    username = _username;
    team1 = _team1;
    team2 = _team2;
    team1Count = _team1Count;
    team2Count = _team2Count;
    credit_left = _credit_left;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => MatchBloc(MatchRepository(Dio())),
            ),
            BlocProvider(
              create: (_) => WalletBloc(WalletRepository(Dio())),
            ),
          ],
          child: CaptainAndViceCaptainStateful(startDate,amount,teamName,name,contest_id,playerList,matchId,userid,username,team1,team2,team1Count,team2Count,credit_left),
        )
    );
  }
}



class CaptainAndViceCaptainStateful extends StatefulWidget {
  String? startDate,amount,teamName,name,contest_id,matchId,userid,username,team1,team2,team1Count,team2Count,credit_left;
  List<PlayerData>? playerList;

  CaptainAndViceCaptainStateful(String? _startDate,String? _amount,String? _teamName,String? _name,String? _contest_id,List<PlayerData>? _playerList,String? _matchId,String? _userid,String? _username,String? _team1,String? _team2,String? _team1Count,String? _team2Count,String? _credit_left){
    startDate = _startDate;
    amount = _amount;
    teamName = _teamName;
    name = _name;
    contest_id = _contest_id;
    playerList = _playerList;
    matchId = _matchId;
    userid = _userid;
    username = _username;
    team1 = _team1;
    team2 = _team2;
    team1Count = _team1Count;
    team2Count = _team2Count;
    credit_left = _credit_left;
  }

  @override
  _CaptainAndViceCaptainState createState() => _CaptainAndViceCaptainState();
}


class _CaptainAndViceCaptainState extends State<CaptainAndViceCaptainStateful> with SingleTickerProviderStateMixin{

  List<int> listInt = [1,2,3,4,5];
  int _current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;
  int endTime = 0;
  bool isCaptain = true , isViceCaptain = true;
  List<PlayerData>? playerList;

  //
  String mid = "", orderId = "", amounts = "", txnToken = "";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = false;
  UserDataService userDataService =  getIt<UserDataService>();

  //
  String? payment_response;

  //Live
  String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
  String website = "DEFAULT";
  bool testing = false;

  //Testing
  // String mid = "TEST_MID_HERE";
  // String PAYTM_MERCHANT_KEY = "TEST_KEY_HERE";
  // String website = "WEBSTAGING";
  // bool testing = true;

  double amount = 1;
  bool loading = false;
  String totalWalletAmount = "" , bonusWalletAmount = "";

  bool captainSelect = false ,  viceCaptainSelect = false , transactionDo = false;
  List<PlayerData> wKplayerList = List.empty(growable: true);
  List<PlayerData> batplayerList = List.empty(growable: true);
  List<PlayerData> allrplayerList = List.empty(growable: true);
  List<PlayerData> bowlplayerList = List.empty(growable: true);
  int wkAdd = 0 , batAdd = 0 , arAdd = 0 , bowlAdd = 0;
  late BuildContext dialogContext,matchContext;

  @override
  void initState() {
    _controller = new TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
    BlocProvider.of<WalletBloc>(context).add(GetWalletEvent(context: context));
    var startDate = widget.startDate!.split("T");
    var time = startDate[1].split("+");
    endTime = DateTime.parse(startDate[0].toString()+" "+time[0]+":00").millisecondsSinceEpoch + 1000 * 30;

    playerList = widget.playerList;
    orderId = DateTime.now().millisecondsSinceEpoch.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(115.h),
        child: Column(
          children: [
            Container(
                color: Colors.black,
                height: 130.h,
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
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                            Text(" left ",style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: Colors.white,
                                                fontSize: 12.sp
                                            ),)
                                          ],
                                        )
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Choose your Captain and Vice Captain',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 15.sp
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'C gets 2x points,VC gets 1.5x points',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.grey,
                                  fontSize: 14.sp
                              ),
                            ),
                          ],
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
      body: Column(
        children: [
          Container(
            height: 22.h,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("TYPE",style: TextStyle(
                          fontFamily: 'RoMedium',
                          color: ColorConstants.colorBlackHint,
                          fontSize: 12.sp,
                        ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset('assets/images/downarrowtwo.png', width: 10.w ,height: 20.h),
                      ],
                    )
                ),
                Expanded(
                    flex:1,
                    child: Center(
                      child: Text("POINTS",style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: ColorConstants.colorBlackHint,
                        fontSize: 12.sp,
                      ),
                        textAlign: TextAlign.center,
                      ),
                    )
                ),
                Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("% C BY",style: TextStyle(
                          fontFamily: 'RoMedium',
                          color: ColorConstants.colorBlackHint,
                          fontSize: 12.sp,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                ),
                Expanded(
                    flex:1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("% VC BY",style: TextStyle(
                          fontFamily: 'RoMedium',
                          color: ColorConstants.colorBlackHint,
                          fontSize: 12.sp,
                        ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          BlocListener<WalletBloc,WalletState>(
              listener: (context,state){
                setState((){
                  dialogContext =  context ;
                });
                if(state is GetWalletCompleteState)
                {
                  setState((){
                    totalWalletAmount = state.totalWalletAmount;
                    bonusWalletAmount = state.serverResponse["bonus_wallet_sum"].toString();
                  });
                }
                if(state is AddWalletCompleteState){
                  var remainingAmount = 0.0 , bonusAmountWallets = 0.0 , actualWalletAmount = 0.0;
                  if(double.parse(widget.amount.toString()) > 0.0){
                    bonusAmountWallets = (double.parse(widget.amount.toString()) * 10)/100;
                  }
                  if(double.parse(widget.amount.toString()) > 0.0){
                    actualWalletAmount = (double.parse(widget.amount.toString()) * 90)/100;
                  }
                  if(actualWalletAmount <= double.parse(totalWalletAmount) && bonusAmountWallets <= double.parse(bonusWalletAmount)){
                    BlocProvider.of<MatchBloc>(context).add(SaveTeamEvent(context: context,matchId:widget.matchId.toString(),contest_id:widget.contest_id.toString(),teamName:widget.teamName.toString(),user_id:widget.userid.toString(),user_name:widget.username.toString(),team1:widget.team1.toString(),team2: widget.team2.toString(),team1Count: widget.team1Count.toString(),team2Count: widget.team2Count.toString(),playerList: playerList,total_credit: "100",credit_left: widget.credit_left.toString()));
                  }
                  else if (double.parse(widget.amount.toString()) <= double.parse(totalWalletAmount)){
                    BlocProvider.of<MatchBloc>(context).add(SaveTeamEvent(context: context,matchId:widget.matchId.toString(),contest_id:widget.contest_id.toString(),teamName:widget.teamName.toString(),user_id:widget.userid.toString(),user_name:widget.username.toString(),team1:widget.team1.toString(),team2: widget.team2.toString(),team1Count: widget.team1Count.toString(),team2Count: widget.team2Count.toString(),playerList: playerList,total_credit: "100",credit_left: widget.credit_left.toString()));
                  }
                  else if(bonusAmountWallets <=  double.parse(bonusWalletAmount) && actualWalletAmount > double.parse(totalWalletAmount)){
                    makePayment(actualWalletAmount.toString(),state.cftoken.toString(),state.orderId.toString());
                  }
                  else if(bonusAmountWallets > double.parse(bonusWalletAmount) && double.parse(totalWalletAmount) < double.parse(widget.amount.toString())){
                    makePayment(widget.amount.toString(),state.cftoken.toString(),state.orderId.toString());
                  }
                }
                if(state is AddBonusWalletWalletCompleteState){
                  var actualWalletAmount = 0.0;
                  if(double.parse(totalWalletAmount.toString()) > 0.0){
                    actualWalletAmount = (double.parse(widget.amount.toString()) * 90)/100;
                    BlocProvider.of<WalletBloc>(context).add(AddWalletEvent(context: context,amount: "-"+actualWalletAmount.toString(),type: "debit",status: "completed",user_id:userDataService.userData.id.toString(),isFromSuccess:false));
                  }
                }
                if(state is UpdateWalletCompleteState){
                  if(state.isFromSuccess == true)
                  {
                    BlocProvider.of<MatchBloc>(matchContext).add(SaveTeamEvent(context: context,matchId:widget.matchId.toString(),contest_id:widget.contest_id.toString(),teamName:widget.teamName.toString(),user_id:widget.userid.toString(),user_name:widget.username.toString(),team1:widget.team1.toString(),team2: widget.team2.toString(),team1Count: widget.team1Count.toString(),team2Count: widget.team2Count.toString(),playerList: playerList,total_credit: "100",credit_left: widget.credit_left.toString()));
                  }
                }
              },
              child: SizedBox()
          ),
          Expanded(child:  BlocBuilder<MatchBloc,MatchState>(
            builder: (context,state){
              matchContext = context;
              if(state is CreateTeamCompleteState){
                WidgetsBinding.instance.addPostFrameCallback((_){
                  Get.to(ContestMainPage(widget.matchId,widget.name,widget.startDate));
                });
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: playerList!.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 0.2.sp,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 5.h,bottom: 5.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex:1,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 5.w,),
                                              (playerList![index].position == "WK") ? Image.asset('assets/images/wicketkeeper.png', width: 50.w ,height: 35.h):SizedBox(),
                                              (playerList![index].position == "BAT") ? Image.asset('assets/images/batsman.png', width: 50.w ,height: 35.h):SizedBox(),
                                              (playerList![index].position == "ALL-R") ? Image.asset('assets/images/allrounder.png', width: 50.w ,height: 35.h):SizedBox(),
                                              (playerList![index].position == "BOWL") ? Image.asset('assets/images/bowler.png', width: 50.w ,height: 35.h):SizedBox(),
                                            ],
                                          )
                                      ),
                                      Expanded(
                                        flex:1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(child: Text(playerList![index].name.toString(),style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.black,
                                                  fontSize: 12.sp,
                                                ),
                                                  textAlign: TextAlign.start,
                                                ),)
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(playerList![index].pre_cp.toString(),style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.grey,
                                                  fontSize: 12.sp,
                                                ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex:1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    for(int i=0 ; i<playerList!.length ; i++){
                                                      playerList![i].captain = "1";
                                                    }
                                                    if(playerList![index].captain == "1"){
                                                      playerList![index].captain = "2";
                                                    }
                                                    else{
                                                      playerList![index].captain = "1";
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    height:30.h,
                                                    width: 35.w,
                                                    margin: EdgeInsets.all(5.h),
                                                    decoration: BoxDecoration(
                                                      color: (playerList![index].captain == "2") ? Colors.black : Colors.transparent,
                                                      borderRadius: new BorderRadius.all(Radius.circular(30.h)),
                                                      border: Border(
                                                        left: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        right: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        top: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        bottom: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                      ),
                                                    ),
                                                    child:Center(
                                                      child: (playerList![index].captain == "2") ? Text("2X",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: (playerList![index].captain == "2") ?  Colors.white : ColorConstants.colorBlackHint,
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                        textAlign: TextAlign.center,
                                                      ) : Text("C",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.grey,
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                      Expanded(
                                          flex:1,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    for(int i=0 ; i<playerList!.length ; i++){
                                                      playerList![i].vc = "1";
                                                    }
                                                    if(playerList![index].vc == "1"){
                                                      playerList![index].vc = "1.5";
                                                    }
                                                    else{
                                                      playerList![index].vc = "1";
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                    height:30.h,
                                                    width: 35.w,
                                                    margin: EdgeInsets.all(5.h),
                                                    decoration: BoxDecoration(
                                                      color: (playerList![index].vc == "1.5") ? Colors.black : Colors.transparent,
                                                      borderRadius: new BorderRadius.all(Radius.circular(30.h)),
                                                      border: Border(
                                                        left: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        right: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        top: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                        bottom: BorderSide(
                                                          color: Colors.grey,
                                                          width: 0.8,
                                                        ),
                                                      ),
                                                    ),
                                                    child:Center(
                                                      child: (playerList![index].vc == "1.5") ? Text("1.5X",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: (playerList![index].vc == "1.5") ?  Colors.white : ColorConstants.colorBlackHint,
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                        textAlign: TextAlign.center,
                                                      ) : Text("VC",style: TextStyle(
                                                          fontFamily: 'RoMedium',
                                                          color: Colors.grey,
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                ),
                                              )
                                              /*Text("3.52%",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                      textAlign: TextAlign.center,
                                    ),*/
                                            ],
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 0.2.sp,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          );
                        }
                    ),),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h , bottom: 8.h , left: 10.h , right: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            showPreViewScreen(context);
                          },
                          child:Container(
                            width: 120.w,
                            height:30.h,
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                              //color: ColorConstants.colorLoginBtn,
                              borderRadius: BorderRadius.circular(10.h),
                              border: Border(
                                left: BorderSide(
                                  color: Colors.grey,
                                  width: 0.8,
                                ),
                                right: BorderSide(
                                  color: Colors.grey,
                                  width: 0.8,
                                ),
                                top: BorderSide(
                                  color: Colors.grey,
                                  width: 0.8,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 0.8,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text("Team Preview",style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  color: Colors.black,
                                  fontSize: 12.sp
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        GestureDetector(
                          onTap: (){
                            selectCaptainViceCaptain(playerList);
                            if(captainSelect == true && viceCaptainSelect == true){
                              if(double.parse(widget.amount.toString()) <= double.parse(totalWalletAmount.toString())){
                                var remainingAmount = 0.0 , bonusAmountWallets = 0.0 , actualWalletAmount = 0.0;
                                /*if(double.parse(bonusWalletAmount.toString()) > 0.0){
                                  bonusAmountWallets = (double.parse(widget.amount.toString()) * 10)/100;
                                  BlocProvider.of<WalletBloc>(context).add(AddBonusWalletEvent(context: context,amount: "-"+bonusAmountWallets.toString(),type: "debit",status: "completed",user_id:userDataService.userData.id.toString(),isFromSuccess:false,remarks: "BONUS"));
                                }
                                else {*/
                                  BlocProvider.of<WalletBloc>(context).add(
                                      AddWalletEvent(context: context,
                                          amount: "-" +
                                              widget.amount.toString(),
                                          type: "debit",
                                          status: "completed",
                                          user_id: userDataService.userData.id
                                              .toString(),
                                          isFromSuccess: false));
                                //}
                              }
                              else{
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
                                                height: 20.h,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 10.h,
                                                  ),
                                                  Text("Low Balance" , style: TextStyle(fontSize: 18.sp,color: Colors.black87,fontWeight: FontWeight.bold),)
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
                                                  Expanded(child: Text("Wallet Amount" , style: TextStyle(fontSize: 15.sp,color: Colors.black87,fontWeight: FontWeight.bold),)),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 3.h),
                                                    child:Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,color: Colors.green,),
                                                  ),
                                                  SizedBox(
                                                    width: 3.h,
                                                  ),
                                                  Text(totalWalletAmount.toString(),style: TextStyle(
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
                                                  Expanded(child: Text("Entry Amount" , style: TextStyle(fontSize: 15.sp,color: Colors.black87,fontWeight: FontWeight.bold),)),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 3.h),
                                                    child:Image.asset("assets/images/rupee_indian.png",height: 12.h,width: 12.w,color: Colors.green,),
                                                  ),
                                                  SizedBox(
                                                    width: 3.h,
                                                  ),
                                                  Text(widget.amount.toString(),style: TextStyle(
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
                                              GestureDetector(
                                                onTap: (){
                                                  setState((){
                                                    transactionDo = true;
                                                  });
                                                  Get.back();
                                                  BlocProvider.of<WalletBloc>(dialogContext).add(AddWalletEvent(context: context,amount: widget.amount.toString(),type: "debit",status: "completed",user_id:userDataService.userData.id.toString(),isFromSuccess:false));
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
                            }
                            else{
                              DialogUtil.showInfoDialog("Info", "Please Select Captain and ViceCaptain.", context);
                            }
                          },
                          child: Container(
                            width: 120.w,
                            height:30.h,
                            padding: EdgeInsets.all(5.h),
                            decoration: BoxDecoration(
                                color: ColorConstants.colorGreenBtn,
                                borderRadius: BorderRadius.circular(10.h)
                            ),
                            child: Center(
                              child: Text("Save Team",style: TextStyle(
                                  fontFamily: 'RoThin',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12.sp
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),)
        ],
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  showPreViewScreen(BuildContext context){
    wkAdd = 0 ; batAdd = 0 ; arAdd = 0 ; bowlAdd = 0;
    wKplayerList.clear();
    batplayerList.clear();
    allrplayerList.clear();
    bowlplayerList.clear();
    for(int i=0 ; i<playerList!.length ; i++){
      if(playerList![i].position == "WK"){
        wKplayerList.add(playerList![i]);
        wkAdd = wkAdd + 1;
      }
      else if(playerList![i].position == "BAT"){
        batplayerList.add(playerList![i]);
        batAdd = batAdd + 1;
      }
      else if(playerList![i].position == "ALL-R"){
        allrplayerList.add(playerList![i]);
        arAdd = arAdd + 1;
      }
      else if(playerList![i].position == "BOWL"){
        bowlplayerList.add(playerList![i]);
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
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CountdownTimer(
                                                endTime: endTime,
                                                widgetBuilder: (context,time){
                                                  if (time == null) {
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
                                              Text(" left ",style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),)
                                            ],
                                          )
                                        ],
                                      )
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
                                          Text((int.parse(widget.team1Count.toString()) + int.parse(widget.team2Count.toString())).toString()+"/11",style: TextStyle(
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
                                    Text(widget.team1.toString(),style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                    SizedBox(width:35.h),
                                    Text(widget.team1Count.toString(),style: TextStyle(
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
                                    Text(widget.team2.toString(),style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp
                                    ),),
                                    SizedBox(width:35.h),
                                    Text(widget.team2Count.toString(),style: TextStyle(
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
                                          Text(widget.credit_left.toString(),style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp
                                          ),),
                                        ],
                                      )
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

  void selectCaptainViceCaptain(List<PlayerData>? playerList) {
     for(int i=0 ; i<playerList!.length ; i++){
       if(playerList[i].captain == "2"){
         setState((){
           captainSelect = true;
         });
       }
       if(playerList[i].vc == "1.5"){
         setState((){
           viceCaptainSelect = true;
         });
       }
     }
  }

  makePayment(String? amount, String cftToken,String _orderId) {
    //Replace with actual values
    String orderId = _orderId;
    String stage = "PROD";
    String orderAmount = amount.toString();
    String tokenData = cftToken.toString();
    String customerName = userDataService.userData.name.toString();
    String orderNote = "";
    String orderCurrency = "INR";
    String appId = "22283969a8f73327171ec3ae89938222";
    String customerPhone = userDataService.userData.phone.toString();
    String customerEmail = userDataService.userData.email.toString();
    String notifyUrl = "https://api.cashfree.com/api/v2/cftoken/order";

    Map<String, dynamic> inputParams = {
      "orderId": orderId.toString(),
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    BlocProvider.of<WalletBloc>(dialogContext).add(UpdateWallet(context: context,status: "completed",response:"success",orderId:orderId.toString(),isFromSuccess:true));

    /*CashfreePGSDK.doPayment(inputParams).then((value){
      print("value====>>>"+value.toString());
      if(value!["txStatus"].toString() == "CANCELLED"){
        Fluttertoast.showToast(
            msg: value["txMsg"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        BlocProvider.of<WalletBloc>(dialogContext).add(UpdateWallet(context: context,status: "pending",response:value["txMsg"].toString(),orderId:orderId.toString(),isFromSuccess:false));
      }
      else if(value["txStatus"].toString() == "SUCCESS"){
        Fluttertoast.showToast(
            msg: value["txMsg"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        BlocProvider.of<WalletBloc>(dialogContext).add(UpdateWallet(context: context,status: "pending",response:value["txMsg"].toString(),orderId:orderId.toString(),isFromSuccess:true));
        //Get.to(MyWallet());
      }
      else if(value["txStatus"].toString() == "FAILED"){
        Fluttertoast.showToast(
            msg: value["txMsg"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        BlocProvider.of<WalletBloc>(dialogContext).add(UpdateWallet(context: context,status: "pending",response:value["txMsg"].toString(),orderId:orderId.toString(),isFromSuccess:false));
       // BlocProvider.of<MatchBloc>(matchContext).add(SaveTeamEvent(context: context,matchId:widget.matchId.toString(),contest_id:widget.contest_id.toString(),teamName:widget.teamName.toString(),user_id:widget.userid.toString(),user_name:widget.username.toString(),team1:widget.team1.toString(),team2: widget.team2.toString(),team1Count: widget.team1Count.toString(),team2Count: widget.team2Count.toString(),playerList: playerList,total_credit: "100",credit_left: widget.credit_left.toString()));
        //Get.to(MyWallet());
      }
    });*/
  }


}













