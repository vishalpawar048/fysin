import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/product_detail.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductArg {
  Product product;
}

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product);

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

    if (product.imageUrls[0] != null && product.imageUrls[0] != '') {
      String imageUrl = product.imageUrls[0];
      String price = product.price;
      return Card(
        child: InkWell(
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
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading_1.gif',
                image: imageUrl,
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
              Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Text(
                    '₹ $price',
                    textAlign: TextAlign.right,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ))
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

  Widget _buildTitleWidget() {
    if (product.name != null && product.name != '') {
      return Text(
        product.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildPriceWidget() {
    if (product.price != null && product.price != '') {
      return Text("\$ ${product.price}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildLocationWidget() {
    if (product.website != null && product.website != '') {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(
            width: 4.0,
          ),
          Expanded(child: Text(product.website))
        ],
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Card(child: _buildImageWidget()

    return _buildImageWidget(context);
  }
}
