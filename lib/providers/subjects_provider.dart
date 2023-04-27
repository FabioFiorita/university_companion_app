import 'package:c317_mobile/models/subject.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../service/subject_service.dart';

class SubjectsProvider extends ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  Future<bool> getSubjects(User? user) async {
    if (user == null) {
      return false;
    }
    final SubjectService subjectService = SubjectService();
    final List<Subject> subjects = await subjectService.getSubjects(user);
    if (subjects.isEmpty) {
      return false;
    }
    _subjects = subjects;
    notifyListeners();
    return true;
  }
}
