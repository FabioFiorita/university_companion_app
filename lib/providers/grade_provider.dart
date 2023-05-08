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

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  GradeProvider(this.user) {
    getGrades();
  }

  Future<void> getGrades() async {
    _isLoading = true;
    if (_grades.isNotEmpty) {
      _isLoading = false;
      return;
    }
    if (user == null) {
      _isLoading = false;
      throw UserException.userNotFound;
    }
    final GradeService gradeService = GradeService();
    try {
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
}
