import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';

class CategoriesBtns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              headerCategoryItem(
                'New',
                "assets/images/new.jpg",
                context,
                onPressed: () {},
              ),
              headerCategoryItem('Men', "assets/images/men.jpg", context,
                  onPressed: () {}),
              headerCategoryItem('Women', "assets/images/women.jpg", context,
                  onPressed: () {}),
              headerCategoryItem(
                  'Gadgets', "assets/images/gadgets.jpg", context,
                  onPressed: () {}),
              headerCategoryItem('Gifts', "assets/images/gifts.jpg", context,
                  onPressed: () {}),
            ],
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, String imgUrl, context, {onPressed}) {
    return Container(
      margin: EdgeInsets.only(top: 2, right: 10, left: 10, bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/products',
                      arguments: ScreenArguments(null, name, ''));
                },
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          // fit: BoxFit.cover, image: new NetworkImage(imgUrl))),
                          fit: BoxFit.cover,
                          image: new AssetImage(imgUrl))),
                ),
              ),
            ],
          ),

          // Text(name + ' ›', style: categoryText)
          Text(name + ' ›')
        ],
      ),
    );
  }
}
