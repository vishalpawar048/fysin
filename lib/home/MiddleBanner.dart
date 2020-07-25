import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:provider/provider.dart';

import 'Banners.dart';

class MiddleBanner extends StatelessWidget {
  List middleBanner;
  final banner = new Banners();
  getBanner() async {
    return middleBanner = await banner.getBanner('MiddleBanner');
  }

  @override
  Widget build(BuildContext context) {
    Sort sort = Provider.of<Sort>(context);

    return FutureBuilder(
      future: getBanner(),
      builder: (context, snapshot) {
        if (snapshot.data == null || middleBanner == null) {
          return Container();
        } else {
          return Container(
            margin: EdgeInsets.only(top: 25, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(
                10.0,
              ),
            ),
            child: InkWell(
              // onTap: () {
              //   Navigator.pushNamed(context, '/products',
              //       arguments: ScreenArguments(
              //           '', middleBanner[0][1], middleBanner[0][2]));
              // },
              onTap: () {
                sort.sortByPrice(0);
                Navigator.pushNamed(context, '/productGrid1',
                    arguments: ScreenArguments(
                        '', middleBanner[0][1], middleBanner[0][2]));

                // Navigator.pushNamed(context, '/productGrid1',
                //     arguments: ScreenArguments(
                //         '', middleBanner[0][1], middleBanner[0][2]));
              },
              // child: CachedNetworkImage(
              //   fit: BoxFit.cover,
              //   imageUrl: middleBanner[0][0],
              //   imageBuilder: (context, imageProvider) => Container(
              //     decoration: BoxDecoration(
              //       borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              //       image: DecorationImage(
              //           image: imageProvider, fit: BoxFit.cover),
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => new Icon(Icons.error),
              // ),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(middleBanner[0][0]),
              ),
            ),
          );
        }
      },
    );
  }
}
