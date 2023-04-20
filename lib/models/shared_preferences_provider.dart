import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  SharedPreferences? prefs;
  SharedPreferencesProvider() {
    _init();
  }

  Future<void> _init() async {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      notifyListeners();
    });
  }
}