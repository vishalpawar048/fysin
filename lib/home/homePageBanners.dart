import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePageBanners extends StatelessWidget {
  final List<List> imgList = [
    [
      'https://cdn-images-fishry.azureedge.net/themes/web-small-09408c4-stylo.jpg',
      'women',
      'shoes'
    ],
    [
      'https://www.lillywhites.com/images/marketing/mens-landingpage-carousel-banner-mobile-flexagon.jpg',
      'men',
      'sports'
    ],
    [
      'https://www.ikea.com/images/53/c4/53c4dea19a589227f38e67786c1bd8f1.jpg?f=s',
      'home',
      'living'
    ],
    [
      'https://www.baselondon.com/media/flexslider/xclothing-banner-DT.jpg.pagespeed.ic.0BZBuBplzF.jpg',
      'men',
      't-shirt',
    ],
    [
      'https://saltlickbbq.com/wp-content/uploads/2018/06/red-5oth-mug.jpg',
      'home',
      'coffee mug',
    ],
  ];

  final List<List> squerBanners = [
    [
      'https://i.pinimg.com/564x/d1/a1/04/d1a104c23b48caeac1250942bb1770fc.jpg',
      'men',
      'watch'
    ],
    [
      'https://i.pinimg.com/564x/e3/17/cc/e317ccbcf837cb28a049b81e8a809329.jpg',
      'women',
      'watch'
    ],
    [
      'https://i.pinimg.com/564x/04/0c/b8/040cb881401bda7aac1291b9d60c0790.jpg',
      'men',
      'sweatShirt'
    ],
    [
      'https://i.pinimg.com/564x/5c/32/d8/5c32d8ac3d3859bc4f778998112ac9ca.jpg',
      'women',
      'onePiece'
    ]
  ];

  //https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          height: 180.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: 140.0,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/products',
                              arguments: ScreenArguments(null, i[1], i[2]));
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
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      new Icon(Icons.error),
                                ),
                              ),
                            ),
                            // Container(
                            //     padding: const EdgeInsets.only(top: 5.0),
                            //     child: Center(
                            //         child: Text(
                            //       'Two Gold Rings',
                            //       style: TextStyle(fontSize: 15),
                            //     )))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Container(
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
                  image: NetworkImage(
                      'https://cpimg.tistatic.com/94713/5/template_photo_2.jpg'),
                ),
              )),
        ),
        Container(
          // height: 500.0,
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.only(top: 0, left: 6, right: 6, bottom: 8),
            children: List.generate(4, (index) {
              return Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/products',
                          arguments: ScreenArguments(null,
                              squerBanners[index][1], squerBanners[index][2]));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: (MediaQuery.of(context).size.width / 2) - 14,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: squerBanners[index][0],
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ),
                        // ListTile(
                        //     title: Text(
                        //   'Two Gold Rings',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w700, fontSize: 16),
                        // ))
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Container(
          child: Padding(
              padding:
                  EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 8),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/products',
                      arguments: ScreenArguments('offer', null, ''));
                },
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://image.shutterstock.com/image-vector/summer-sale-background-layout-banners-260nw-678851590.jpg'),
                ),
              )),
        )
      ],
    );
  }
}
