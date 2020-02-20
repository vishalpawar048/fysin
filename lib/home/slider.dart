import 'dart:convert';
// import 'package:flutter_scaffold/config.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class ScreenArguments {
  //final String id;
  final String keyword;

  ScreenArguments(this.keyword);
}

class Banner with ChangeNotifier {
  final String id;
  final String keyword;
  final String imageUrl;
  // final String description;
  // final int price;
  // final String imageUrl;
  // final String website;
  // bool isFavorite;

  Banner({
    @required this.id,
    @required this.keyword,
    @required this.imageUrl,
    // @required this.description,
    // @required this.price,
    // @required this.imageUrl,
    // @required this.website,
    // this.isFavorite = false,
  });
}

class _HomeSliderState extends State<HomeSlider> {
  // final List<String> imgList = [];
  final List imgList = [];
  List banners;
  Map bannerImgsObj;

  Future<List> getBanner() async {
    //final response = await http.get('$BASE_URL/banners/getBanners/');
    //00  var keyword;
    final response = await http.post('$BASE_URL/banners/getBanners/', body: {
      'type': "Sliding",
    });

    if (response.statusCode == 200) {
      bannerImgsObj = json.decode(response.body);
      banners = bannerImgsObj["Banners"];
      banners.forEach((data) {
        // imgList.add(Banner(keyword: data['imgUrl'][0]));
        imgList.add(Banner(
          id: data['_id'],
          keyword: data['keyword'],
          imageUrl: data['imgUrl'][0],
        ));
      });
    }
    //print(">>>>>>>>>>${json.decode(productsArray[0])}");
    return imgList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getBanner(),
          builder: (context, AsyncSnapshot snapshot) {
            return CarouselSlider(
              autoPlay: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              height: 200.0,
              viewportFraction: 1.0,
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/products',
                                arguments: ScreenArguments(i.keyword));
                          },
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: i.imageUrl,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ));
                  },
                );
              }).toList(),
            );
          }),
    );
  }
}
