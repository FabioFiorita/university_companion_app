import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  UserProvider(this._prefs) {
    initUser();
  }

  setUser(User user) {
    _user = user;
    _prefs.setString("accessToken", user.accessToken);
    _prefs.setString("id", user.id.toString());
    _prefs.setString("email", user.email);
    _prefs.setString("name", user.name);
    _prefs.setString("course", user.course);
    _prefs.setString("enrollmentNumber", user.enrollmentNumber);
  }

  clearUser() {
    _user = null;
    _prefs.remove("accessToken");
    _prefs.remove("id");
    _prefs.remove("email");
    _prefs.remove("name");
    _prefs.remove("course");
    _prefs.remove("enrollmentNumber");
  }

  Future<void> initUser() async {
    User user = User(
      id: int.parse(_prefs.getString("id") ?? '0'),
      email: _prefs.getString("email") ?? '',
      accessToken: _prefs.getString("accessToken") ?? '',
      name: _prefs.getString("name") ?? '',
      course: _prefs.getString("course") ?? '',
      enrollmentNumber: _prefs.getString("enrollmentNumber") ?? '',
    );
    if (user.accessToken.isNotEmpty) {
      _user = user;
    } else {
      _user = null;
    }
  }
}
