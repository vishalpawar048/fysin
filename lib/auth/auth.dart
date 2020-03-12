// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_scaffold/blocks/auth_block.dart';
// import 'signin.dart';
// import 'signup.dart';

// class Auth extends StatelessWidget {
//   final List<Widget> tabs = [
//     SignIn(),
//     SignUp()
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final AuthBlock authBlock = Provider.of<AuthBlock>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(authBlock.currentIndex == 0 ? 'Sign In' : 'Create Account'),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.lock_open),
//             title: Text('Sign In'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people_outline),
//             title: Text('Create Account'),
//           ),
//         ],
//         currentIndex: authBlock.currentIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: (num){
//            authBlock.currentIndex = num;
//         },
//       ),
//       body: tabs[authBlock.currentIndex],
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter_scaffold/blocks/auth_block.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

// class Auth extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _AuthState();
//   }
// }

class Auth extends StatelessWidget {
  // bool _isLoggedIn = false;
  // bool get isLoggedIn => _isLoggedIn;
  // set isLoggedIn(bool _isLoggedIn) {
  //   _isLoggedIn = _isLoggedIn;
  //   // notifyListeners();
  // }

  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // _login() async {
  //   try {
  //     await _googleSignIn.signIn();
  //     // print(">>>>>>>>>>${json.decode(_googleSignIn.currentUser)}");
  //     setState(() {
  //       _isLoggedIn = true;
  //     });
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  // _logout() {
  //   _googleSignIn.signOut();
  //   setState(() {
  //     _isLoggedIn = false;
  //   });
  // }

  returnToPage(context) async {
    return await Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    AuthBlock auth = Provider.of<AuthBlock>(context);
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[100],
        body: Center(
          child: auth.isLoggedIn
              ? null
              : Container(
                  margin: const EdgeInsets.only(bottom: 1.0),
                  width: 250.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Color(0xffffffff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Color(0xffCE107C),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'Sign in with Google',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      onPressed: () => auth.login(context),
                    ),
                  )),
        ),
      ),
    );
  }
}
