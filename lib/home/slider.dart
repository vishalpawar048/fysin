import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class Banner with ChangeNotifier {
  final String id;
  final String imageUrl;
  // final String description;
  // final int price;
  // final String imageUrl;
  // final String website;
  // bool isFavorite;

  Banner({
    @required this.id,
    @required this.imageUrl,
    // @required this.description,
    // @required this.price,
    // @required this.imageUrl,
    // @required this.website,
    // this.isFavorite = false,
  });
}

class _HomeSliderState extends State<HomeSlider> {
  //final List<String> imgList = [];
  final List imgList = [];
  Map banners;
  Future<List> getBanner() async {
    final response = await http
        .get('https://wishlist-app-a6894.firebaseio.com/SliderBanner.json');

    Map<String, dynamic> bannerImgsObj;
    if (response.statusCode == 200) {
      bannerImgsObj = json.decode(response.body);
      for (final id in bannerImgsObj.keys) {
        banners = bannerImgsObj[id];
        print('$id,$banners'); // prints entries like "AED,3.672940"
      }
      banners.forEach((id, data) {
        print(">>>>>>>>>>>>>>$data");
        imgList.add(Banner(
          id: id,
          imageUrl: data['url'],
        ));
        // data.forEach((id, banner) {
        //   imgList.add(Banner(
        //     id: id,
        //     imageUrl: banner['url'],
        //   ));
        // });
      });
    }
    //print(">>>>>>>>>>${json.decode(productsArray[0])}");
    return imgList;
  }

  // final List<String> imgList = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  //   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  //   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  //   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  //   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getBanner(),
          builder: (context, AsyncSnapshot snapshot) {
            CarouselSlider(
              autoPlay: true,
              pauseAutoPlayOnTouch: Duration(seconds: 10),
              height: 200.0,
              viewportFraction: 1.0,
              items: imgList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: i,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        ));
                  },
                );
              }).toList(),
            );
          }),
    );
  }
}
