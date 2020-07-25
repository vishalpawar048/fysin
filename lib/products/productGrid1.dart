import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/apis/productApis.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/home/search.dart';
import 'package:flutter_scaffold/home/wishListBtn.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:flutter_scaffold/products/FilterWidget.dart';
import 'package:flutter_scaffold/products/prodGrid.dart';
import 'package:flutter_scaffold/products/products.dart';
import 'package:flutter_scaffold/products/sortAndFilter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import './productCard.dart';
import './grid.dart';

class ProductGrid1 extends StatefulWidget {
  final emailId;
  final List productArray;
  final String productType;

  ProductGrid1({this.productType, this.emailId, this.productArray});

  @override
  _ProductGrid1State createState() => _ProductGrid1State();
}

class _ProductGrid1State extends State<ProductGrid1> {
  var productsApis = new ProductsApis();
  bool isLoaded = false;
  String keyword;
  String category;
  String subCategory;
  var page = 0;
  var limit = 10;
  var sortbyPrice = 0;
  List website = [];
  List<String> selectedSites = [];
  List allSites = [];
  bool filterApplied = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        final ScreenArguments args = ModalRoute.of(context).settings.arguments;

        Websites websites = Provider.of<Websites>(context);
        keyword = args.keyword;
        category = args.category;
        subCategory = args.subCategory;
        website = websites.sites;
        isLoaded = false;
        page = 0;
        sortbyPrice = 0;
        loadWebsites(args.category, args.subCategory);
      });
    });

    super.initState();
  }

  loadWebsites(category, subCategory) async {
    await productsApis.getWebsites(category, subCategory).then((result) {
      result.forEach((website) {
        allSites.add(Website(website));
      });
    });
  }

  var productsArr = [];

  _loadmore() async {
    setState(() {
      // page++;
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sort sort = Provider.of<Sort>(context);
    Websites websites = Provider.of<Websites>(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          actions: <Widget>[
            Search(),
            WishListBtn(),
          ],
        ),
        body: ProductGrid(category, subCategory, keyword, website, sort.sort)
        // height: MediaQuery.of(context).size.height * .93,
        ,
        bottomNavigationBar: filter(category, subCategory, website),
        drawer: FilterDrawer(
          allSites: allSites,
        ));
  }
}
