class UserNotFoundException implements Exception {
  String cause;

  UserNotFoundException({this.cause = "User not found"});

  @override
  String toString() {
    return cause;
  }
}
