import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../home/wishListBtn.dart';
import '../shop/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './productGrid.dart';
import '../home/slider.dart';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  String id;
  String name;
  String description;
  String price;
  List imageUrls;
  String website;
  String url;
  bool isFavorite;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrls,
    this.website,
    this.url,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleWishlistStatus(emailId, id) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    if (isFavorite) {
      try {
        final response =
            await http.post('$BASE_URL/wishlist/addToWishlist', body: {
          'emailId': emailId,
          'productId': id,
        });
        if (response.statusCode >= 400) {
          _setFavValue(oldStatus);
        }
      } catch (error) {
        _setFavValue(oldStatus);
      }
    } else {
      try {
        final response =
            await http.post('$BASE_URL/wishlist/removefromWishlist', body: {
          'emailId': emailId,
          'productId': id,
        });
        if (response.statusCode >= 400) {
          _setFavValue(oldStatus);
        }
      } catch (error) {
        _setFavValue(oldStatus);
      }
    }
  }
}

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var keyword = args.keyword;

    Future<List> fetchProducts() async {
      List wishlistIds;
      List wishlistArray = [];
      List products;
      final List productsArray = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String emailId = prefs.getString('emailId') ?? "false";
      final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      final response =
          await http.post('$BASE_URL/products/getProductsByKeyWords/', body: {
        'keyword': keyword,
      });

      if (response.statusCode == 200) {
        products = json.decode(response.body)['Product'];
        products.forEach((prodData) {
          productsArray.add(Product(
            id: prodData['_id'],
            name: prodData['name'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: wishlistArray.contains(prodData['_id']),
            imageUrls: prodData['imgUrls'],
            website: prodData['website'],
            url: prodData['url'],
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
          future: fetchProducts(),
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
                  return Center(
                      child: Text(
                          "Something went wrong. Please try after some time.."));
                return ProductGrid(
                    productsArray: snapshot.data, productType: 'product');
            } // unreachable
          }),
    );
  }
}
