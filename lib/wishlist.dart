import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/productGrid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocks/auth_block.dart';
import 'config.dart';
import 'notifier/productNotifier.dart';
import 'package:http/http.dart' as http;

class CheckLogin {
  final AuthBlock auth;
  final context;

  CheckLogin(this.auth, this.context);
  checkLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Logout'),
                onPressed: () {
                  auth.logout(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Login'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/auth', arguments: "")
                      .then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class ShowWishList extends StatelessWidget {
  final isLoggedIn;
  final context;

  const ShowWishList({Key key, this.isLoggedIn, this.context})
      : super(key: key);

  Future<List> fetchWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String emailId = prefs.getString('emailId') ?? "false";
    final response = await http.get('$BASE_URL/wishlist/getWishlist/$emailId');
    List products;

    final List productsArray = [];
    if (response.statusCode == 200 &&
        json.decode(response.body)["Status"] == "success") {
      products = json.decode(response.body)["wishlist"];
      products.forEach((prodData) {
        productsArray.add(Product(
          id: prodData['_id'],
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: true,
          imageUrls: prodData['imgUrls'],
          website: prodData['website'],
          url: prodData['url'],
        ));
      });
      return productsArray;
    } else {
      return productsArray;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return FutureBuilder(
          future: fetchWishlist(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Try again'),
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Center(child: Text("Your wishlist is empty"));
                return ProductGrid(
                    productArray: snapshot.data, productType: 'wishlist');
              // return ProductGrid(productType: 'wishlist');
            } // unreachable
          });
    } else {
      return Center(child: Text("You are not logged in.."));
    }
  }
}

class WishList extends StatelessWidget {
  var isLoggedIn = false;

  Future getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    AuthBlock auth = Provider.of<AuthBlock>(context);

    return FutureBuilder(
      future: getAuth(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Wishlist'),
                backgroundColor: Colors.pink[300],
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () => CheckLogin(auth, context).checkLogIn()),
                ]),
            body: ShowWishList(
              isLoggedIn: isLoggedIn,
              context: context,
            ));
      },
    );
  }
}
