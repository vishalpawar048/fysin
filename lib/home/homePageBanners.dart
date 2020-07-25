import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/MiddleBanner.dart';
import 'package:flutter_scaffold/home/OfferBanner.dart';
import 'package:flutter_scaffold/home/SliderBanner.dart';
import 'package:flutter_scaffold/home/SquareBanner.dart';
import 'package:flutter_scaffold/home/BruhhEndText.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:provider/provider.dart';

import 'SquareEndBanner.dart';

class HomePageBanners extends StatelessWidget {
  // MyVoid getImg;

  //https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SliderBanner(),
        MiddleBanner(),
        SquareBanner(),
        OfferBanner(),
        SquareEndBanner(),
        // BruhhEndText()
      ],
    );
  }
}
