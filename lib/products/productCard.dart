import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  ProductCard(this.product);

  final product;

  Widget _buildImageWidget() {
    if (product.imageUrl != null && product.imageUrl != '') {
      return Image.network(product.imageUrl);
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
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
        onTap: () {
          Navigator.pushNamed(context, '/productDetails',
              arguments: product["imageUrl"]);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageWidget(),
            _buildTitleWidget(),
            _buildPriceWidget(),
            _buildLocationWidget(),
          ],
        ),
      ),
    );
  }
}
