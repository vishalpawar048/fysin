// import 'package:flutter/material.dart';
// import 'package:flutter_scaffold/models/user.dart';
// import 'package:flutter_scaffold/services/auth_service.dart';

// class AuthBlock extends ChangeNotifier {
//   AuthBlock() {
//     setUser();
//   }
//   AuthService _authService = AuthService();
//   // Index
//   int _currentIndex = 1;
//   int get currentIndex => _currentIndex;
//   set currentIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }

//   // Loading
//   bool _loading = false;
//   String _loadingType;
//   bool get loading => _loading;
//   String get loadingType => _loadingType;
//   set loading(bool loadingState) {
//     _loading = loadingState;
//     notifyListeners();
//   }
//   set loadingType(String loadingType) {
//     _loadingType = loadingType;
//     notifyListeners();
//   }
//   // Loading
//   bool _isLoggedIn = false;
//   bool get isLoggedIn => _isLoggedIn;
//   set isLoggedIn(bool isUserExist) {
//     _isLoggedIn = isUserExist;
//     notifyListeners();
//   }

//   // user
//   Map _user = {};
//   Map get user => _user;
//   setUser() async {
//     _user = await _authService.getUser();
//     isLoggedIn = _user == null ? false : true;
//     notifyListeners();
//   }

//   login(UserCredential userCredential) async {
//     loading = true;
//     loadingType = 'login';
//     await _authService.login(userCredential);
//     setUser();
//     loading = false;
//   }

//   register(User user) async {
//     loading = true;
//     loadingType = 'register';
//     await _authService.register(user);
//     loading = false;
//   }

//   logout() async {
//     await _authService.logout();
//     isLoggedIn = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBlock extends ChangeNotifier {
  bool _isLoggedIn = false;
  String emialId;

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
      emialId = _googleSignIn.currentUser.email;
      Navigator.of(context).pop();
      prefs?.setBool("isLoggedIn", true);
      prefs?.setString("emailId", emialId);
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
