import 'package:c317_mobile/service/user_service.dart';
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

  setUser(User user) async {
    _user = user;
    _prefs.setString("accessToken", user.accessToken);
    _prefs.setString("id", user.id.toString());
    _prefs.setString("email", user.email);
    _prefs.setString("name", user.name);
    _prefs.setString("course", user.course);
    _prefs.setString("enrollmentNumber", user.enrollmentNumber);
    setLastLoginTimestamp();
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    UserService authService = UserService();
    try {
      final User user = await authService.login(email, password);
      setUser(user);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  clearUser() {
    _user = null;
    notifyListeners();
    _prefs.remove("accessToken");
    _prefs.remove("id");
    _prefs.remove("email");
    _prefs.remove("name");
    _prefs.remove("course");
    _prefs.remove("enrollmentNumber");
    _prefs.remove("lastLoginTimestamp");
  }

  Future<void> initUser() async {
    final int? lastLoginTimestamp = _prefs.getInt("lastLoginTimestamp");
    if (lastLoginTimestamp != null) {
      if (DateTime.now().millisecondsSinceEpoch - lastLoginTimestamp >
          3600000) {
        clearUser();
      }
    }
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
    notifyListeners();
  }

  Future<void> setLastLoginTimestamp() async {
    _prefs.setInt("lastLoginTimestamp", DateTime.now().millisecondsSinceEpoch);
  }
}
