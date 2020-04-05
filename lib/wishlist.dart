import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/products/productGrid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocks/auth_block.dart';
import 'config.dart';
import 'products/products.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// class WishList extends StatefulWidget {
//   @override
//   _WishlistState createState() => _WishlistState();
// }

// class _WishlistState extends State<WishList> {
//   final List<Map<dynamic, dynamic>> products = [
//     {
//       'name': 'IPhone',
//       'rating': 3.0,
//       'image':
//           'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'
//     },
//     {
//       'name': 'IPhone X 2',
//       'rating': 3.0,
//       'image':
//           'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 11',
//       'rating': 4.0,
//       'image':
//           'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'
//     },
//     {
//       'name': 'IPhone 12',
//       'rating': 5.0,
//       'image':
//           'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Wishlist'), actions: <Widget>[
//         IconButton(icon: Icon(Icons.account_circle), onPressed: () => {})
//       ]),
//       body: ListView.builder(
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           final item = products[index];
//           return Dismissible(
//             // Each Dismissible must contain a Key. Keys allow Flutter to
//             // uniquely identify widgets.
//             key: Key(UniqueKey().toString()),
//             // Provide a function that tells the app
//             // what to do after an item has been swiped away.
//             onDismissed: (direction) {
//               if (direction == DismissDirection.endToStart) {
//                 // Then show a snackbar.
//                 Scaffold.of(context).showSnackBar(SnackBar(
//                     content: Text(item['name'] + " dismissed"),
//                     duration: Duration(seconds: 1)));
//               } else {
//                 // Then show a snackbar.
//                 Scaffold.of(context).showSnackBar(SnackBar(
//                     content: Text(item['name'] + " added to carts"),
//                     duration: Duration(seconds: 1)));
//               }
//               // Remove the item from the data source.
//               setState(() {
//                 products.removeAt(index);
//               });
//             },
//             // Show a red background as the item is swiped away.
//             background: Container(
//               decoration: BoxDecoration(color: Colors.green),
//               padding: EdgeInsets.all(5.0),
//               child: Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0),
//                     child: Icon(Icons.add_shopping_cart, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             secondaryBackground: Container(
//               decoration: BoxDecoration(color: Colors.red),
//               padding: EdgeInsets.all(5.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20.0),
//                     child: Icon(Icons.delete, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             child: InkWell(
//               onTap: () {
//                 print('Card tapped.');
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Divider(
//                     height: 0,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
//                     child: ListTile(
//                       trailing: Icon(Icons.swap_horiz),
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(5.0),
//                         child: Container(
//                           decoration: BoxDecoration(color: Colors.blue),
//                           child: CachedNetworkImage(
//                             fit: BoxFit.cover,
//                             imageUrl: item['image'],
//                             placeholder: (context, url) =>
//                                 Center(child: CircularProgressIndicator()),
//                             errorWidget: (context, url, error) =>
//                                 new Icon(Icons.error),
//                           ),
//                         ),
//                       ),
//                       title: Text(
//                         item['name'],
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 2.0, bottom: 1),
//                                 child: Text('\$200',
//                                     style: TextStyle(
//                                       color: Theme.of(context).accentColor,
//                                       fontWeight: FontWeight.w700,
//                                     )),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 6.0),
//                                 child: Text('(\$400)',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w700,
//                                         fontStyle: FontStyle.italic,
//                                         color: Colors.grey,
//                                         decoration:
//                                             TextDecoration.lineThrough)),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: <Widget>[
//                               SmoothStarRating(
//                                   allowHalfRating: false,
//                                   starCount: 5,
//                                   rating: item['rating'],
//                                   size: 16.0,
//                                   color: Colors.amber,
//                                   borderColor: Colors.amber,
//                                   spacing: 0.0),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 6.0),
//                                 child: Text('(4)',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w300,
//                                         color: Theme.of(context).primaryColor)),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:http/http.dart' as http;

class CheckLogin {
  final AuthBlock auth;
  final context;

  CheckLogin(this.auth, this.context);
  checkLogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Logout'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Logout'),
                onPressed: () {
                  auth.logout(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login'),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Login'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/auth', arguments: "")
                      .then((value) => Navigator.of(context).pop());
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class ShowWishList extends StatelessWidget {
  final isLoggedIn;
  final context;

  const ShowWishList({Key key, this.isLoggedIn, this.context})
      : super(key: key);

  Future<List> fetchWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String emailId = prefs.getString('emailId') ?? "false";
    final response = await http.get('$BASE_URL/wishlist/getWishlist/$emailId');
    List products;

    final List productsArray = [];
    if (response.statusCode == 200 &&
        json.decode(response.body)["Status"] == "success") {
      products = json.decode(response.body)["wishlist"];
      products.forEach((prodData) {
        productsArray.add(Product(
          id: prodData['_id'],
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: true,
          imageUrls: prodData['imgUrls'],
          website: prodData['website'],
          url: prodData['url'],
        ));
      });
      return productsArray;
    } else {
      return productsArray;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      return FutureBuilder(
          future: fetchWishlist(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: Text('Try again'),
                );
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError)
                  return Center(child: Text("Your wishlist is empty"));
                return ProductGrid(
                    productsArray: snapshot.data, productType: 'wishlist');
            } // unreachable
          });
    } else {
      return Center(child: Text("You are not logged in.."));
    }
  }
}

class WishList extends StatelessWidget {
  var isLoggedIn = false;

  Future getAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    AuthBlock auth = Provider.of<AuthBlock>(context);

    return FutureBuilder(
      future: getAuth(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Wishlist'),
                backgroundColor: Colors.pink[300],
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () => CheckLogin(auth, context).checkLogIn()),
                ]),
            body: ShowWishList(
              isLoggedIn: isLoggedIn,
              context: context,
            ));
      },
    );
  }
}
