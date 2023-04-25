import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  setUser(User user) {
    _user = user;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("accessToken", user.accessToken);
      prefs.setString("id", user.id.toString());
      prefs.setString("email", user.email);
      prefs.setString("name", user.name);
      prefs.setString("course", user.course);
      prefs.setString("enrollmentNumber", user.enrollmentNumber);
    });
    notifyListeners();
  }

  clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> initUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _user = User(
      id: int.parse(prefs.getString("id")!),
      email: prefs.getString("email")!,
      accessToken: prefs.getString("accessToken")!,
      name: prefs.getString("name")!,
      course: prefs.getString("course")!,
      enrollmentNumber: prefs.getString("enrollmentNumber")!,
    );
    notifyListeners();
  }

}