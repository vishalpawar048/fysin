import 'dart:convert';
import '../home/wishListBtn.dart';
import '../shop/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './productGrid.dart';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String website;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.website,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

class Products extends StatelessWidget {
  Future<List> fetchAds() async {
    final response = await http
        .get('https://wishlist-app-a6894.firebaseio.com/MenProducts.json');

    Map products;
    final List productsArray = [];
    if (response.statusCode == 200) {
      products = json.decode(response.body);
      products.forEach((prodId, prodData) {
        productsArray.add(Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
          website: prodData['website'],
        ));
      });
    }
    //print(">>>>>>>>>>${json.decode(productsArray[0])}");
    return productsArray;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            // Flexible(fit: FlexFit.loose, child: Search()),
            Search(),
            WishListBtn(),
          ],
        ),
      ),
      body: FutureBuilder(
          future: fetchAds(),
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
                  return Center(child: Text('Check internet connection'));
                return ProductGrid(productsArray: snapshot.data);
            } // unreachable
          }),
    );
  }
}
