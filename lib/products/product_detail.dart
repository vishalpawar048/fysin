import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false;
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        elevation: 0.0,
        backgroundColor: Colors.pink[300],
        actions: <Widget>[
          IconButton(
              //  padding: EdgeInsets.only(right: 10),
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () => share(
                  context,
                  ShareMsg(
                      url: "https://bruhh.page.link/bruhh",
                      appLink:
                          "\n Hey, Your friend has suggested a link to check out " +
                              product.url))),
        ],
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 500.0,
                child: Carousel(
                  autoplay: false,
                  dotIncreasedColor: Colors.pink[300],
                  indicatorBgPadding: 5,
                  images: product.imageUrls.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            child: InkWell(
                          child: CachedNetworkImage(
                            imageUrl: i,
                            errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                          ),
                        ));
                      },
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            alignment: Alignment(-1.0, -1.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                product.name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 1),
                                child: Text('₹ ${product.price}',
                                    style: TextStyle(
                                      color: Colors.pink[300],
                                      fontSize: 16,
                                      // decoration: TextDecoration.lineThrough
                                    )),
                              ),
                              Row(
                                children: <Widget>[
                                  Text('* Price may varies',
                                      style: TextStyle(
                                        color: Colors.black,

                                        fontSize: 10,
                                        // decoration: TextDecoration.lineThrough
                                      )),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('${product.website}',
                                  style: TextStyle(
                                      fontFamily: 'DancingScript',
                                      color: Colors.pink[300],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                      // decoration: TextDecoration.lineThrough
                                      )),
                            ],
                          ),
                          Row(children: <Widget>[
                            IconButton(
                              icon: product.isFavorite
                                  ? Icon(Icons.favorite,
                                      color: Colors.pink[300])
                                  : Icon(Icons.favorite_border,
                                      color: Colors.pink),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 45,
                                width: 130,
                                margin: EdgeInsets.only(bottom: 10),
                                child: InkWell(
                                  child: Center(
                                    child: Text(
                                      "Buy Now..",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                WebPage(
                                                  selectedUrl: product.url,
                                                )));
                                  },
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.pink[300],
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                        // color: Colors.black54,
                                        color: Colors.pink[300],
                                        // color: Colors.black54,
                                        offset: Offset(0.0, 4),
                                        blurRadius: 10.0)
                                  ],
                                ),
                              )
                            ]),
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

class ShareMsg {
  String url;
  String appLink;

  ShareMsg({@required this.url, @required this.appLink});
}

share(BuildContext context, ShareMsg msg) {
  final RenderBox box = context.findRenderObject();

  Share.share("${msg.url} - ${msg.appLink}",
      subject: "bruhh",
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
}

class WebPage extends StatelessWidget {
  final String selectedUrl;

  WebPage({
    @required this.selectedUrl,
  });
  // WebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bruhh'),
        backgroundColor: Colors.pink[300],
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: selectedUrl,
          javascriptMode: JavascriptMode.unrestricted,
        );
      }),
    );
  }
}
