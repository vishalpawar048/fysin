import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard(this.product);

  final product;

  Widget _buildImageWidget() {
    if (product.imageUrl != null && product.imageUrl != '') {
      print("::::::::::::::::::${product.imageUrl.runtimeType}");
      return SizedBox(
        height: 160,
        child: Hero(
          tag: product,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: product.imageUrl,

            // placeholder: (context, url) =>
            //     Center(child: CircularProgressIndicator()),
            // errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
        ),
      );
      // return Image.network(product.imageUrl);
      // return Image.network('http://uae.microless.com/cdn/no_image.jpg');
    } else {
      return Image.network('http://uae.microless.com/cdn/no_image.jpg');
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
    return Card(
      child: InkWell(
        // onTap: () {
        //   Navigator.pushNamed(context, '/productDetails',
        //       arguments: product["imageUrl"]);
        // },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(
            //   height: 160,
            //   child: Hero(
            //     tag: 'https://uae.microless.com/cdn/no_image.jpg',
            //     child: CachedNetworkImage(
            //       fit: BoxFit.cover,
            //       imageUrl:
            //           "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80",
            //       placeholder: (context, url) =>
            //           Center(child: CircularProgressIndicator()),
            //       errorWidget: (context, url, error) => new Icon(Icons.error),
            //     ),
            //   ),
            // ),
            // CachedNetworkImage(
            //   fit: BoxFit.cover,
            //   imageUrl: 'https://uae.microless.com/cdn/no_image.jpg',
            //   placeholder: (context, url) =>
            //       Center(child: CircularProgressIndicator()),
            //   errorWidget: (context, url, error) => new Icon(Icons.error),
            // ),

            _buildImageWidget(),
            // _buildTitleWidget(),
            // _buildPriceWidget(),
            // _buildLocationWidget(),
          ],
        ),
      ),
    );
  }
}
