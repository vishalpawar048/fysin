import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/auth/auth.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import './home/categorise.dart';
import 'package:flutter_scaffold/home/home.dart';
import './products/product_detail.dart';
import 'package:flutter_scaffold/wishlist.dart';
import 'package:provider/provider.dart';
import './products/products.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock()),
      ChangeNotifierProvider<Product>.value(value: Product()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Colors.deepOrange[500],
        primaryColor: Colors.white,
        accentColor: Colors.black,
        //hintColor: Color(0xffbfc2c5),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        '/auth': (BuildContext context) => Auth(),
        '/categorise': (BuildContext context) => Categorise(),
        '/products': (BuildContext context) => Products(),
        '/productDetails': (BuildContext context) => ProductDetails(),
        '/products': (BuildContext context) => Products(),
        '/wishList': (BuildContext context) => WishList(),
      },
    ),
  ));
}
