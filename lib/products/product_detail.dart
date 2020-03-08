import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import './productCard.dart';
import '../auth/auth.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetails extends StatelessWidget {
  // final Product product;
  // ProductDetails(this.product);

  @override
  Widget build(BuildContext context) {
    //bool isFavorite = false;
    bool isLoggedIn = false;
    AuthBlock auth = Provider.of<AuthBlock>(context);
    // Product product = ModalRoute.of(context).settings.arguments;
    Product product = Provider.of<Product>(context);

    Future checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        final String emailId = prefs.getString('emailId') ?? "false";

        return product.toggleWishlistStatus(emailId, product.id);
      } else {
        return Navigator.pushNamed(context, '/auth', arguments: "");
      }
    }

    _launchURL() async {
      final String url = product.url;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        elevation: 0.0,
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CarouselSlider(
                autoPlay: false,
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                height: 500.0,
                viewportFraction: 1.0,
                items: product.imageUrls.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: i,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ));
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(-1.0, -1.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          product.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                              ),
                              Text('₹ ${product.price}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    // decoration: TextDecoration.lineThrough
                                  )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('${product.website}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    // decoration: TextDecoration.lineThrough
                                  )),
                            ],
                          ),
                          Row(children: <Widget>[
                            IconButton(
                              icon: product.isFavorite
                                  ? Icon(Icons.favorite, color: Colors.pink)
                                  : Icon(
                                      Icons.favorite_border,
                                    ),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                checkLogin();
                              },
                            ),
                          ]),
//
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )),
                        Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                product.description,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            )),
                        Container(
                            child: Center(
                                child: new RaisedButton(
                          color: Colors.green,
                          // onPressed: _launchURL,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => WebPage(
                                      selectedUrl: product.url,
                                    )));
                          },
                          child: new Text('Buy Now'),
                        ))),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WebPage extends StatelessWidget {
  final String selectedUrl;

  WebPage({
    @required this.selectedUrl,
  });
  WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bruhh'),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
        );
      }),
    );
  }
}
