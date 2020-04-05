import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_scaffold/config.dart';
import 'package:flutter_scaffold/products/product_detail.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cache_image/cache_image.dart';

class ProductArg {
  Product product;
}

class ProductCard extends StatelessWidget {
  final Product product;
  final emailId;
  ProductCard(this.product, this.emailId);

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

    if (product.imageUrls[0] != null && product.imageUrls[0] != '') {
      String imageUrl = product.imageUrls[0];
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
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
            // Navigator.of(context).pushNamed('/productDetails');
            // Navigator.pushNamed(context, '/productDetails');
          },
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/loading.gif'),
                      // placeholder: AssetImage('assets/placeholder.png'),
                      // placeholder: (context, url) => Center(
                      //           child: CircularProgressIndicator(
                      //         backgroundColor: Colors.pink[300],
                      //         valueColor: new AlwaysStoppedAnimation<Color>(
                      //             Colors.lightBlue),
                      //       )),
                      image: CacheImage(
                        imageUrl,
                      )),
                  // child: CachedNetworkImage(imageUrl: CacheImage(imageUrl)),
                  // child: FadeInImage.assetNetwork(
                  //   placeholder: 'assets/images/loading.gif',
                  //   fit: BoxFit.cover,
                  //   image: imageUrl,
                  // ),
                ),
              ),
              Positioned(
                  right: 1.0,
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
              emailId == 'vishalpawar048@gmail.com'
                  ? Positioned(
                      right: 1.0,
                      bottom: 1.0,
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

  // Widget _buildTitleWidget() {
  //   if (product.name != null && product.name != '') {
  //     return Text(
  //       product.name,
  //       style: TextStyle(fontWeight: FontWeight.bold),
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }

  // Widget _buildPriceWidget() {
  //   if (product.price != null && product.price != '') {
  //     return Text("\$ ${product.price}");
  //   } else {
  //     return SizedBox();
  //   }
  // }

  // Widget _buildLocationWidget() {
  //   if (product.website != null && product.website != '') {
  //     return Row(
  //       children: <Widget>[
  //         Icon(Icons.location_on),
  //         SizedBox(
  //           width: 4.0,
  //         ),
  //         Expanded(child: Text(product.website))
  //       ],
  //     );
  //   } else {
  //     return SizedBox();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // return Card(child: _buildImageWidget()

    return _buildImageWidget(context);
  }
}
