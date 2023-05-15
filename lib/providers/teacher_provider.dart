import 'package:flutter/material.dart';

import '../exceptions/teacher_exception.dart';
import '../exceptions/user_exception.dart';
import '../models/teacher.dart';
import '../models/user.dart';
import '../service/teacher_service.dart';

class TeacherProvider extends ChangeNotifier {
  List<Teacher> _teachers = [];

  List<Teacher> get teachers => _teachers;

  final User? user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  TeacherProvider(this.user) {
    getTeachers();
  }

  Future<void> getTeachers() async {
    _isLoading = true;
    notifyListeners();
    if (_teachers.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    final TeacherService teacherService = TeacherService();
    try {
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        throw UserException.userNotFound;
      }
      final List<Teacher> teachers = await teacherService.getTeachers(user!);
      _isLoading = false;
      if (teachers.isEmpty) {
        throw TeacherException.teacherNotFound;
      }
      _teachers = teachers;
      notifyListeners();
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cleanCache() async {
    _teachers = [];
    await getTeachers();
  }
}
