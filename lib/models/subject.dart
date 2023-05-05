import 'package:c317_mobile/models/teacher.dart';

class Subject {
  final int id;
  final String name;
  final String code;
  final Teacher teacher;

  Subject({
    required this.id,
    required this.name,
    required this.code,
    required this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json, Teacher teacher) {
    return Subject(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      teacher: teacher,
    );
  }
}
