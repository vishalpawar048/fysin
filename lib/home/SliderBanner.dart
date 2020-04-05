import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/Banners.dart';
import 'CarouselBanner.dart';

class SliderBanner extends StatelessWidget {
  List bannersArray;
  final banner = new Banners();
  getBanner() async {
    return bannersArray = await banner.getBanner('SlidingBanner');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getBanner(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null || bannersArray == null) {
              return Container();
            } else {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                height: 180.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bannersArray.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: 140.0,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/products',
                                    arguments:
                                        ScreenArguments(null, i[1], i[2]));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 172,
                                    child: Hero(
                                      tag: '$i',
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: i[0],
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(
                                          backgroundColor: Colors.pink[300],
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.lightBlue),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            new Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }
          }),
    );
  }
}
