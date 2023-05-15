import 'package:c317_mobile/models/teacher.dart';

class Subject {
  final String id;
  final String name;
  final Teacher teacher;

  Subject({
    required this.id,
    required this.name,
    required this.teacher,
  });

  factory Subject.fromJson(Map<String, dynamic> json, Teacher teacher) {
    return Subject(
      id: json['id'],
      name: json['name'],
      teacher: teacher,
    );
  }
}
