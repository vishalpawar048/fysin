import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import './productCard.dart';

class ProductGrid extends StatefulWidget {
  final emailId;

  ProductGrid({this.productsArray, this.productType, this.emailId});

  final List productsArray;
  final String productType;

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List<Product> data = [];
  List<String> img = [];
  int currentLength = 0;

  final int increment = 20;
  bool isLoading = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
    });

    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(widget.productsArray[i]);
      img.add(widget.productsArray[i].imageUrls[0]);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.productsArray.length > 0) {
      return LazyLoadScrollView(
        onEndOfPage: () => _loadMore(),
        isLoading: isLoading,
        child: new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: data.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
            value: data[i],
            child: ProductCard(img[i], data[i], widget.emailId),
          ),
          staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2.7),
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
        ),
      );
    } else {
      if (widget.productType == "wishlist") {
        return Center(child: Text("Hey! Your wishlist is empty.."));
      } else {
        return Center(child: Text("Sorry! No result available.."));
      }
    }
  }
}
