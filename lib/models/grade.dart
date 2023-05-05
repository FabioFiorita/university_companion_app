import 'package:c317_mobile/models/subject.dart';

class Grade {
  final int id;
  final String code;
  final int grade;
  final Subject subject;

  Grade({
    required this.id,
    required this.code,
    required this.grade,
    required this.subject,
  });

  factory Grade.fromJson(Map<String, dynamic> json, Subject subject) {
    return Grade(
      id: json['id'],
      code: json['code'],
      grade: json['grade'],
      subject: subject,
    );
  }
}
