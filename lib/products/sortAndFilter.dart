import 'package:flutter/material.dart';
import 'package:flutter_scaffold/home/CarouselBanner.dart';
import 'package:flutter_scaffold/notifier/productNotifier.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'FilterWidget.dart';

class filter extends StatefulWidget {
  final String category;
  final String subCategory;
  final List website;

  filter(this.category, this.subCategory, this.website);
  @override
  _filterState createState() => _filterState();
}

class _filterState extends State<filter> {
  int _selectedIndex = 0;
  List webSites = [];

  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _sortSheet(context, widget.category, widget.subCategory, widget.website);
      //return productArray.sortArray([]);
    } else {
      // // _filterSheet(context);
      // _showReportDialog();
      Scaffold.of(context).openDrawer();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  List values = ["abc", "ccc"];
  bool imp = false;
  _showReportDialog() {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text('Add'),
        content: Container(
          child: Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text('Important:'),
                value: imp,
                onChanged: (value) {
                  setState(() {
                    imp = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      // child: AlertDialog(
      //   title: new Text("My Super title"),
      //   content:

      //       // height: double.infinity, // Change as per your requirement
      //       // width: double.infinity, // Change as per your requirement
      //       Container(
      //     height: 100, // Change as per your requirement
      //     width: 400,
      //     child: ListView.builder(
      //         shrinkWrap: true,
      //         itemCount: values.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           return CheckboxListTile(
      //             title: Text(values[index]),
      //             value: timeDilation != 1.0,
      //             onChanged: (bool value) {
      //               // setState(() {
      //               //   timeDilation = value ? 2.0 : 1.0;
      //               // });
      //             },
      //             // secondary: const Icon(Icons.hourglass_empty),
      //           );
      //         }),
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_vert),
          title: Text('Sort'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tune),
          title: Text('Filter'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.pink[300],
      unselectedItemColor: Colors.pink[300],
      onTap: _onItemTapped,
    );
  }
}

void _sortSheet(context, category, subCategory, website) {
  Sort sort = Provider.of<Sort>(context);
  print(">>>>>>>>>>>>>>>>category$category");
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back) // the arrow back icon
                        ),
                  ),
                  title:
                      Center(child: Text("Sort by Price") // Your desired title
                          )),
              new ListTile(
                title: new Text('Low to High'),
                onTap: () {
                  sort.sortByPrice(1);
                  Navigator.pushNamed(context, '/productGrid1',
                          arguments: ScreenArguments('', category, subCategory))
                      .then((value) => Navigator.of(context).pop());
                },
              ),
              new ListTile(
                title: new Text('High to Low'),
                onTap: () => {
                  sort.sortByPrice(-1),
                  Navigator.pushNamed(context, '/productGrid1',
                          arguments: ScreenArguments('', category, subCategory))
                      .then((value) => Navigator.of(context).pop())
                },
              ),
            ],
          ),
        );
      });
}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
