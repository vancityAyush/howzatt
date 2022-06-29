import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:howzatt/modal/PlayerData.dart';
import 'package:howzatt/ui/DashBoard/BottomNavigation.dart';
import 'package:howzatt/utils/ColorConstants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TeamPreview extends StatefulWidget {
  List<PlayerData>? playerList;

  TeamPreview(List<PlayerData>? _playerList){
    playerList = _playerList;
  }



  @override
  _TeamPreviewState createState() => _TeamPreviewState();
}


class _TeamPreviewState extends State<TeamPreview> with SingleTickerProviderStateMixin{

  List<int> listInt = [1,2,3,4,5];
  int _current = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late TabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Column(
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
                                        Navigator.pop(context);
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
                                        Text(
                                          'Yashblaster team',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'RoMedium',
                                              color: Colors.white,
                                              fontSize: 15.sp
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '05M 33S left',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: 'RoMedium',
                                                  color: Colors.white,
                                                  fontSize: 12.sp
                                              ),
                                            ),
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
                                        Text("0/11",style: TextStyle(
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
                                  SizedBox(width:10.h),
                                  Text("DT-W",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp
                                  ),),
                                  SizedBox(width:35.h),
                                  Text("0",style: TextStyle(
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
                                  Text("DD-W",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp
                                  ),),
                                  SizedBox(width:35.h),
                                  Text("0",style: TextStyle(
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
                                        Text("0",style: TextStyle(
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
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height.h,
          width: MediaQuery.of(context).size.width.w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/previewbackground.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:ListView(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text("WICKET-KEEPERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text("")
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Text("")
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("BATTERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("ALL-ROUNDERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Text("BOWLERS",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12.sp,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        height: 20.h,
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
                          ],
                        ),
                        Text("9 cr." , textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
              ],
            ),
          ],
        )
      ),
      bottomNavigationBar: bottomNavgation(context),
    );
  }




}













