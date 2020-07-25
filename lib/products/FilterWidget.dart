import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/apis/productApis.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:provider/provider.dart';

class Website {
  String name;
  bool selected;

  Website(
    this.name,
  ) : selected = false;
}

class FilterDrawer extends StatefulWidget {
  // final String category;
  // final String subCategory;
  final List allSites;

  FilterDrawer({
    // this.category,
    // this.subCategory,
    this.allSites,
  });
// category, subCategory, website
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  bool _isSelected = false;
  var productsApis = new ProductsApis();
  List websites = [];
  List sites = [];

  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    // loadWebsites();
    sites = widget.allSites;
    super.initState();
  }

  // loadWebsites() async {
  //   await productsApis
  //       .getWebsites(widget.category, widget.subCategory, widget.subCategory)
  //       .then((result) {
  //     result.forEach((website) {
  //       sites.add(Website(website));
  //     });
  //   });

  //   setState(() {
  //     sites = sites;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Websites websites = Provider.of<Websites>(context);
    return Container(
        width: MediaQuery.of(context).size.width * 1.00,
        child: Drawer(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: IconButton(
                      icon: Icon(Icons.chevron_left,
                          size: 40, color: Colors.pink),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 270, top: 50),
                    child: MaterialButton(
                      child: Text('Apply'),
                      onPressed: () {
                        List selectedSites = [];
                        sites.forEach((website) {
                          if (website.selected) {
                            selectedSites.add(website.name);
                          }
                        });
                        websites.getSites(selectedSites);
                        websites.removeFilter(false);

                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ]),
              ),
              Flexible(
                child: Column(
                  children: [
                    Text("Trusted"),
                    Flexible(
                      child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: sites.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CheckboxListTile(
                              title: Text(sites[index].name),
                              value: sites[index].selected,
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.pink[300],
                              onChanged: (value) {
                                setState(() {
                                  sites[index].selected = value;
                                });
                              },
                              // secondary: const Icon(Icons.hourglass_empty),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              //****************IMPORTANT DO NOT DELETE***************
              // Flexible(
              //   child: Column(
              //     children: [
              //       Text("Others"),
              //       Flexible(
              //         child: ListView.builder(
              //             controller: _scrollController,
              //             shrinkWrap: true,
              //             itemCount: websites.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               return CheckboxListTile(
              //                 title: Text(websites[index]),
              //                 value: _isSelected,
              //                 controlAffinity: ListTileControlAffinity.leading,
              //                 activeColor: Colors.pink[300],
              //                 onChanged: (value) {
              //                   setState(() {
              //                     _isSelected = value;
              //                   });
              //                 },
              //                 // secondary: const Icon(Icons.hourglass_empty),
              //               );
              //             }),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
