import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/home/CategoriesBtns.dart';
import 'package:intl/intl.dart';
import '../config.dart';
import './search.dart';
import './wishListBtn.dart';
import './homePageBanners.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    var now = new DateTime.now();
    _firebaseMessaging.getToken().then((token) async {
      // final String emailId = prefs.getString('emailId') ?? "false";

      try {
        final response = await http.post('$BASE_URL/user/saveFcmToken', body: {
          'fcmToken': token,
          'date': new DateFormat("dd-MM-yyyy hh:mm:ss").format(now)
        });
        if (response.statusCode >= 400) {
          print("Faild FCM storage $response");
        } else {
          print("Success FCM storage $response");
        }
      } catch (error) {
        print("Faild FCM storage $error");
      }
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: <Widget>[
            Search(),
            WishListBtn(),
          ],
        ),
      ),
      // drawer: Drawer(
      //   child: AppDrawer(),
      // ),

      body: SafeArea(
        child: ListView(children: <Widget>[
          CategoriesBtns(),
          HomeSlider(),
          HomePageBanners()
        ]),
      ),
    );
  }
}
