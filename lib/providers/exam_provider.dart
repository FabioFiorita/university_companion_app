import 'package:c317_mobile/exceptions/exam_exception.dart';
import 'package:flutter/cupertino.dart';

import '../exceptions/user_exception.dart';
import '../models/exam.dart';
import '../models/subject.dart';
import '../models/user.dart';
import '../service/exam_service.dart';

class ExamProvider extends ChangeNotifier {
  List<Exam> _grades = [];

  List<Exam> get grades => _grades;

  List<Exam> simulatedGrades = [];

  final User? user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  ExamProvider(this.user) {
    getExams();
  }

  Future<void> getExams() async {
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
      final ExamService gradeService = ExamService();
      final List<Exam> grades = await gradeService.getExams(user!);
      _isLoading = false;
      if (grades.isEmpty) {
        throw ExamException.gradeNotFound;
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
    await getExams();
  }

  toggleExamSimulation() {
    simulatedGrades = _grades.toList();
    notifyListeners();
  }

  bool addSimulatedExam(String code, int value, Subject subject) {
    if (code.isEmpty || value < 0 || value > 100) {
      return false;
    }
    if (_grades.any((grade) => grade.code == code)) {
      return false;
    }
    final Exam newGrade = Exam(
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
