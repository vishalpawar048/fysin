import 'package:flutter/material.dart';

import 'Banners.dart';
import 'CarouselBanner.dart';

class OfferBanner extends StatelessWidget {
  List offerBanner;
  final banner = new Banners();
  getBanner() async {
    return offerBanner = await banner.getBanner('OfferBanner');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBanner(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot == null ||
              offerBanner == null ||
              offerBanner.length == 0) {
            return Container(
              height: 0,
              width: 0,
            );
          } else {
            return Container(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 0.0, left: 8.0, right: 8.0, bottom: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/products',
                          arguments: ScreenArguments('offer', 'All', 'offer'));
                    },
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(offerBanner[0][0]),
                    ),
                  )),
            );
          }
        });
  }
}
