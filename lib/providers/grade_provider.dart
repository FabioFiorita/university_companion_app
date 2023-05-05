import 'package:c317_mobile/exceptions/grade_exception.dart';
import 'package:flutter/cupertino.dart';

import '../exceptions/user_exception.dart';
import '../models/grade.dart';
import '../models/user.dart';
import '../service/grade_service.dart';

class GradeProvider extends ChangeNotifier {
  List<Grade> _grades = [];

  List<Grade> get grades => _grades;

  final User? user;

  GradeProvider(this.user);

  Future<void> getGrades() async {
    if (_grades.isNotEmpty) {
      return;
    }
    if (user == null) {
      throw UserException.userNotFound;
    }
    final GradeService gradeService = GradeService();
    try {
      final List<Grade> grades = await gradeService.getGrades(user!);
      if (grades.isEmpty) {
        throw GradeException.gradeNotFound;
      }
      _grades = grades;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
