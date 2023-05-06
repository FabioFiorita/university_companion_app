import 'package:flutter/material.dart';

import '../exceptions/teacher_exception.dart';
import '../models/teacher.dart';
import '../service/teacher_service.dart';

class TeacherProvider extends ChangeNotifier {
  List<Teacher> _teachers = [];

  List<Teacher> get teachers => _teachers;

  TeacherProvider() {
    getTeachers();
  }

  Future<void> getTeachers() async {
    if (_teachers.isNotEmpty) {
      return;
    }
    final TeacherService teacherService = TeacherService();
    try {
      final List<Teacher> teachers = await teacherService.getTeachers();
      if (teachers.isEmpty) {
        throw TeacherException.teacherNotFound;
      }
      _teachers = teachers;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
