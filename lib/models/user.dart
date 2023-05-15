class User {
  final int id;
  final String email;
  final String accessToken;
  final String name;

  //final String course;

  User({
    required this.id,
    required this.email,
    required this.accessToken,
    required this.name,
    //required this.course,
  });

  factory User.fromJson(Map<String, dynamic> json, String accessToken) {
    return User(
      id: json['id'],
      email: json['email'],
      accessToken: accessToken,
      name: json['name'],
      //course: json['course'],
    );
  }
}
