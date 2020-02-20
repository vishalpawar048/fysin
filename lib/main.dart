import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/auth/auth.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:flutter_scaffold/cart.dart';
import 'package:flutter_scaffold/categorise.dart';
import 'package:flutter_scaffold/home/home.dart';
import 'package:flutter_scaffold/localizations.dart';
import './products/product_detail.dart';
import 'package:flutter_scaffold/settings.dart';
import 'package:flutter_scaffold/shop/shop.dart';
import 'package:flutter_scaffold/wishlist.dart';
import 'package:provider/provider.dart';
import './products/products.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Locale locale = Locale('en');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthBlock>.value(value: AuthBlock()),
      ChangeNotifierProvider<Product>.value(value: Product()),
    ],
    child: MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [Locale('en'), Locale('ar')],
      locale: locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // primaryColor: Colors.deepOrange[500],
          primaryColor: Colors.white,
          accentColor: Colors.black,
          //hintColor: Color(0xffbfc2c5),
          fontFamily: locale.languageCode == 'ar' ? 'Dubai' : 'Lato'),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => Home(),
        '/auth': (BuildContext context) => Auth(),
        '/shop': (BuildContext context) => Shop(),
        '/categorise': (BuildContext context) => Categorise(),
        '/cart': (BuildContext context) => CartList(),
        '/settings': (BuildContext context) => Settings(),
        '/products': (BuildContext context) => Products(),
        '/productDetails': (BuildContext context) => ProductDetails(),
        '/products': (BuildContext context) => Products(),
        '/wishList': (BuildContext context) => WishList(),
      },
    ),
  ));
}
