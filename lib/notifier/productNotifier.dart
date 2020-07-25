import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

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
    var fcmToken;
    notifyListeners();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) async {
      fcmToken = token;
      if (isFavorite) {
        try {
          final response =
              await http.post('$BASE_URL/wishlist/addToWishlist', body: {
            'fcmToken': fcmToken,
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
            'fcmToken': fcmToken,
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
    });
  }
}

class ProductArray with ChangeNotifier {
  List products = [];
  bool sort = false;

  ProductArray({
    this.products,
    this.sort,
  });

  sortArray(products) {
    // products = products.reversed.toList();
    this.products = products.reversed.toList();
    this.sort = true;
    notifyListeners();
  }
}

class Sort with ChangeNotifier {
  int sort = 0;
  // String sort = "0";

  Sort({
    this.sort,
  });

  sortByPrice(newSort) {
    this.sort = newSort;
    notifyListeners();
  }
}

class Websites with ChangeNotifier {
  List sites = [];
  bool filterApplied = false;
  // String sort = "0";

  Websites({this.sites, this.filterApplied});

  getSites(sites) {
    this.sites = sites;
    notifyListeners();
  }

  removeFilter(value) {
    this.filterApplied = !value;

    notifyListeners();
  }
}
