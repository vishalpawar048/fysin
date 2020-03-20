import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlock extends ChangeNotifier {
  bool _isLoggedIn = false;
  String emailId;

  bool get isLoggedIn => _isLoggedIn;

  set isLoggedIn(bool islogin) {
    _isLoggedIn = islogin;
    notifyListeners();
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  login(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await _googleSignIn.signIn();
      isLoggedIn = true;
      emailId = _googleSignIn.currentUser.email;
      Navigator.of(context).pop();
      prefs?.setBool("isLoggedIn", true);
      prefs?.setString("emailId", emailId);
    } catch (err) {
      isLoggedIn = false;
      print(err);
    }
  }

  logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.setBool("isLoggedIn", false);
    prefs?.setString("emailId", "false");
    _googleSignIn.signOut();
    Navigator.pushNamed(context, '/');
  }
}
