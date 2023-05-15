import 'package:c317_mobile/models/subject.dart';

class Exam {
  final int id;
  final String code;
  final int grade;
  final Subject subject;

  Exam({
    required this.id,
    required this.code,
    required this.grade,
    required this.subject,
  });

  factory Exam.fromJson(Map<String, dynamic> json, int grade, Subject subject) {
    return Exam(
      id: json['id'],
      code: json['code'],
      grade: grade,
      subject: subject,
    );
  }
}
