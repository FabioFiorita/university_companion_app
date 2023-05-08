import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../service/subject_service.dart';

class SubjectProvider extends ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  final User? user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  SubjectProvider(this.user) {
    getSubjects();
  }

  Future<void> getSubjects() async {
    _isLoading = true;
    if (_subjects.isNotEmpty) {
      _isLoading = false;
      return;
    }
    if (user == null) {
      _isLoading = false;
      throw UserException.userNotFound;
    }
    final SubjectService subjectService = SubjectService();
    try {
      final List<Subject> subjects = await subjectService.getSubjects(user!);
      _isLoading = false;
      if (subjects.isEmpty) {
        throw SubjectException.subjectNotFound;
      }
      _subjects = subjects;
      notifyListeners();
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cleanCache() async {
    _subjects = [];
    await getSubjects();
  }
}
