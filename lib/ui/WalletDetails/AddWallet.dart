import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:howzatt/Bloc/WalletBloc/WalletBloc.dart';
import 'package:howzatt/Repository/WalletRepository.dart';
import 'package:howzatt/services/ServicesLocator.dart';
import 'package:howzatt/services/UserDataServcie.dart';
import 'package:howzatt/ui/DashBoard/HomePage.dart';
import 'package:howzatt/ui/WalletDetails/MyWallet.dart';
import 'package:howzatt/utils/ColorConstants.dart';


class AddWallet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: BlocProvider(
        create: (_) => WalletBloc(WalletRepository(Dio())),
        child: AddWalletStateful(),
      ),
    );
  }
}

class AddWalletStateful extends StatefulWidget {


  @override
  _AddWalletStatefulState createState() => _AddWalletStatefulState();
}


class _AddWalletStatefulState extends State<AddWalletStateful> {

  TextEditingController walletController = new TextEditingController();
  UserDataService userDataService =  getIt<UserDataService>();
  bool btnClick = false;
  BuildContext? dialogContext;


  @override
  void initState() {
    super.initState();

  }

  Future<bool> _willPopCallback() async {
    Get.to(MyWallet());
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: BlocListener<WalletBloc,WalletState>(
          listener: (context,state){
             setState((){
               dialogContext = context;
             });
             if(state is AddWalletCompleteState){
               makePayment(walletController.text,state.cftoken.toString(),state.orderId.toString());
             }
             if(state is UpdateWalletCompleteState){
               Get.to(MyWallet());
             }
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(70.h),
                child: Container(
                    color: Colors.black,
                    height: 70.h,
                    child:Padding(
                      padding: EdgeInsets.only(top: 35.sp),
                      child: Row(
                        children: [
                          Expanded(
                              child:  Row(
                                children: [
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Get.to(MyWallet());
                                    },
                                    child: Image.asset('assets/images/back_arrow.png', width: 40.w ,height: 15.h,color: Colors.white,),
                                  ),
                                  SizedBox(
                                    width: 0.h,
                                  ),
                                  Text(
                                    'Add Wallet Amount',
                                    textAlign: TextAlign.center,
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
                    )
                ),
              ),
              body: SafeArea(
                  child:SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w,right: 20.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.w,right: 15.w,bottom: 0.h,top: 30.h),
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: walletController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.h),),
                                      labelText: 'Add Money to Wallet',
                                      hintText: 'Add Money to Wallet',
                                      //suffixIcon: Icon(Icons.wallet_giftcard_sharp, color: ColorConstants.primaryColor3),
                                  ),
                                  onChanged: (value) {

                                  }
                              ),
                            ),
                            (btnClick == true && walletController.text == "") ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 15.w,),
                                Text("Please enter amount.", style: TextStyle(fontFamily: "RoRegular", fontSize: 12.sp, color: Colors.red, ),)
                              ],
                            ):SizedBox(),
                            SizedBox(
                              height: 50.h,
                            ),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  btnClick = true;
                                  if(walletController.text != ""){
                                    //Get.to(CashFreeScreen(walletController.text));
                                    BlocProvider.of<WalletBloc>(context).add(AddWalletEvent(context: context,amount: walletController.text,type: "credit",status: "completed",user_id:userDataService.userData.id.toString(),isFromSuccess:false));
                                  }
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width.w/1.5,
                                padding: EdgeInsets.all(10.h),
                                decoration: BoxDecoration(
                                    color: ColorConstants.colorLoginBtn,
                                    borderRadius: BorderRadius.circular(5.h)
                                ),
                                child: Center(
                                  child: Text("Add Amount",style: TextStyle(
                                      fontFamily: 'RoMedium',
                                      color: Colors.white,
                                      fontSize: 15.sp
                                  ),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  )
              )
          ),
        )
    );
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

    CashfreePGSDK.doPayment(inputParams).then((value){
      print("value====>>>"+value.toString());
      if(value!["txStatus"].toString() == "CANCELLED"){
        Fluttertoast.showToast(
            msg: value["txMsg"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        BlocProvider.of<WalletBloc>(dialogContext!).add(UpdateWallet(context: context,status: "pending",response:value["txMsg"].toString(),orderId:orderId.toString(),isFromSuccess:false));
      }
      else if(value["txStatus"].toString() == "SUCCESS"){
        Fluttertoast.showToast(
            msg: value["txMsg"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white
        );
        Get.to(MyWallet());
      }
    });
  }

}













