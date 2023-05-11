import 'package:c317_mobile/exceptions/grade_exception.dart';
import 'package:flutter/cupertino.dart';

import '../exceptions/user_exception.dart';
import '../models/grade.dart';
import '../models/subject.dart';
import '../models/user.dart';
import '../service/grade_service.dart';

class GradeProvider extends ChangeNotifier {
  List<Grade> _grades = [];

  List<Grade> get grades => _grades;

  List<Grade> simulatedGrades = [];

  final User? user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  GradeProvider(this.user) {
    getGrades();
  }

  Future<void> getGrades() async {
    _isLoading = true;
    notifyListeners();
    if (_grades.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    try {
      if (user == null) {
        _isLoading = false;
        throw UserException.userNotFound;
      }
      final GradeService gradeService = GradeService();
      final List<Grade> grades = await gradeService.getGrades(user!);
      _isLoading = false;
      if (grades.isEmpty) {
        throw GradeException.gradeNotFound;
      }
      _grades = grades;
      notifyListeners();
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetCache() async {
    _grades = [];
    await getGrades();
  }

  toggleGradeSimulation() {
    simulatedGrades = _grades.toList();
    notifyListeners();
  }

  bool addSimulatedGrade(String code, int value, Subject subject) {
    if (code.isEmpty || value < 0 || value > 100) {
      return false;
    }
    if (_grades.any((grade) => grade.code == code)) {
      return false;
    }
    final Grade newGrade = Grade(
      id: 0,
      code: code,
      grade: value,
      subject: subject,
    );
    simulatedGrades.add(newGrade);
    notifyListeners();
    return true;
  }
}
