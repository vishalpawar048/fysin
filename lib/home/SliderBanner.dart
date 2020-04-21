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
                margin: EdgeInsets.only(top: 30),
                height: 180.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: bannersArray.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          margin: EdgeInsets.only(left: 5, right: 10),
                          width: 140.0,
                          child: Hero(
                            tag: '$i',
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/products',
                                    arguments: ScreenArguments('', i[1], i[2]));
                              },
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: i[0],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0)),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
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
