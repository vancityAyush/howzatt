import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/Repository/HomePageRepository.dart';
import 'package:howzatt/modal/MatchLeague.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/ui/DashBoard/Contest/ContestMainPage.dart';
import 'package:howzatt/ui/DashBoard/MyMatches/LeagueMatches.dart';
import 'package:howzatt/ui/DashBoard/NavigationDrawer.dart';
import 'package:howzatt/ui/Football/FootballHomePage.dart';
import 'package:howzatt/ui/Notifications/Notifications.dart';
import 'package:howzatt/ui/WalletDetails/MyWallet.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleFour.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleThree.dart';
import 'package:howzatt/utils/supportingWidgets/ButtonStyleTwo.dart';

import '../../Bloc/HomePageBloc/HomePageBloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomePageBloc(HomePageRepository(dio.Dio())),
        ),
      ],
      child: HomePageStateful(),
    ));
  }
}

class HomePageStateful extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageStateful> {
  List<int> listInt = [1, 2, 3, 4];
  int _current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  dio.Response? response;
  List<MatchLeague> leaguesKeyList = List.empty(growable: true);
  List<String> assetImageList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    assetImageList.add('assets/images/sliderimage1.png');
    assetImageList.add('assets/images/sliderimage2.png');
    assetImageList.add('assets/images/sliderimage3.png');
    assetImageList.add('assets/images/referandearn.png');
    BlocProvider.of<HomePageBloc>(context)
        .add(GetUserDataEvent(context: context));
    BlocProvider.of<HomePageBloc>(context)
        .add(AuthenticationEvent(context: context));
    BlocProvider.of<HomePageBloc>(context).add(UpdateToken(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            height: 10.h,
            color: Colors.black,
          )),
      drawer: Drawer(child: NavigationDrawerStateful()),
      body: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is AuthenticationCompleteState) {
            if (state.accessToken != null && state.accessToken != "") {
              BlocProvider.of<HomePageBloc>(context).add(
                  GetScheduleMatchDataEvent(
                      context: context, accessToken: state.accessToken));
            }
          }
          if (state is GetMatchDataCompleteState) {
            setState(() {
              response = state.response;
              getLeagueList(response);
            });
          }
        },
        child: Padding(
            padding:
                EdgeInsets.only(left: 0.w, top: 0.h, bottom: 0.h, right: 0.h),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                Container(
                  height: 175.h,
                  width: MediaQuery.of(context).size.width.w,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Transform.translate(
                            offset: Offset(0.0, 120.h / 1.7.h),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: 120.h,
                                    //width: MediaQuery.of(context).size.width.w,
                                    aspectRatio: 15.h / 50.h,
                                    viewportFraction: 1.h,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index + 1;
                                      });
                                    }),
                                items: assetImageList.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width.w,
                                        //margin: EdgeInsets.symmetric(vertical: 25.0),
                                        decoration: BoxDecoration(
                                            //color: Colors.black
                                            ),
                                        child: Image.asset(
                                          i,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height
                                              .h,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width
                                              .w,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Container(
                              color: Colors.black,
                              height: 55.h,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.h, bottom: 5.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20.h,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _scaffoldKey.currentState!
                                                    .openDrawer();
                                              },
                                              child: Image.asset(
                                                  'assets/images/homeuser.png',
                                                  width: 35.w,
                                                  height: 35.h),
                                            ),
                                          ],
                                        )),
                                    Stack(
                                      children: [
                                        Transform.translate(
                                          offset: Offset(0.0, 40.h / 2.h),
                                          child: buttonStyleFour(context),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(Notifications());
                                              },
                                              child: Image.asset(
                                                  'assets/images/homenotification.png',
                                                  width: 22.w,
                                                  height: 22.h),
                                            ),
                                            SizedBox(
                                              width: 10.h,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.to(MyWallet());
                                              },
                                              child: Image.asset(
                                                  'assets/images/homewallet.png',
                                                  width: 22.w,
                                                  height: 22.h),
                                            ),
                                            SizedBox(
                                              width: 0.h,
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  //alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 0.h),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: listInt.map((i) {
                        int index = i; //are changed
                        return Container(
                          width: 6.h,
                          height: 6.h,
                          margin: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 2.h),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [buttonStyleTwo("Cricket", context)],
                        )),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(FootballHomePage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [buttonStyleThree("Football", context)],
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20.h,
                    ),
                    Text(
                      "ONGOING LEAGUE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RoMedium',
                          color: Colors.black87,
                          fontSize: 18.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                    height: 80.h,
                    color: ColorConstants.colorLoginBtn,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 10.h, right: 10.h, top: 10.h, bottom: 10.h),
                        child: (leaguesKeyList != null &&
                                leaguesKeyList.isNotEmpty)
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: leaguesKeyList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(LeagueMatches(
                                          leaguesKeyList[index].leagueKey,
                                          leaguesKeyList[index].leagueName));
                                      //Get.to(ContestMainPage(response!.data["data"]["months"][0]["days"][index]["matches"][index1]["key"].toString(),response!.data["data"]["months"][0]["days"][index]["matches"][index1]["short_name"].toString(),response!.data["data"]["months"][0]["days"][index]["matches"][index1]["start_date"]["iso"].toString()));
                                    },
                                    child: Container(
                                      width: 120.h,
                                      height: 00.h,
                                      child: Card(
                                        color: ColorConstants.colorBtnOne,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.h),
                                                topLeft: Radius.circular(10.h),
                                                bottomRight:
                                                    Radius.circular(10.h),
                                                topRight:
                                                    Radius.circular(10.h))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Expanded(
                                                child: Text(
                                              leaguesKeyList[index]
                                                  .leagueName
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: ColorConstants
                                                      .colorBlack),
                                            )),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : SizedBox())),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15.h,
                    ),
                    Text(
                      "UPCOMING MATCHES ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RoMedium',
                          color: Colors.black87,
                          fontSize: 18.sp),
                    ),
                  ],
                ),
                (response != null)
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            response!.data["data"]["months"][0]["days"].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          //print("count===>>"+response!.data["data"]["months"][0]["days"][index]["matches"].length.toString());
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: response!
                                  .data["data"]["months"][0]["days"][index]
                                      ["matches"]
                                  .length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index1) {
                                var nameArray = response!.data["data"]["months"]
                                        [0]["days"][index]["matches"][index1]
                                        ["short_name"]
                                    .toString()
                                    .split("vs");
                                var startDate = response!.data["data"]["months"]
                                        [0]["days"][index]["matches"][index1]
                                        ["start_date"]["iso"]
                                    .toString()
                                    .split("T");
                                var time = startDate[1].split("+");

                                DateTime dt1 = DateTime.parse(
                                    startDate[0].toString() +
                                        " " +
                                        time[0] +
                                        ":00");
                                DateTime now = DateTime.now();
                                DateTime dateTime = DateTime.parse(response!
                                    .data["data"]["months"][0]["days"][index]
                                        ["matches"][index1]["start_date"]["iso"]
                                    .toString());
                                int endTime =
                                    dateTime.toLocal().millisecondsSinceEpoch +
                                        1000 * 30;
                                String k = response!.data["data"]["months"][0]
                                        ["days"][index]["matches"][index1]
                                        ["name"]
                                    .toString();
                                return (
                                    dateTime.isAfter(now)?GestureDetector(
                                  onTap: () {
                                    Get.to(ContestMainPage(
                                        response!.data["data"]["months"][0]
                                                ["days"][index]["matches"]
                                                [index1]["key"]
                                            .toString(),
                                        response!.data["data"]["months"][0]
                                                ["days"][index]["matches"]
                                                [index1]["short_name"]
                                            .toString(),
                                        response!.data["data"]["months"][0]
                                                ["days"][index]["matches"]
                                                [index1]["start_date"]["iso"]
                                            .toString()));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.h, right: 15.h, top: 7.h),
                                    child: Container(
                                      height: 126.h,
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(20.h),
                                                topLeft: Radius.circular(20.h),
                                                bottomRight:
                                                    Radius.circular(20.h),
                                                topRight:
                                                    Radius.circular(20.h))),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.h,
                                                  right: 10.h,
                                                  top: 7.h,
                                                  bottom: 7.h),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 30.h,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            k,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontFamily:
                                                                    'RoLight',
                                                                color: ColorConstants
                                                                    .colorBlack,
                                                                fontSize:
                                                                    13.sp),
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width
                                                            .w,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                nameArray[0]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp,
                                                                    color: ColorConstants
                                                                        .colorBlack),
                                                              )
                                                            ],
                                                          )),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            width: 50.h,
                                                            height: 20.h,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.h),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.h)),
                                                            child: Center(
                                                              child: Text(
                                                                "MEGA",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'RoMedium',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                nameArray[1]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15.sp,
                                                                    color: ColorConstants
                                                                        .colorBlack),
                                                              )
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7.h,
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width
                                                    .w,
                                                height: 35.h,
                                                decoration: BoxDecoration(
                                                    color: ColorConstants
                                                        .colorLoginBtn,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20.h),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20.h))),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 5.h,
                                                    ),
                                                    CountdownTimer(
                                                      endTime: endTime,
                                                      widgetBuilder:
                                                          (context, time) {
                                                        if (time == null) {
                                                          return Text(
                                                              'Game over');
                                                        }
                                                        return Row(
                                                          children: [
                                                            (time.days != null)
                                                                ? Text(
                                                                    time.days
                                                                            .toString() +
                                                                        " days ",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'RoMedium',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.sp),
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
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.sp),
                                                                  )
                                                                : SizedBox(),
                                                            (time.min != null)
                                                                ? Text(
                                                                    time.min.toString() +
                                                                        " min ",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'RoMedium',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.sp),
                                                                  )
                                                                : SizedBox(),
                                                            (time.sec != null)
                                                                ? Text(
                                                                    time.sec.toString() +
                                                                        " sec",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'RoMedium',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.sp),
                                                                  )
                                                                : SizedBox(),
                                                          ],
                                                        );
                                                        // Text('days: [ ${time.days} ], hours: [ ${time.hours} ], min: [ ${time.min} ], sec: [ ${time.sec} ]');
                                                      },
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("")),
                                                    Stack(
                                                      alignment:
                                                          Alignment.topRight,
                                                      children: [
                                                        Transform.translate(
                                                          offset: Offset(
                                                              0.0, -40 / 3.4),
                                                          child: Image.asset(
                                                            'assets/images/trophy.png',
                                                            width: 60.w,
                                                            height: 30.h,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                        flex: 1,
                                                        child: Text("")),
                                                    /*Image.asset('assets/images/movie.png', width: 20.w ,height: 20.h,color: Colors.white,),
                                                  SizedBox(width: 10.h,),
                                                  Image.asset('assets/images/tshirt.png', width: 25.w ,height: 20.h,color: Colors.white,),
                                                  SizedBox(width: 10.h,)*/
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ):SizedBox());
                              });
                        })
                    : SizedBox(),
              ],
            )),
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }

  void getLeagueList(dio.Response? response) {
    for (int i = 0;
        i < response!.data["data"]["months"][0]["days"].length;
        i++) {
      for (int j = 0;
          j < response.data["data"]["months"][0]["days"][i]["matches"].length;
          j++) {
        setState(() {
          if (leaguesKeyList.contains(response.data["data"]["months"][0]["days"]
                      [i]["matches"][j]["season"]["key"]
                  .toString()) ==
              false) {
            leaguesKeyList.add(MatchLeague(
                response.data["data"]["months"][0]["days"][i]["matches"][j]
                        ["season"]["name"]
                    .toString(),
                response.data["data"]["months"][0]["days"][i]["matches"][j]
                        ["season"]["key"]
                    .toString()));
          }
        });
      }
    }
  }
}
