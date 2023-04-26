import 'package:c317_mobile/models/subject.dart';
import 'package:flutter/material.dart';

import '../service/subject_service.dart';

class SubjectsProvider extends ChangeNotifier {
  List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  setSubjects(List<Subject> subjects) {
    _subjects = subjects;
    notifyListeners();
  }

  Future<bool> getSubjects(BuildContext context) async {
    final SubjectService subjectService = SubjectService(context: context);
    final bool result = await subjectService.getSubjects();
    notifyListeners();
    return result;
  }
}
