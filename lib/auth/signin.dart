// import 'package:flutter/material.dart';
// import 'package:flutter_scaffold/blocks/auth_block.dart';
// import 'package:flutter_scaffold/models/user.dart';
// import 'package:provider/provider.dart';

// class SignIn extends StatefulWidget {
//   @override
//   _SignInState createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   final _formKey = GlobalKey<FormState>();
//   final UserCredential userCredential = UserCredential();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: TextFormField(
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'Please Enter Email or Username';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         setState(() {
//                           userCredential.usernameOrEmail = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Enter Username Or Email',
//                         labelText: 'Email',
//                       ),
//                     ),
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'Please Enter Password';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       setState(() {
//                         userCredential.password = value;
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Enter Password',
//                       labelText: 'Password',
//                     ),
//                     obscureText: true,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 25.0),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: Consumer<AuthBlock>(
//                         builder:
//                             (BuildContext context, AuthBlock auth, Widget child) {
//                           return RaisedButton(
//                             color: Theme.of(context).primaryColor,
//                             textColor: Colors.white,
//                             child: auth.loading && auth.loadingType == 'login' ? CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                             ) : Text('Sign In'),
//                             onPressed: () {
//                               // Validate form
//                               if (_formKey.currentState.validate() && !auth.loading) {
//                                 // Update values
//                                 _formKey.currentState.save();
//                                 // Hit Api
//                                 auth.login(userCredential);
//                               }
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//     );
//   }
// }

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: _isLoggedIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(
                      _googleSignIn.currentUser.photoUrl,
                      height: 50.0,
                      width: 50.0,
                    ),
                    Text(_googleSignIn.currentUser.displayName),
                    OutlineButton(
                      child: Text("Logout"),
                      onPressed: () {
                        _logout();
                      },
                    )
                  ],
                )
              : Container(
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
                      onPressed: () => _login(),
                    ),
                  )),
        ),
      ),
    );
  }
}
