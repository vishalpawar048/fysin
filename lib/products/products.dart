import 'dart:convert';
import '../home/wishListBtn.dart';
import '../shop/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './productGrid.dart';
import '../home/slider.dart';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  // final String _id;
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final String website;
  bool isFavorite;

  Product({
    // @required this.id,
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
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var keyword = args.keyword;
    // print(">>>>>>>>>>>>>>$keyword");

    Future<List> fetchAds() async {
      final response = await http.post(
          'http://192.168.1.5:3000/products/getProductsByKeyWords/',
          body: {
            'keyword': keyword,
          });
//"http://localhost:3000/products/getProductsByKeyWords/"
      List products;
      final List productsArray = [];
      if (response.statusCode == 200) {
        products = json.decode(response.body)['Product'];
        products.forEach((prodData) {
          productsArray.add(Product(
            //   id: prodData._id,
            name: prodData['name'],
            description: prodData['description'],
            price: prodData['price'],
            // isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imgUrls'][0],
            website: prodData['website'],
          ));
        });
      }
      return productsArray;
    }

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
                if (snapshot.hasError) return Center(child: Text("hi"));
                return ProductGrid(productsArray: snapshot.data);
            } // unreachable
          }),
    );
  }
}
