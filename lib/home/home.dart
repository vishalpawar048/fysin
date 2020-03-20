import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CategoriesBtns.dart';
import './search.dart';
import './wishListBtn.dart';
import './homePageBanners.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'drawer.dart';
import 'slider.dart';

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

    _firebaseMessaging.getToken().then((token) {
      print(
        ">>>>>>>>>>>>>>>>>>>>>>>>>$token",
      );
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
