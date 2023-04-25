import 'package:c317_mobile/models/user.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  final SharedPreferences _prefs;

  _UserStore(this._prefs) {
    initUser();
  }

  @observable
  User? user;

  @computed
  bool get isLoggedIn => user != null;

  @action
  setUser(User user) {
    this.user = user;
    _prefs.setString("accessToken", user.accessToken);
    _prefs.setString("id", user.id.toString());
    _prefs.setString("email", user.email);
    _prefs.setString("name", user.name);
    _prefs.setString("course", user.course);
    _prefs.setString("enrollmentNumber", user.enrollmentNumber);
  }

  @action
  clearUser() {
    user = null;
    _prefs.remove("accessToken");
    _prefs.remove("id");
    _prefs.remove("email");
    _prefs.remove("name");
    _prefs.remove("course");
    _prefs.remove("enrollmentNumber");
  }

  @action
  Future<void> initUser() async {
    user = User(
      id: int.parse(_prefs.getString("id")!),
      email: _prefs.getString("email")!,
      accessToken: _prefs.getString("accessToken")!,
      name: _prefs.getString("name")!,
      course: _prefs.getString("course")!,
      enrollmentNumber: _prefs.getString("enrollmentNumber")!,
    );
  }
}
