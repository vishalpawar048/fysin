import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'Banners.dart';
import 'CarouselBanner.dart';

class SquareEndBanner extends StatelessWidget {
  List squerBanners;
  final banner = new Banners();
  getBanner() async {
    return squerBanners = await banner.getBanner('SquareEndBanner');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBanner(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null ||
              squerBanners == null ||
              squerBanners.length == 0) {
            return Container();
          } else {
            return Container(
              // height: 500.0,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                padding: EdgeInsets.only(top: 0, left: 6, right: 6, bottom: 8),
                children: List.generate(squerBanners.length, (index) {
                  return Container(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/products',
                              arguments: ScreenArguments(
                                  null,
                                  squerBanners[index][1],
                                  squerBanners[index][2]));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width / 2) - 14,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: squerBanners[index][0],
                                placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                  backgroundColor: Colors.pink[300],
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.lightBlue),
                                )),
                                errorWidget: (context, url, error) =>
                                    new Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }
        });
  }
}
