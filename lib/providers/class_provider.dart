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

  ClassProvider(this.user) {
    getClasses();
  }

  Future<void> getClasses() async {
    if (_classes.isNotEmpty) {
      return;
    }
    if (user == null) {
      throw UserException.userNotFound;
    }
    final ClassService classService = ClassService();
    try {
      final List<Class> classes = await classService.getClasses(user!);
      if (classes.isEmpty) {
        throw ClassException.classNotFound;
      }
      _classes = classes;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  cleanClasses() {
    _classes = [];
  }
}
