import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:flutter_scaffold/products/sortAndFilter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import './productCard.dart';
import './grid.dart';

class ProductGrid extends StatefulWidget {
  final emailId;
  final List productArray;
  final String productType;

  ProductGrid({this.productType, this.emailId, this.productArray});

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
    // _loadmore();

    super.initState();
  }

  _loadmore() async {
    if (widget.productArray.length < increment) {
      for (var i = 0; i < widget.productArray.length; i++) {
        data.add(widget.productArray[i]);
        img.add(widget.productArray[i].imageUrls[0]);
      }
      setState(() {
        isLoading = true;
        currentLength = data.length;
      });
    } else {
      for (var i = currentLength; i <= currentLength + increment; i++) {
        data.add(widget.productArray[i]);
        img.add(widget.productArray[i].imageUrls[0]);
      }
      setState(() {
        isLoading = false;
        currentLength = data.length;
      });
    }
  }

  // _loadmore() async {
  //   if (productArray.products.length < increment) {
  //     for (var i = 0; i < productArray.products.length; i++) {
  //       data.add(productArray.products[i]);
  //       img.add(productArray.products[i].imageUrls[0]);
  //     }
  //     setState(() {
  //       isLoading = true;
  //       currentLength = data.length;
  //     });
  //   } else {
  //     for (var i = currentLength; i <= currentLength + increment; i++) {
  //       data.add(productArray.products[i]);
  //       img.add(productArray.products[i].imageUrls[0]);
  //     }
  //     setState(() {
  //       isLoading = false;
  //       currentLength = data.length;
  //     });
  //   }
  // }

//Test this
  // _loadmore() async {
  //   Navigator.pushNamed(context, '/products',
  //       arguments: ScreenArguments('', 'men', 'shoes'));
  //   isLoading = false;
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.productArray.length > 0) {
      return GridAnimate(
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrolling) {
              if (!isLoading &&
                  scrolling.metrics.pixels ==
                      scrolling.metrics.maxScrollExtent) {
                setState(() {
                  isLoading = true;
                });
                _loadmore();
              }
              return isLoading;
            },
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: widget.productArray.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
                value: widget.productArray[i],
                child: ProductCard(widget.productArray[i], widget.emailId),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, 2.7),
            ),
          ),
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
