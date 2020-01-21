import 'package:flutter/material.dart';

class WishListBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        child: new RawMaterialButton(
          constraints: BoxConstraints.tight(Size(36, 36)),
          shape: new CircleBorder(),
          fillColor: Colors.pink[100],
          elevation: 0.0,
          child: Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/categories');
          },
        ));
  }
}
