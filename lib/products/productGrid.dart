import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './productCard.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({this.productsArray});

  final List productsArray;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: productsArray.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(productsArray[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
