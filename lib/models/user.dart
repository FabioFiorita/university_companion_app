class User {
  final String email;
  final String accessToken;
  final String name;
  final String course;
  final String enrollmentNumber;

  User({
    required this.email,
    required this.accessToken,
    required this.name,
    required this.course,
    required this.enrollmentNumber,
  });

  factory User.fromJson(Map<String, dynamic> json, String accessToken) {
    return User(
      email: json['email'],
      accessToken: accessToken,
      name: json['name'],
      course: json['course'],
      enrollmentNumber: json['enrollmentNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': accessToken,
        'name': name,
        'course': course,
        'enrollment_number': enrollmentNumber,
      };
}
