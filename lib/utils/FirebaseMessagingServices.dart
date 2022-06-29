import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class FirebaseMessagingServices{


   static fireBaseMessageInitialize() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyAV6VSqhdquCMnHLaVmUdTZFTHZmhLEdb4", appId: "1:879332757912:ios:8f4ded028ef2920e4a5bed", messagingSenderId: "879332757912", projectId: "flip2play"));
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

     FirebaseMessaging.instance.getToken().then((token){
       print(token);
       prefs.setString("fcm_token", token.toString());
     });

     if (!kIsWeb) {
       channel = const AndroidNotificationChannel(
         'high_importance_channel', // id
         'High Importance Notifications', // title
         importance: Importance.high,
       );

       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
       await flutterLocalNotificationsPlugin
           .resolvePlatformSpecificImplementation<
           AndroidFlutterLocalNotificationsPlugin>()
           ?.createNotificationChannel(channel);
       await FirebaseMessaging.instance
           .setForegroundNotificationPresentationOptions(
         alert: true,
         badge: true,
         sound: true,
       );
     }


     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       print("message===onMessage===>>"+message.toString());
       /*Fluttertoast.showToast(
           msg: message.toString(),
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );*/
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null && !kIsWeb) {
         flutterLocalNotificationsPlugin.show(
           notification.hashCode,
           notification.title,
           notification.body,
           NotificationDetails(
             android: AndroidNotificationDetails(
               channel.id,
               channel.name,
               icon: 'launch_background',
             ),
           ),
         );
       }
     });

     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
       print("message===onMessageOpenedApp===>>"+message.toString());
       /*Fluttertoast.showToast(
           msg: message.toString(),
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );*/
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null && !kIsWeb) {
         flutterLocalNotificationsPlugin.show(
           notification.hashCode,
           notification.title,
           notification.body,
           NotificationDetails(
             android: AndroidNotificationDetails(
               channel.id,
               channel.name,
               icon: 'launch_background',
             ),
           ),
         );
       }
     });
   }

}