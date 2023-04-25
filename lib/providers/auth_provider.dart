import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuth = false;

  bool get isAuth => _isAuth;

  setAuth(bool isAuth) {
    _isAuth = isAuth;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("isAuth", isAuth);
    });
    notifyListeners();
  }

  Future<void> initAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isAuth = prefs.getBool("isAuth")!;
    notifyListeners();
  }
}