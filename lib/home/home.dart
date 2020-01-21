import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CategoriesBtns.dart';
import '../shop/search.dart';
import './wishlistBtn.dart';
import './homePageBanners.dart';

// import 'drawer.dart';
import 'slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Next page'),
      // ),
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
