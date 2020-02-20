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
        // SizedBox(height: 5),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              headerCategoryItem('All', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Men', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Women', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Gadgets', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Gifts', Fryo.dinner, onPressed: () {}),
              headerCategoryItem('Frieds', Fryo.dinner, onPressed: () {}),
            ],
          ),
        )
      ],
    );
  }

  Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
    return Container(
      margin: EdgeInsets.only(top: 2, left: 15),
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
                elevation: 2.0,
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
