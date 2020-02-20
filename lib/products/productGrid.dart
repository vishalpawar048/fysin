import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import './productCard.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({this.productsArray});

  final List productsArray;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: productsArray.length,
      // itemBuilder: (BuildContext context, int index) {
      //   return ProductCard(productsArray[index]);
      // },
      itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
        // builder: (c) => products[i],
        value: productsArray[i],
        child: ProductCard(productsArray[i]),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 0.0,
      crossAxisSpacing: 0.0,
    );
  }
}
