import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import './productCard.dart';
import './grid.dart';

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
    _loadmore();
    super.initState();
  }

  _loadmore() async {
    for (var i = currentLength; i <= currentLength + increment; i++) {
      data.add(widget.productsArray[i]);
      img.add(widget.productsArray[i].imageUrls[0]);
    }
    setState(() {
      isLoading = false;
      currentLength = data.length;
    });
  }

  // Future _loadMore() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   for (var i = currentLength; i <= currentLength + increment; i++) {
  //     data.add(widget.productsArray[i]);
  //     img.add(widget.productsArray[i].imageUrls[0]);
  //   }
  //   setState(() {
  //     isLoading = false;
  //     currentLength = data.length;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.productsArray.length > 0) {
      return GridAnimate(
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrolling) {
              if (!isLoading &&
                  scrolling.metrics.pixels ==
                      scrolling.metrics.maxScrollExtent) {
                _loadmore();
                setState(() {
                  isLoading = true;
                });
              }
              return isLoading;
            },
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              crossAxisSpacing: 0.0,
              mainAxisSpacing: 0.0,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
                value: data[i],
                child: ProductCard(img[i], data[i], widget.emailId),
              ),
              // itemBuilder: (c, i) => InkWell(
              //   onTap: () {
              //     // createInterstitialAd()
              //     //   ..load()
              //     //   ..show();
              //     // Navigator.pushNamed(
              //     //   context,
              //     //   Frazile.fullImage,
              //     //   arguments: FullImageArguments(
              //     //     snapshot.data[i].urls.full,
              //     //     snapshot.data[i].urls.regular,
              //     //   ),
              //     // );
              //   },
              // child: Hero(
              //   tag: data[i].id,
              //   child: Container(
              //     margin: EdgeInsets.only(bottom: 20),
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(
              //         10.0,
              //       ),
              //       child: CachedNetworkImage(
              //         // fit: BoxFit.fill,
              //         fadeInCurve: Curves.easeInCubic,
              //         fadeInDuration: Duration(milliseconds: 900),
              //         imageUrl: data[i].imageUrls[0],
              //         // alignment: Alignment.center,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.pink,
              //       borderRadius: BorderRadius.circular(
              //         10.0,
              //       ),
              //     ),
              //   ),
              // ),
              // ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(2, 2.7),
              // staggeredTileBuilder: (i) =>
              //     StaggeredTile.count(2, i.isEven ? 2 : 3),
            ),
          ),
        ),
      );
      // ),
      // Positioned(
      //   left: MediaQuery.of(context).size.width * .1,
      //   right: MediaQuery.of(context).size.width * .1,
      //   bottom: MediaQuery.of(context).size.height * .02,
      //   child: isLoading
      //       ? SpinKitChasingDots(
      //           size: 80.0,
      //           itemBuilder: (context, index) => DecoratedBox(
      //             decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               gradient: LinearGradient(
      //                 colors: FzColors().getListColors(
      //                   [
      //                     "#9400D3",
      //                     "#4B0082",
      //                     "#0000FF",
      //                     "#00FF00",
      //                     "#FFFF00",
      //                     "#FF7F00",
      //                     "#FF0000"
      //                   ],
      //                 ),
      //                 tileMode: TileMode.clamp,
      //                 begin: Alignment.topLeft,
      //                 end: Alignment.bottomRight,
      //                 stops: [
      //                   0.0,
      //                   0.14285714285714285,
      //                   0.2857142857142857,
      //                   0.42857142857142855,
      //                   0.5714285714285714,
      //                   0.7142857142857143,
      //                   0.8571428571428571
      //                 ],
      //               ),
      //             ),
      //           ),
      //         )
      //       : Container(),
      // ),
      // return LazyLoadScrollView(
      //   onEndOfPage: () => _loadMore(),
      //   isLoading: isLoading,
      //   child: new StaggeredGridView.countBuilder(
      //     crossAxisCount: 4,
      //     itemCount: data.length,
      //     itemBuilder: (ctx, i) => ChangeNotifierProvider<Product>.value(
      //       value: data[i],
      //       child: ProductCard(img[i], data[i], widget.emailId),
      //     ),
      //     staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2.7),
      //     mainAxisSpacing: 0.0,
      //     crossAxisSpacing: 0.0,
      //   ),
      // );
    } else {
      if (widget.productType == "wishlist") {
        return Center(child: Text("Hey! Your wishlist is empty.."));
      } else {
        return Center(child: Text("Sorry! No result available.."));
      }
    }
  }
}
