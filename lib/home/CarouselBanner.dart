import 'dart:convert';
// import 'package:flutter_scaffold/config.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'Banners.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class ScreenArguments {
  //final String id;
  final String keyword;
  final String category;
  final String subCategory;

  ScreenArguments(this.keyword, this.category, this.subCategory);
}

// class Banner with ChangeNotifier {
//   final String id;
//   final String keyword;
//   final String imageUrl;
//   final String subCategory;
//   final String category;

//   Banner({
//     @required this.id,
//     @required this.keyword,
//     @required this.imageUrl,
//     @required this.subCategory,
//     @required this.category,
//   });
// }

class _HomeSliderState extends State<HomeSlider> {
  final List imgList = [];
  List banners;
  Map bannerImgsObj;

  Future<List> getBanner() async {
    final response = await http.post('$BASE_URL/banners/getBanners/', body: {
      'type': "CarouselBanner",
    });
    if (response.statusCode == 200) {
      bannerImgsObj = json.decode(response.body);
      banners = bannerImgsObj["banners"];

      return banners;
    } else {
      print("$response");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getBanner(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else {
              return CarouselSlider(
                autoPlay: true,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                height: 200.0,
                viewportFraction: 1.0,
                items: banners.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/products',
                                  arguments: ScreenArguments('', i[1], i[2]));
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: i[0],
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.pink[300],
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.lightBlue),
                              )),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ));
                    },
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}
