import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';

import 'Banners.dart';

class MiddleBanner extends StatelessWidget {
  List middleBanner;
  final banner = new Banners();
  getBanner() async {
    return middleBanner = await banner.getBanner('MiddleBanner');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBanner(),
      builder: (context, snapshot) {
        if (snapshot.data == null || middleBanner == null) {
          return Container();
        } else {
          return Container(
            child: Padding(
                padding:
                    EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/products',
                        arguments: ScreenArguments('', 'women', 'kurtis'));
                  },
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(middleBanner[0][0]),
                  ),
                )),
          );
        }
      },
    );
  }
}
