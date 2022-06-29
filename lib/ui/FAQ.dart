
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:howzatt/utils/ColorConstants.dart';



class FAQ extends StatefulWidget {

  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

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
                          Get.back();
                        },
                        child:Container(
                          width: 10.w,
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
                            child: Text("FAQ ",textAlign: TextAlign.center, style: TextStyle(fontFamily: "RoRegular", fontSize: 22.sp, color: Colors.black,fontWeight: FontWeight.bold),),
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
                          Padding(
                            padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 0.h),
                            child: Card(
                              elevation: 2,
                              child: ExpansionTile(
                                title: Text('How to play Flip2Play fantasy Cricket ?',style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
                                //subtitle: Text('Expand this tile to see its contents'),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                    child:Text('Ans: Playing fantasy cricket on Flip2Play is extremely simple. Follow these easy to use steps:',
                                      style: TextStyle(fontSize: 15.sp,color: Colors.black),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                    child:Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                          child: Container(
                                            width: 10.w,
                                            height: 10.h,
                                            child: SizedBox(),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black),
                                          ),
                                        ),
                                        SizedBox(width: 10.w,),
                                        Expanded(child: Text('Select your desired match to play on Flip2Play.',
                                          style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                      ],
                                    )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                            child: Container(
                                              width: 10.w,
                                              height: 10.h,
                                              child: SizedBox(),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(child: Text('Make your fantasy team by choosing players from the two teams.',
                                            style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                        ],
                                      )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                            child: Container(
                                              width: 10.w,
                                              height: 10.h,
                                              child: SizedBox(),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(child: Text('Go along with one of the many challenges accessible on Flip2Play. Presently you are important for the game.',
                                            style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                        ],
                                      )
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                            child: Container(
                                              width: 10.w,
                                              height: 10.h,
                                              child: SizedBox(),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(width: 10.w,),
                                          Expanded(child: Text('Whenever you win a money challenge, you can withdraw your rewards or join more money challenges with the amount to win more.',
                                            style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            )
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                              child: Card(
                                elevation: 2,
                                child: ExpansionTile(
                                  title: Text('What are the various tips and tricks to win in Flip2Play ?',style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
                                  //subtitle: Text('Expand this tile to see its contents'),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Text('Ans: Here are some flip2play fantasy tips and tricks to remember while choosing your fantasy team:',
                                        style: TextStyle(fontSize: 15.sp,color: Colors.black),),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('Look at the pitch and climate forecast.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('See if it is a batting pitch or a bowling pitch. Select more batsmen or bowlers in your group likewise.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('Concentrate on the players presentation and records in past matches.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('Select batsmen who can score enormous runs and bowlers who can take wickets.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('Pick your skipper and bad habit chief carefully as they score 2x and 1.5x focuses individually when contrasted with different players in the group.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 0.w,right: 0.w,top: 5.h),
                                              child: Container(
                                                width: 10.w,
                                                height: 10.h,
                                                child: SizedBox(),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(child: Text('Make various groups and join numerous challenges to amplify your chances of winning.',
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black),),)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                              child: Card(
                                elevation: 2,
                                child: ExpansionTile(
                                  title: Text('How to know about the teams for upcoming matches ?',style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
                                  //subtitle: Text('Expand this tile to see its contents'),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Text('Ans: Watch out for our devoted blog segment routinely, where we distribute blog entries about the greatest matches coming up and fantasy team forecasts for them. You can utilize the understanding and information acquired from our blog entries to make the most ideal teams and win enormous.',
                                        style: TextStyle(fontSize: 15.sp,color: Colors.black),),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
                              child: Card(
                                elevation: 2,
                                child: ExpansionTile(
                                  title: Text('Is it safe to play on Flip2Play app ?',style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
                                  //subtitle: Text('Expand this tile to see its contents'),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Text('Ans: Indeed, it is totally protected to play fantasy games on flip2play. Flip2Play is the most believed dream sports stage. The flip2play application/site offers a 100 percent completely safe online gaming environment to every one of the clients. It involves totally secure installment passages for safe online transactions. You can without much of a stretch store and pull out cash whenever.',
                                        style: TextStyle(fontSize: 15.sp,color: Colors.black),),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 20.h),
                              child: Card(
                                elevation: 2,
                                child: ExpansionTile(
                                  title: Text('Which fantasy Cricket league contests are best to join ?',style: TextStyle(fontSize: 15.sp,color: ColorConstants.colorLoginBtn,fontWeight: FontWeight.bold),),
                                  //subtitle: Text('Expand this tile to see its contents'),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 10.h),
                                      child:Text('Ans: We have Grand League and Small League challenges where a huge number of players take part for enormous monetary rewards. The section charge for a Grand League challenge is for the most part low. In these challenges, half members normally win with the exception of a couple of special cases. In our Head to Head challenges, you rival just a single adversary. There are free practice matches too that you can join for free to improve your abilities. Practice challenges assist new players with understanding the scoring framework better and gain certainty.',
                                        style: TextStyle(fontSize: 15.sp,color: Colors.black),),
                                    ),
                                  ],
                                ),
                              )
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
