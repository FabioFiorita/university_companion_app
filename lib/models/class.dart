import 'package:c317_mobile/models/subject.dart';
import 'package:c317_mobile/models/teacher.dart';

class Class {
  final int id;
  final String date;
  final String location;
  final Subject subject;
  final Teacher teacher;

  Class({
    required this.id,
    required this.date,
    required this.location,
    required this.subject,
    required this.teacher,
  });

  factory Class.fromJson(
      Map<String, dynamic> json, Subject subject, Teacher teacher) {
    return Class(
      id: json['id'],
      date: json['date'],
      location: json['location'],
      subject: subject,
      teacher: teacher,
    );
  }
}
