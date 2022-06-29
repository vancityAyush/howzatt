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
import 'package:howzatt/ui/DashBoard/MyMatches/CaptainAndVicecaptain.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/Dialogs/DialogUtil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../Bloc/MatchBloc/MatchBloc.dart';

class MyMatchesMain extends StatelessWidget {
  String? matchId, amount, contest_id, name, startDate;

  MyMatchesMain(String? _matchId, String? _amount, String? _contest_id,
      String? _name, String? _startDate) {
    matchId = _matchId;
    amount = _amount;
    contest_id = _contest_id;
    name = _name;
    startDate = _startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MatchBloc(MatchRepository(Dio())),
        ),
      ],
      child:
          MyMatchesMainStateful(matchId, amount, contest_id, name, startDate),
    ));
  }
}

class MyMatchesMainStateful extends StatefulWidget {
  String? matchId, amount, contest_id, name, startDate;

  MyMatchesMainStateful(String? _matchId, String? _amount, String? _contest_id,
      String? _name, String? _startDate) {
    matchId = _matchId;
    amount = _amount;
    contest_id = _contest_id;
    name = _name;
    startDate = _startDate;
  }

  @override
  _MyMatchesMainState createState() => _MyMatchesMainState();
}

class _MyMatchesMainState extends State<MyMatchesMainStateful>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;
  Map<String, dynamic>? serverResponse;
  double sumPoints = 0;
  int wkCount = 0, batCount = 0, arCount = 0, bowlCount = 0;
  int playersCount = 0;
  double creditsLeft = 100.0;
  List<PlayerData> playerList = List.empty(growable: true);
  PlayerData? playerData;
  List<String> stringList = List.empty(growable: true);
  int wkAdd = 0, batAdd = 0, arAdd = 0, bowlAdd = 0;
  String validationString = "Select 1-4 Wicket-Keepers";
  int endTime = 0;
  var teamsArrayName;
  int team1Count = 0, team2Count = 0;
  UserDataService userDataService = getIt<UserDataService>();
  String teamName = "Preview";
  List<PlayerData> wKplayerList = List.empty(growable: true);
  List<PlayerData> batplayerList = List.empty(growable: true);
  List<PlayerData> allrplayerList = List.empty(growable: true);
  List<PlayerData> bowlplayerList = List.empty(growable: true);

  @override
  void initState() {
    _controller = new TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
        if (_selectedIndex == 0) {
          validationString = "Select 1-4 Wicket-Keepers";
        } else if (_selectedIndex == 1) {
          validationString = "Select 3-6 Batters";
        } else if (_selectedIndex == 2) {
          validationString = "Select 1-4 All-Rounders";
        } else if (_selectedIndex == 3) {
          validationString = "Select 3-6 Bowlers";
        }
      });
    });

    teamsArrayName = widget.name!.split("vs");
    DateTime dateTime = DateTime.parse(widget.startDate.toString());
    endTime = dateTime.toLocal().millisecondsSinceEpoch + 1000 * 30;

    BlocProvider.of<MatchBloc>(context).add(FetchMatchEvent(
        context: context, matchId: widget.matchId.toString(), accessToken: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(280.h),
        child: Column(
          children: [
            Container(
                color: Colors.black,
                height: 190.h,
                child: Padding(
                    padding: EdgeInsets.only(top: 35.h, bottom: 0.h),
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {},
                                          child: Text(
                                            teamName,
                                            style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: Colors.white,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CountdownTimer(
                                          endTime: endTime,
                                          widgetBuilder: (context, time) {
                                            if (time == null) {
                                              return Text('');
                                            }
                                            return Row(
                                              children: [
                                                (time.days != null)
                                                    ? Text(
                                                        time.days.toString() +
                                                            " days ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RoMedium',
                                                            color: Colors.white,
                                                            fontSize: 12.sp),
                                                      )
                                                    : SizedBox(),
                                                (time.hours != null)
                                                    ? Text(
                                                        time.hours.toString() +
                                                            " hrs ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RoMedium',
                                                            color: Colors.white,
                                                            fontSize: 12.sp),
                                                      )
                                                    : SizedBox(),
                                                (time.min != null)
                                                    ? Text(
                                                        time.min.toString() +
                                                            " min ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RoMedium',
                                                            color: Colors.white,
                                                            fontSize: 12.sp),
                                                      )
                                                    : SizedBox(),
                                                (time.sec != null)
                                                    ? Text(
                                                        time.sec.toString() +
                                                            " sec",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'RoMedium',
                                                            color: Colors.white,
                                                            fontSize: 12.sp),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            );
                                            // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                          },
                                        ),
                                        Text(
                                          " left ",
                                          style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.white,
                                              fontSize: 12.sp),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Max 7 players from a team',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontFamily: 'RoMedium',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width / 4 -
                                    10.w,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Players",
                                          style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          playersCount.toString() + "/11",
                                          style: TextStyle(
                                            fontFamily: 'RoMedium',
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.h),
                                  Text(
                                    teamsArrayName[0].toString(),
                                    style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(width: 35.h),
                                  Text(
                                    "$team1Count",
                                    style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.h),
                                  Text(
                                    teamsArrayName[1].toString(),
                                    style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(width: 35.h),
                                  Text(
                                    "$team2Count",
                                    style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.sp),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Credits Left",
                                          style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "$creditsLeft",
                                          style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Container(
                          height: 15.h,
                          child: ListView.builder(
                              itemCount: 11,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 25.w,
                                  height: 10.h,
                                  margin:
                                      EdgeInsets.only(left: 2.w, right: 2.w),
                                  padding: EdgeInsets.all(1.h),
                                  decoration: BoxDecoration(
                                      color: (playersCount != 0 &&
                                              index < playersCount)
                                          ? Colors.green
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(1.h)),
                                  child: Center(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.white,
                                          fontSize: 15.sp),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ))),
            SizedBox(
              height: 5.h,
            ),
            TabBar(
              controller: _controller,
              indicatorColor: Colors.deepOrange,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              indicatorWeight: 5,
              labelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              tabs: [
                Tab(text: "WK($wkCount)"),
                Tab(text: "BAT($batCount)"),
                Tab(text: "AR($arCount)"),
                Tab(text: "BOWL($bowlCount)"),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 22.h,
              decoration: BoxDecoration(
                color: ColorConstants.colorhintText,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Text(
                      validationString,
                      style: TextStyle(
                        fontFamily: 'RoMedium',
                        color: ColorConstants.colorBlackHint,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  Image.asset('assets/images/tshirt.png',
                      width: 22.w, height: 22.h),
                  SizedBox(
                    width: 10.w,
                  ),
                  Image.asset('assets/images/filter.png',
                      width: 15.w, height: 15.h),
                  SizedBox(
                    width: 20.w,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "",
                          style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: ColorConstants.colorBlackHint,
                            fontSize: 15.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          "SELECTED BY",
                          style: TextStyle(
                            fontFamily: 'RoMedium',
                            color: ColorConstants.colorBlackHint,
                            fontSize: 12.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "POINTS",
                            style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: ColorConstants.colorBlackHint,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "CREDITS",
                            style: TextStyle(
                              fontFamily: 'RoMedium',
                              color: ColorConstants.colorBlackHint,
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Image.asset('assets/images/downarrowtwo.png',
                              width: 10.w, height: 20.h),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
      body: BlocListener<MatchBloc, MatchState>(
        listener: (context, state) {
          if (state is MatchCompleteState) {
            setState(() {
              serverResponse = state.serverResponse;
              getCounts(serverResponse);
            });
          }
        },
        child: TabBarView(
          controller: _controller,
          children: <Widget>[
            (serverResponse != null)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: serverResponse!["wk"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      sumPoints = 0;
                      serverResponse!["wk"][index]["previous_points"]
                          .forEach((element) {
                        sumPoints = sumPoints +
                            double.parse(element["points"].toString());
                      });
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String previousPoints = (serverResponse!["wk"]
                                            [index]["previous_points"] !=
                                        null &&
                                    serverResponse!["wk"][index]
                                                ["previous_points"]
                                            .length >
                                        0)
                                ? serverResponse!["wk"][index]
                                        ["previous_points"][0]["points"]
                                    .toString()
                                : "0";
                            playerData = new PlayerData(
                                serverResponse!["wk"][index]["player_details"]
                                        ["fullname"]
                                    .toString(),
                                previousPoints.toString(),
                                "WK",
                                serverResponse!["wk"][index]["team"]
                                        ["short_name"]
                                    .toString(),
                                serverResponse!["wk"][index]["played_id"]
                                    .toString(),
                                "1",
                                "IN",
                                "1",
                                "1");
                            if (stringList.contains(serverResponse!["wk"][index]
                                    ["played_id"]
                                .toString())) {
                              creditsLeft = creditsLeft +
                                  double.parse(serverResponse!["wk"][index]
                                          ["credit_value"]
                                      .toString());
                              stringList.remove(serverResponse!["wk"][index]
                                      ["played_id"]
                                  .toString());
                              playerList.removeWhere((item) =>
                                  item.id ==
                                  serverResponse!["wk"][index]["played_id"]
                                      .toString());
                              //playerList.remove(playerData!);

                              wkAdd = wkAdd - 1;
                              playersCount = playersCount - 1;
                              if (teamsArrayName[0].toString().trim() ==
                                  serverResponse!["wk"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                setState(() {
                                  team1Count = team1Count - 1;
                                });
                              } else if (teamsArrayName[1].toString().trim() ==
                                  serverResponse!["wk"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                setState(() {
                                  team2Count = team2Count - 1;
                                });
                              }
                            } else if (wkAdd < 4 && playersCount < 11) {
                              if (creditsLeft >=
                                  double.parse(serverResponse!["wk"][index]
                                          ["credit_value"]
                                      .toString())) {
                                creditsLeft = creditsLeft -
                                    double.parse(serverResponse!["wk"][index]
                                            ["credit_value"]
                                        .toString());
                                stringList.add(serverResponse!["wk"][index]
                                        ["played_id"]
                                    .toString());
                                playerList.add(playerData!);
                                wkAdd = wkAdd + 1;
                                playersCount = playersCount + 1;
                                if (teamsArrayName[0].toString().trim() ==
                                    serverResponse!["wk"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  setState(() {
                                    team1Count = team1Count + 1;
                                  });
                                } else if (teamsArrayName[1]
                                        .toString()
                                        .trim() ==
                                    serverResponse!["wk"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  setState(() {
                                    team2Count = team2Count + 1;
                                  });
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Credit points are Low.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstants.colorBlack,
                                    textColor: ColorConstants.colorBtnOne,
                                    fontSize: 16.0);
                              }
                            } else if (wkAdd >= 4) {
                              Fluttertoast.showToast(
                                  msg: "you can select only 4 wicket keeprers.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstants.colorBlack,
                                  textColor: ColorConstants.colorBtnOne,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: Container(
                            color: (stringList.contains(serverResponse!["wk"]
                                        [index]["played_id"]
                                    .toString()))
                                ? ColorConstants.colorPinkHints
                                : Colors.transparent,
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width.w,
                                  height: 0.2.sp,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10.w,
                                      right: 10.w,
                                      top: 10.h,
                                      bottom: 10.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Image.asset(
                                                  'assets/images/wicketkeeper.png',
                                                  width: 50.w,
                                                  height: 35.h),
                                            ],
                                          )),
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  serverResponse!["wk"][index]
                                                              ["player_details"]
                                                          ["fullname"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            /*Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Sel by 97.18%",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Container(
                                                width: 7.w,
                                                height: 7.h,
                                                child:Text(""),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorConstants.colorBlack,)
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 4.w,),
                                        Text("Played Last Match",style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: ColorConstants.colorLoginBtn,
                                          fontSize: 12.sp,
                                        ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    )*/
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              sumPoints.toString(),
                                              style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: ColorConstants
                                                    .colorBlackHint,
                                                fontSize: 12.sp,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Center(
                                                child: Text(
                                                  serverResponse!["wk"][index]
                                                          ["credit_value"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: ColorConstants
                                                        .colorBlackHint,
                                                    fontSize: 12.sp,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              ),
                                              (stringList.contains(
                                                      serverResponse!["wk"]
                                                                  [index]
                                                              ["played_id"]
                                                          .toString()))
                                                  ? Image.asset(
                                                      'assets/images/minus.png',
                                                      width: 25.w,
                                                      height: 25.h)
                                                  : Image.asset(
                                                      'assets/images/add.png',
                                                      width: 25.w,
                                                      height: 25.h),
                                            ],
                                          )),
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
                          ),
                        ),
                      );
                    })
                : SizedBox(),
            (serverResponse != null)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: serverResponse!["bat"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      sumPoints = 0;
                      serverResponse!["bat"][index]["previous_points"]
                          .forEach((element) {
                        sumPoints = sumPoints +
                            double.parse(element["points"].toString());
                      });
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String previousPoints = (serverResponse!["bat"]
                                            [index]["previous_points"] !=
                                        null &&
                                    serverResponse!["bat"][index]
                                                ["previous_points"]
                                            .length >
                                        0)
                                ? serverResponse!["bat"][index]
                                        ["previous_points"][0]["points"]
                                    .toString()
                                : "0";
                            playerData = new PlayerData(
                                serverResponse!["bat"][index]["player_details"]
                                        ["fullname"]
                                    .toString(),
                                previousPoints.toString(),
                                "BAT",
                                serverResponse!["bat"][index]["team"]
                                        ["short_name"]
                                    .toString(),
                                serverResponse!["bat"][index]["played_id"]
                                    .toString(),
                                "1",
                                "IN",
                                "1",
                                "1");
                            if (arAdd == 0 && playersCount > 6) {
                              validationString =
                                  "You must select Atleast 1 All rounder";
                            } else if (stringList.contains(
                                serverResponse!["bat"][index]["played_id"]
                                    .toString())) {
                              creditsLeft = creditsLeft +
                                  double.parse(serverResponse!["bat"][index]
                                          ["credit_value"]
                                      .toString());
                              stringList.remove(serverResponse!["bat"][index]
                                      ["played_id"]
                                  .toString());
                              playerList.removeWhere((item) =>
                                  item.id ==
                                  serverResponse!["bat"][index]["played_id"]
                                      .toString());
                              //playerList.remove(playerData!);
                              batAdd = batAdd - 1;
                              playersCount = playersCount - 1;
                              if (teamsArrayName[0].toString().trim() ==
                                  serverResponse!["bat"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team1Count = team1Count - 1;
                              } else if (teamsArrayName[1].toString().trim() ==
                                  serverResponse!["bat"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team2Count = team2Count - 1;
                              }
                            } else if (batAdd < 6) {
                              if (creditsLeft >=
                                  double.parse(serverResponse!["bat"][index]
                                          ["credit_value"]
                                      .toString())) {
                                creditsLeft = creditsLeft -
                                    double.parse(serverResponse!["bat"][index]
                                            ["credit_value"]
                                        .toString());
                                stringList.add(serverResponse!["bat"][index]
                                        ["played_id"]
                                    .toString());
                                playerList.add(playerData!);
                                batAdd = batAdd + 1;
                                playersCount = playersCount + 1;
                                if (teamsArrayName[0].toString().trim() ==
                                    serverResponse!["bat"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team1Count = team1Count + 1;
                                } else if (teamsArrayName[1]
                                        .toString()
                                        .trim() ==
                                    serverResponse!["bat"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team2Count = team2Count + 1;
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Credit points are Low.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstants.colorBlack,
                                    textColor: ColorConstants.colorBtnOne,
                                    fontSize: 16.0);
                              }
                            } else if (batAdd >= 6 && playersCount < 11) {
                              Fluttertoast.showToast(
                                  msg: "you can select only 6 Batsman.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstants.colorBlack,
                                  textColor: ColorConstants.colorBtnOne,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Container(
                              color: (stringList.contains(serverResponse!["bat"]
                                          [index]["played_id"]
                                      .toString()))
                                  ? ColorConstants.colorPinkHints
                                  : Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height: 0.2.sp,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                        bottom: 10.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Image.asset(
                                                    'assets/images/batsman.png',
                                                    width: 50.w,
                                                    height: 35.h),
                                              ],
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  serverResponse!["bat"][index]
                                                              ["player_details"]
                                                          ["fullname"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            /*Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sel by 97.18%",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                              width: 7.w,
                                              height: 7.h,
                                              child:Text(""),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConstants.colorBlack,)
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 4.w,),
                                      Text("Played Last Match",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: ColorConstants.colorLoginBtn,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )*/
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                sumPoints.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants
                                                      .colorBlackHint,
                                                  fontSize: 12.sp,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Center(
                                                  child: Text(
                                                    serverResponse!["bat"]
                                                                [index]
                                                            ["credit_value"]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants
                                                          .colorBlackHint,
                                                      fontSize: 12.sp,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                (stringList.contains(
                                                        serverResponse!["bat"]
                                                                    [index]
                                                                ["played_id"]
                                                            .toString()))
                                                    ? Image.asset(
                                                        'assets/images/minus.png',
                                                        width: 25.w,
                                                        height: 25.h)
                                                    : Image.asset(
                                                        'assets/images/add.png',
                                                        width: 25.w,
                                                        height: 25.h),
                                              ],
                                            )),
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
                            )),
                      );
                    })
                : SizedBox(),
            (serverResponse != null)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: serverResponse!["allr"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      sumPoints = 0;
                      serverResponse!["allr"][index]["previous_points"]
                          .forEach((element) {
                        sumPoints = sumPoints +
                            double.parse(element["points"].toString());
                      });
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String previousPoints = (serverResponse!["allr"]
                                            [index]["previous_points"] !=
                                        null &&
                                    serverResponse!["allr"][index]
                                                ["previous_points"]
                                            .length >
                                        0)
                                ? serverResponse!["allr"][index]
                                        ["previous_points"][0]["points"]
                                    .toString()
                                : "0";
                            playerData = new PlayerData(
                                serverResponse!["allr"][index]["player_details"]
                                        ["fullname"]
                                    .toString(),
                                previousPoints.toString(),
                                "ALL-R",
                                serverResponse!["allr"][index]["team"]
                                        ["short_name"]
                                    .toString(),
                                serverResponse!["allr"][index]["played_id"]
                                    .toString(),
                                "1",
                                "IN",
                                "1",
                                "1");
                            if ((bowlAdd == 0 || bowlAdd < 3) &&
                                playersCount > 7) {
                              validationString =
                                  "You must select Atleast 3 Bowlers.";
                            } else if (stringList.contains(
                                serverResponse!["allr"][index]["played_id"]
                                    .toString())) {
                              creditsLeft = creditsLeft +
                                  double.parse(serverResponse!["allr"][index]
                                          ["credit_value"]
                                      .toString());
                              stringList.remove(serverResponse!["allr"][index]
                                      ["played_id"]
                                  .toString());
                              //playerList.remove(playerData!);
                              playerList.removeWhere((item) =>
                                  item.id ==
                                  serverResponse!["allr"][index]["played_id"]
                                      .toString());
                              arAdd = arAdd - 1;
                              playersCount = playersCount - 1;
                              if (teamsArrayName[0].toString().trim() ==
                                  serverResponse!["allr"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team1Count = team1Count - 1;
                              } else if (teamsArrayName[1].toString().trim() ==
                                  serverResponse!["allr"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team2Count = team2Count - 1;
                              }
                            } else if (arAdd < 4 && playersCount < 11) {
                              if (creditsLeft >=
                                  double.parse(serverResponse!["allr"][index]
                                          ["credit_value"]
                                      .toString())) {
                                creditsLeft = creditsLeft -
                                    double.parse(serverResponse!["allr"][index]
                                            ["credit_value"]
                                        .toString());
                                stringList.add(serverResponse!["allr"][index]
                                        ["played_id"]
                                    .toString());
                                playerList.add(playerData!);
                                arAdd = arAdd + 1;
                                playersCount = playersCount + 1;
                                if (teamsArrayName[0].toString().trim() ==
                                    serverResponse!["allr"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team1Count = team1Count + 1;
                                } else if (teamsArrayName[1]
                                        .toString()
                                        .trim() ==
                                    serverResponse!["allr"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team2Count = team2Count + 1;
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Credit points are Low.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstants.colorBlack,
                                    textColor: ColorConstants.colorBtnOne,
                                    fontSize: 16.0);
                              }
                            } else if (arAdd >= 4) {
                              Fluttertoast.showToast(
                                  msg: "you can select only 4 All rounders.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstants.colorBlack,
                                  textColor: ColorConstants.colorBtnOne,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Container(
                              color: (stringList.contains(
                                      serverResponse!["allr"][index]
                                              ["played_id"]
                                          .toString()))
                                  ? ColorConstants.colorPinkHints
                                  : Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height: 0.2.sp,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                        bottom: 10.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Image.asset(
                                                    'assets/images/allrounder.png',
                                                    width: 50.w,
                                                    height: 35.h),
                                              ],
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  serverResponse!["allr"][index]
                                                              ["player_details"]
                                                          ["fullname"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            /*Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sel by 97.18%",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                              width: 7.w,
                                              height: 7.h,
                                              child:Text(""),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConstants.colorBlack,)
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 4.w,),
                                      Text("Played Last Match",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: ColorConstants.colorLoginBtn,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )*/
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                sumPoints.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants
                                                      .colorBlackHint,
                                                  fontSize: 12.sp,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Center(
                                                  child: Text(
                                                    serverResponse!["allr"]
                                                                [index]
                                                            ["credit_value"]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants
                                                          .colorBlackHint,
                                                      fontSize: 12.sp,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                (stringList.contains(
                                                        serverResponse!["allr"]
                                                                    [index]
                                                                ["played_id"]
                                                            .toString()))
                                                    ? Image.asset(
                                                        'assets/images/minus.png',
                                                        width: 25.w,
                                                        height: 25.h)
                                                    : Image.asset(
                                                        'assets/images/add.png',
                                                        width: 25.w,
                                                        height: 25.h),
                                              ],
                                            )),
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
                            )),
                      );
                    })
                : SizedBox(),
            (serverResponse != null)
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: serverResponse!["bowl"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      sumPoints = 0;
                      serverResponse!["bowl"][index]["previous_points"]
                          .forEach((element) {
                        sumPoints = sumPoints +
                            double.parse(element["points"].toString());
                      });
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            String previousPoints = (serverResponse!["bowl"]
                                            [index]["previous_points"] !=
                                        null &&
                                    serverResponse!["bowl"][index]
                                                ["previous_points"]
                                            .length >
                                        0)
                                ? serverResponse!["bowl"][index]
                                        ["previous_points"][0]["points"]
                                    .toString()
                                : "0";
                            playerData = new PlayerData(
                                serverResponse!["bowl"][index]["player_details"]
                                        ["fullname"]
                                    .toString(),
                                previousPoints.toString(),
                                "BOWL",
                                serverResponse!["bowl"][index]["team"]
                                        ["short_name"]
                                    .toString(),
                                serverResponse!["bowl"][index]["played_id"]
                                    .toString(),
                                "1",
                                "IN",
                                "1",
                                "1");
                            if (stringList.contains(serverResponse!["bowl"]
                                    [index]["played_id"]
                                .toString())) {
                              creditsLeft = creditsLeft +
                                  double.parse(serverResponse!["bowl"][index]
                                          ["credit_value"]
                                      .toString());
                              stringList.remove(serverResponse!["bowl"][index]
                                      ["played_id"]
                                  .toString());
                              //playerList.remove(playerData!);
                              playerList.removeWhere((item) =>
                                  item.id ==
                                  serverResponse!["bowl"][index]["played_id"]
                                      .toString());
                              bowlAdd = bowlAdd - 1;
                              playersCount = playersCount - 1;
                              if (teamsArrayName[0].toString().trim() ==
                                  serverResponse!["bowl"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team1Count = team1Count - 1;
                              } else if (teamsArrayName[1].toString().trim() ==
                                  serverResponse!["bowl"][index]["team"]
                                          ["short_name"]
                                      .toString()) {
                                team2Count = team2Count - 1;
                              }
                            } else if (bowlAdd < 6 && playersCount < 11) {
                              if (creditsLeft >=
                                  double.parse(serverResponse!["bowl"][index]
                                          ["credit_value"]
                                      .toString())) {
                                creditsLeft = creditsLeft -
                                    double.parse(serverResponse!["bowl"][index]
                                            ["credit_value"]
                                        .toString());
                                stringList.add(serverResponse!["bowl"][index]
                                        ["played_id"]
                                    .toString());
                                playerList.add(playerData!);
                                bowlAdd = bowlAdd + 1;
                                playersCount = playersCount + 1;
                                if (teamsArrayName[0].toString().trim() ==
                                    serverResponse!["bowl"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team1Count = team1Count + 1;
                                } else if (teamsArrayName[1]
                                        .toString()
                                        .trim() ==
                                    serverResponse!["bowl"][index]["team"]
                                            ["short_name"]
                                        .toString()) {
                                  team2Count = team2Count + 1;
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Credit points are Low.",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ColorConstants.colorBlack,
                                    textColor: ColorConstants.colorBtnOne,
                                    fontSize: 16.0);
                              }
                            } else if (bowlAdd >= 6) {
                              Fluttertoast.showToast(
                                  msg: "you can select only 6 Bowlers.",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: ColorConstants.colorBlack,
                                  textColor: ColorConstants.colorBtnOne,
                                  fontSize: 16.0);
                            }
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 7.h),
                            child: Container(
                              color: (stringList.contains(
                                      serverResponse!["bowl"][index]
                                              ["played_id"]
                                          .toString()))
                                  ? ColorConstants.colorPinkHints
                                  : Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width.w,
                                    height: 0.2.sp,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w,
                                        right: 10.w,
                                        top: 10.h,
                                        bottom: 10.h),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Image.asset(
                                                    'assets/images/bowler.png',
                                                    width: 50.w,
                                                    height: 35.h),
                                              ],
                                            )),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  serverResponse!["bowl"][index]
                                                              ["player_details"]
                                                          ["fullname"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'RoMedium',
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                            /*Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Sel by 97.18%",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: Colors.grey,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Container(
                                              width: 7.w,
                                              height: 7.h,
                                              child:Text(""),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: ColorConstants.colorBlack,)
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 4.w,),
                                      Text("Played Last Match",style: TextStyle(
                                        fontFamily: 'RoMedium',
                                        color: ColorConstants.colorLoginBtn,
                                        fontSize: 12.sp,
                                      ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )*/
                                          ],
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(
                                                sumPoints.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: ColorConstants
                                                      .colorBlackHint,
                                                  fontSize: 12.sp,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Center(
                                                  child: Text(
                                                    serverResponse!["bowl"]
                                                                [index]
                                                            ["credit_value"]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'RoMedium',
                                                      color: ColorConstants
                                                          .colorBlackHint,
                                                      fontSize: 12.sp,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4.w,
                                                ),
                                                (stringList.contains(
                                                        serverResponse!["bowl"]
                                                                    [index]
                                                                ["played_id"]
                                                            .toString()))
                                                    ? Image.asset(
                                                        'assets/images/minus.png',
                                                        width: 25.w,
                                                        height: 25.h)
                                                    : Image.asset(
                                                        'assets/images/add.png',
                                                        width: 25.w,
                                                        height: 25.h),
                                              ],
                                            )),
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
                            )),
                      );
                    })
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50.w,
            ),
            Expanded(
                flex: 1,
                child: FloatingActionButton.extended(
                    backgroundColor: ColorConstants.colorBlackHint,
                    heroTag: "Preview",
                    onPressed: () {
                      //Get.to(TeamPreview(playerList));
                      showPreViewScreen(context);
                    },
                    label: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          child: child,
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Image.asset(
                                "assets/images/eye.png",
                                height: 15.h,
                                width: 15.w,
                                color: ColorConstants.colorWhite,
                              )),
                          Text(
                            "Preview",
                            style: TextStyle(
                                color: ColorConstants.colorWhite,
                                fontSize: 15.sp),
                          )
                        ],
                      ),
                    ))),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
                flex: 1,
                child: FloatingActionButton.extended(
                    backgroundColor: (playersCount >= 11)
                        ? ColorConstants.colorGreenHint
                        : ColorConstants.colorBlackHint,
                    heroTag: "Next",
                    onPressed: () {
                      if (playersCount >= 11) {
                        Get.to(CaptainAndViceCaptain(
                            widget.startDate,
                            widget.amount,
                            teamName,
                            widget.contest_id,
                            widget.name,
                            playerList,
                            widget.matchId.toString(),
                            userDataService.userData.id,
                            userDataService.userData.name,
                            teamsArrayName[0].toString(),
                            teamsArrayName[1].toString(),
                            team1Count.toString(),
                            team2Count.toString(),
                            creditsLeft.toString()));
                      } else {
                        DialogUtil.showInfoDialog(
                            "Info", "Please Select Players.", context);
                      }
                    },
                    label: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          child: child,
                          sizeFactor: animation,
                          axis: Axis.horizontal,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Next",
                            style: TextStyle(
                                color: ColorConstants.colorWhite,
                                fontSize: 15.sp),
                          )
                        ],
                      ),
                    ))),
            SizedBox(
              width: 20.w,
            ),
          ]),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  void getCounts(Map<String, dynamic>? serverResponse) {
    for (int i = 1; i <= serverResponse!["wk"].length; i++) {
      setState(() {
        wkCount = wkCount + 1;
      });
    }
    for (int i = 1; i <= serverResponse["bat"].length; i++) {
      setState(() {
        batCount = batCount + 1;
      });
    }
    for (int i = 1; i <= serverResponse["allr"].length; i++) {
      setState(() {
        arCount = arCount + 1;
      });
    }
    for (int i = 1; i < serverResponse["bowl"].length; i++) {
      setState(() {
        bowlCount = bowlCount + 1;
      });
    }
  }

  showPreViewScreen(BuildContext context) {
    wKplayerList.clear();
    batplayerList.clear();
    allrplayerList.clear();
    bowlplayerList.clear();

    for (int i = 0; i < playerList.length; i++) {
      if (playerList[i].position == "WK") {
        wKplayerList.add(playerList[i]);
      } else if (playerList[i].position == "BAT") {
        batplayerList.add(playerList[i]);
      } else if (playerList[i].position == "ALL-R") {
        allrplayerList.add(playerList[i]);
      } else if (playerList[i].position == "BOWL") {
        bowlplayerList.add(playerList[i]);
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
                      padding: EdgeInsets.only(top: 25.h, bottom: 0.h),
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CountdownTimer(
                                            endTime: endTime,
                                            widgetBuilder: (context, time) {
                                              if (time == null) {
                                                return Text('');
                                              }
                                              return Row(
                                                children: [
                                                  (time.days != null)
                                                      ? Text(
                                                          time.days.toString() +
                                                              " days ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'RoMedium',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp),
                                                        )
                                                      : SizedBox(),
                                                  (time.hours != null)
                                                      ? Text(
                                                          time.hours
                                                                  .toString() +
                                                              " hrs ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'RoMedium',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp),
                                                        )
                                                      : SizedBox(),
                                                  (time.min != null)
                                                      ? Text(
                                                          time.min.toString() +
                                                              " min ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'RoMedium',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp),
                                                        )
                                                      : SizedBox(),
                                                  (time.sec != null)
                                                      ? Text(
                                                          time.sec.toString() +
                                                              " sec",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'RoMedium',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12.sp),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              );
                                              // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                            },
                                          ),
                                          Text(
                                            " left ",
                                            style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: Colors.white,
                                                fontSize: 12.sp),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Players",
                                            style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            playersCount.toString() + "/11",
                                            style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      teamsArrayName[0].toString(),
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    SizedBox(width: 35.h),
                                    Text(
                                      "$team1Count",
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10.h),
                                    Text(
                                      teamsArrayName[1].toString(),
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                    SizedBox(width: 35.h),
                                    Text(
                                      "$team2Count",
                                      style: TextStyle(
                                          fontFamily: 'RoMedium',
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13.sp),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Credits Left",
                                            style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            creditsLeft.toString(),
                                            style: TextStyle(
                                                fontFamily: 'RoMedium',
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13.sp),
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ))),
              Expanded(
                  child: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height.h,
                    width: MediaQuery.of(context).size.width.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("assets/images/previewbackground.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          children: [
                            Text(
                              "WICKET-KEEPERS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
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
                                    (wkAdd > 0)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (wKplayerList[0]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (wKplayerList[0]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/wicketkeeper.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            wKplayerList[0].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (wkAdd > 1)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (wKplayerList[1]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (wKplayerList[1]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/wicketkeeper.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            wKplayerList[1].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (wkAdd > 2)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (wKplayerList[2]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (wKplayerList[2]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/wicketkeeper.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            wKplayerList[2].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (wkAdd > 3)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (wKplayerList[3]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (wKplayerList[3]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/wicketkeeper.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            wKplayerList[3].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Text(
                              "BATTERS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
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
                                    (batAdd > 0)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[0]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[0]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[0].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (batAdd > 1)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[1]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[1]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[1].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (batAdd > 2)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[2]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[2]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[2].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
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
                                    (batAdd > 3)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[3]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[3]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[3].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (batAdd > 4)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[4]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[4]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[4].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (batAdd > 5)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (batplayerList[5]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (batplayerList[5]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/batsman.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            batplayerList[5].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Text(
                              "ALL ROUNDERS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
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
                                    (arAdd > 0)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (allrplayerList[0]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (allrplayerList[0]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/allrounder.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            allrplayerList[0].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (arAdd > 1)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (allrplayerList[1]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (allrplayerList[1]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    "assets/images/allrounder.png",
                                                                    height:
                                                                        40.h,
                                                                    width:
                                                                        40.w),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            allrplayerList[1].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (arAdd > 2)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (allrplayerList[2]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (allrplayerList[2]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/allrounder.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            allrplayerList[2].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (arAdd > 3)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (allrplayerList[3]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (allrplayerList[3]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/allrounder.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            allrplayerList[3].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            Text(
                              "BOWLERS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
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
                                    (bowlAdd > 0)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[0]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[0]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[0].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (bowlAdd > 1)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[1]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[1]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[1].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (bowlAdd > 2)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[2]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[2]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[2].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
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
                                    (bowlAdd > 3)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[3]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[3]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[3].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (bowlAdd > 4)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[4]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[4]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[4].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                    (bowlAdd > 5)
                                        ? Expanded(
                                            flex: 1,
                                            child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4.w, right: 4.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                (bowlplayerList[5]
                                                                            .captain
                                                                            .toString() ==
                                                                        "2")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "C",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                                (bowlplayerList[5]
                                                                            .vc
                                                                            .toString() ==
                                                                        "1.5")
                                                                    ? Container(
                                                                        width:
                                                                            25.w,
                                                                        height:
                                                                            25.h,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            "VC",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: ColorConstants.colorBlack),
                                                                      )
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                width: 2.h),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  "assets/images/bowler.png",
                                                                  height: 40.h,
                                                                  width: 40.w,
                                                                ),
                                                                Stack(
                                                                  children: [
                                                                    Transform
                                                                        .translate(
                                                                      offset: Offset(
                                                                          0.0,
                                                                          -25.0 /
                                                                              2.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            70.w,
                                                                        height:
                                                                            30.h,
                                                                        padding:
                                                                            EdgeInsets.all(2.h),
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                ColorConstants.colorBlackHint,
                                                                            borderRadius: BorderRadius.circular(10.h)),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            bowlplayerList[5].name.toString(),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontFamily: 'RoMedium',
                                                                                color: Colors.white,
                                                                                fontSize: 10.sp),
                                                                          ),
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
                                                    ))))
                                        : SizedBox(),
                                  ],
                                ),
                              )),
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
                    )),
              ))
            ],
          );
        });
  }
}
