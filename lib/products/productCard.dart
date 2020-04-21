import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/products/product_detail.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import "dart:math";

class ProductArg {
  Product product;
}

class ProductCard extends StatelessWidget {
  final String img;
  final Product product;
  final emailId;
  ProductCard(this.img, this.product, this.emailId);

  static List<Color> colors = [
    Colors.pink[200],
    Colors.pinkAccent[200],
    Colors.cyan[200],
    Colors.grey[200],
    Colors.amber[200]
  ];

// generates a new Random object
  static var _random = new Random();

// generate a random index based on the list length
// and use it to retrieve the element
  // Color color = list[_random.nextInt(list.length)];

  Widget _buildImageWidget(context) {
    Product product = Provider.of<Product>(context);
    Future checkLogin() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (isLoggedIn) {
        final String emailId = prefs.getString('emailId') ?? "false";

        return product.toggleWishlistStatus(emailId, product.id);
      } else {
        return Navigator.pushNamed(context, '/auth', arguments: "");
      }
    }

    deleteProduct(id) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Product'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Delete'),
                onPressed: () async {
                  await http.post('$BASE_URL/products/deleteProduct/', body: {
                    'id': id
                  }).then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          );
        },
      );
    }

    if (img != null && img != '') {
      String imageUrl = img;
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider<Product>.value(
                  value: product,
                  child: ProductDetails(),
                );
              },
            ),
          );
        },
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Hero(
            //   tag: product.id,
            //   child: Container(
            //     margin: EdgeInsets.only(left: 10, right: 10),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(
            //         10.0,
            //       ),
            //       child: CachedNetworkImage(
            //         // fit: BoxFit.fill,
            //         fadeInCurve: Curves.easeInCubic,
            //         fadeInDuration: Duration(milliseconds: 900),
            //         //     margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            //         imageUrl: imageUrl,
            //         // alignment: Alignment.center,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       color: colors[_random.nextInt(3)],
            //       borderRadius: BorderRadius.circular(
            //         10.0,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  // width: 80.0,
                  // height: 80.0,
                  // margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                // placeholder: (context, url) => Center(
                //     child: CircularProgressIndicator(
                //   backgroundColor: Colors.pink[300],
                //   valueColor:
                //       new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                // )),
              ),
              decoration: BoxDecoration(
                color: colors[_random.nextInt(3)],
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
              ),
            ),
            Positioned(
                right: 10.0,
                top: 1.0,
                child: IconButton(
                  icon: product.isFavorite
                      ? Icon(Icons.favorite, color: Colors.pink)
                      : Icon(Icons.favorite_border, color: Colors.pink),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    checkLogin();
                  },
                )),
            emailId == 'vishalpawar048@gmail.com' ||
                    emailId == 'bruhhdevteam@gmail.com'
                ? Positioned(
                    right: 3.0,
                    bottom: 15.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        deleteProduct(product.id);
                      },
                    ))
                : Container()
          ],
        ),
      );

      // return
    } else {
      return FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: 'http://uae.microless.com/cdn/no_image.jpg',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Card(child: _buildImageWidget()

    return _buildImageWidget(context);
  }
}
