
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:nadek/sheard/constante/string.dart';
import 'package:nadek/sheard/style/ColorApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splach_screen extends StatefulWidget {
  const splach_screen({Key? key}) : super(key: key);

  @override
  State<splach_screen> createState() => _splach_screenState();
}

class _splach_screenState extends State<splach_screen> {
  String? token ;
  var channel;
  var flutterLocalNotificationsPlugin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    requestPermission();
    loadFCM();
    listenFCM();

    SharedPreferences.getInstance().then((value) {
      setState(() {
        token =value.getString('token');
        print('tokennnnnnnnnn $token');

      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenRouteFunction(
      splash:Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration:  const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 50.0],
                colors: [
                  ColorApp.blue,
                  ColorApp.move,
                ],
              ),
            ),
            child:  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                 Image(
                   height: 150,
                     width: 150,
                     image: AssetImage('assets/images/logo-nadk.png')
                 )
                ],
              ),
            )
        ),
      ),
      splashIconSize: double.infinity,
      duration: 5000,
      screenRouteFunction: ()async{

        if(token ==null){
          return  await isFirstOpen()?'/login_user':'/View_pager';
        }else{
          return '/Home_screen';
        }

      },

    );
  }


  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
  void loadFCM() async {
    if (!kIsWeb) {
       channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

       flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }
  Future<bool> isFirstOpen()async{
    bool firstRun = await IsFirstRun.isFirstRun();
    return !firstRun;

  }
}




