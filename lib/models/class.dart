import 'package:c317_mobile/models/subject.dart';
import 'package:c317_mobile/models/teacher.dart';

class Class {
  final int id;
  final String day;
  final String time;
  final Subject subject;

  Class({
    required this.id,
    required this.day,
    required this.time,
    required this.subject,
  });

  factory Class.fromJson(Map<String, dynamic> json, Subject subject) {
    return Class(
      id: json['id'],
      day: json['day'],
      time: json['time'],
      subject: subject,
    );
  }
}
