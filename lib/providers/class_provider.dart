import 'package:c317_mobile/exceptions/general_exception.dart';
import 'package:flutter/cupertino.dart';

import '../exceptions/class_exception.dart';
import '../exceptions/user_exception.dart';
import '../models/class.dart';
import '../models/user.dart';
import '../service/class_service.dart';

class ClassProvider extends ChangeNotifier {
  List<Class> _classes = [];

  List<Class> get classes => _classes;

  final User? user;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Object? _error;

  Object? get error => _error;

  ClassProvider(this.user) {
    getClasses();
  }

  Future<void> getClasses() async {
    try {
      _isLoading = true;
      if (_classes.isNotEmpty) {
        _isLoading = false;
        return;
      }
      if (user == null) {
        _isLoading = false;
        throw UserException.userNotFound;
      }
      final ClassService classService = ClassService();
      final List<Class> classes = await classService.getClasses(user!);
      if (classes.isEmpty) {
        _isLoading = false;
        throw ClassException.classNotFound;
      }
      _isLoading = false;
      _classes = classes;
      notifyListeners();
    } catch (e) {
      _error = e;
      _isLoading = false;
      notifyListeners();
    }
  }

  cleanClasses() {
    _classes = [];
  }
}
