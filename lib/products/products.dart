import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:flutter_scaffold/products/sortAndFilter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../config.dart';
import '../home/wishListBtn.dart';
import '../home/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './productGrid.dart';
import '../apis/productApis.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var emailId;

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailId = prefs.getString('emailId') ?? "false";
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    var keyword = args.keyword;
    var category = args.category;
    var subCategory = args.subCategory;

    // List productArray = [];
    var productsApis = new ProductsApis();

    // productsApis.fetchProducts(context, category, subCategory, keyword);
    // ProductArray productArray = Provider.of<ProductArray>(context);
    // print("Products>>>>>>>>>>>>>>>>${productArray.products}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          Search(),
          WishListBtn(),
        ],
      ),
      // body:
      // Builder(builder: (BuildContext context) {
      //   return FutureBuilder(
      //       future: productsApis.fetchProducts(
      //           context, category, subCategory, keyword),
      //       builder: (BuildContext context, AsyncSnapshot snapshot) {
      //         switch (snapshot.connectionState) {
      //           case ConnectionState.none:
      //             return Center(
      //               child: Text('Try again'),
      //             );
      //           case ConnectionState.active:
      //           case ConnectionState.waiting:
      //             return Center(
      //               child: SpinKitThreeBounce(
      //                 size: 70.0,
      //                 itemBuilder: (context, index) => DecoratedBox(
      //                   decoration: BoxDecoration(
      //                     shape: BoxShape.circle,
      //                     color: Colors.pink,
      //                   ),
      //                 ),
      //               ),
      //             );
      //           case ConnectionState.done:
      //             if (snapshot.hasError) {
      //               return Center(
      //                   child: Text(
      //                       "Something went wrong. Please check your Internet connection.."));
      //             } else {
      //               return ProductGrid(
      //                   productArray: snapshot.data,
      //                   productType: 'product',
      //                   emailId: emailId);
      //             }
      //         } // unreachable
      //       });
      // }),
      // bottomNavigationBar: filter(),
    );
  }
}
