import 'package:flutter/cupertino.dart';

import '../exceptions/class_exception.dart';
import '../exceptions/user_exception.dart';
import '../models/class.dart';
import '../models/user.dart';
import '../service/class_service.dart';

class ClassProvider extends ChangeNotifier {
  List<Class> _classes = [];

  List<Class> get classes => _classes;

  Future<void> getClasses(User? user) async {
    if (user == null) {
      throw UserException.userNotFound;
    }
    final ClassService classService = ClassService();
    try {
      final List<Class> classes = await classService.getClasses(user);
      if (classes.isEmpty) {
        throw ClassException.classNotFound;
      }
      _classes = classes;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
