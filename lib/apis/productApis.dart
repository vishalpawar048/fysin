import 'dart:convert';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../config.dart';

class ProductsApis {
  //To fetch all products
  var page = -1;
  List productsArr = [];
  bool filterApplied = false;
  Future<List> fetchProducts(
      context, category, subCategory, keyword, website, sort) async {
    List wishlistArray = [];
    List products;
    Websites websites = Provider.of<Websites>(context);
    if (websites.filterApplied == true) {
      page = -1;
      productsArr = [];
      new Future.delayed(
          const Duration(milliseconds: 20), websites.removeFilter(true));
      //
    }
    page++;
    final Map<dynamic, dynamic> data = {
      "category": category,
      "subCategory": subCategory == null ? "" : subCategory,
      "page": page.toString(),
      "website": jsonEncode(website),
      "sort": sort == null ? "0" : sort.toString()
    };

    // print(">>>>>>>>>>>ss2$data");

    var response;
    if (category == null && keyword != "" && keyword != null) {
      response = await http.post('$BASE_URL/products/getProductsByKeyWords/',
          body: {'keyword': keyword});
    } else if (category != null) {
      response = await http.post('$BASE_URL/products/getProductsByCategory/',
          body: data);
    } else {}

    if (response.statusCode == 200) {
      products = json.decode(response.body)['Product'];
      products.forEach((prodData) {
        productsArr.add(Product(
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
      return productsArr;
    }
  }

  getWebsites(
    category,
    subCategory,
  ) async {
    var response;
    response = await http.post('$BASE_URL/products/getWebsites',
        body: {'category': category, 'subCategory': subCategory});
    var resp = json.decode(response.body);
    return resp['website'];
  }
}
