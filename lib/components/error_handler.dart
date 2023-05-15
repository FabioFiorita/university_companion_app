import 'package:flutter/material.dart';

import '../exceptions/class_exception.dart';
import '../exceptions/contact_exception.dart';
import '../exceptions/general_exception.dart';
import '../exceptions/exam_exception.dart';
import '../exceptions/subject_exception.dart';
import '../exceptions/teacher_exception.dart';
import '../exceptions/user_exception.dart';
import 'error_message.dart';

class ErrorHandler extends StatelessWidget {
  final Object error;

  const ErrorHandler({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _switchError(error);
  }

  Widget _switchError(Object e) {
    if (e is ClassException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is ContactException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is ExamException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is SubjectException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is TeacherException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is UserException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    if (e is GeneralException) {
      return ErrorMessage(
        title: e.title,
        message: e.message,
      );
    }
    return const ErrorMessage();
  }
}
