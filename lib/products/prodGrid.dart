import 'package:flutter/material.dart';
import 'package:flutter_scaffold/apis/productApis.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:flutter_scaffold/products/grid.dart';
import 'package:flutter_scaffold/products/productCard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  final String category;
  final String subCategory;
  final String keyword;
  final List website;
  final int sort;

  ProductGrid(
      this.category, this.subCategory, this.keyword, this.website, this.sort);
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  bool isLoaded = false;
  List sites = [];
  List data = [];
  var productsApis = new ProductsApis();
  _loadmore() async {
    setState(() {
      // page++;
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Websites websites = Provider.of<Websites>(context);

    if (sites != widget.website) {
      sites = widget.website;
    }

    return Container(
        child: FutureBuilder(
            future: productsApis.fetchProducts(
                context,
                widget.category,
                widget.subCategory,
                widget.keyword,
                widget.website,
                widget.sort),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GridAnimate(
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrolling) {
                        if (!isLoaded &&
                            scrolling.metrics.pixels ==
                                scrolling.metrics.maxScrollExtent) {
                          isLoaded = true;

                          _loadmore();
                        }
                        return isLoaded;
                      },
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 4,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (ctx, i) =>
                            ChangeNotifierProvider<Product>.value(
                          value: snapshot.data[i],
                          child: ProductCard(snapshot.data[i], ""),
                        ),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.count(2, 2.7),
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SpinKitThreeBounce(
                    size: 70.0,
                    itemBuilder: (context, index) => DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
