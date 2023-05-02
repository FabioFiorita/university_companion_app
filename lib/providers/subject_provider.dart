import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/exceptions/user_exception.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../service/subject_service.dart';

class SubjectProvider extends ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  Future<void> getSubjects(User? user) async {
    if (user == null) {
      throw UserException.userNotFound;
    }
    final SubjectService subjectService = SubjectService();
    try {
      final List<Subject> subjects = await subjectService.getSubjects(user);
      if (subjects.isEmpty) {
        throw SubjectException.subjectNotFound;
      }
      _subjects = subjects;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
