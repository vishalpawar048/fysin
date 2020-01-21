import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/fryo_icons.dart';

class CategoriesBtns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //sectionHeader('All Categories', onViewMore: () {}),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Fast Food', Fryo.food, onPressed: () {}),
              headerCategoryItem('Creamery', Fryo.poop, onPressed: () {}),
              headerCategoryItem('Hot Drinks', Fryo.coffee_cup,
                  onPressed: () {}),
              headerCategoryItem('Vegetables', Fryo.leaf, onPressed: () {}),
            ],
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              // width: 86,
              // height: 86,
              child: FloatingActionButton(
                shape: CircleBorder(),
                heroTag: name,
                onPressed: onPressed,
                backgroundColor: Colors.white,
                child: Icon(icon, size: 35, color: Colors.black87),
              )),
          // Text(name + ' ›', style: categoryText)
          Text(name + ' ›')
        ],
      ),
    );
  }
}
