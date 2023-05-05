import 'dart:convert';

import 'package:c317_mobile/exceptions/class_exception.dart';
import 'package:c317_mobile/models/class.dart';
import 'package:c317_mobile/service/subject_service.dart';
import 'package:c317_mobile/service/teacher_service.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class ClassService {
  http.Client client = WebClient().client;
  SubjectService subjectService = SubjectService();
  TeacherService teacherService = TeacherService();

  Future<List<Class>> getClasses(User user) async {
    try {
      http.Response response = await client.get(
          Uri.parse("${WebClient.baseUrl}users/${user.id}/classes"),
          headers: {
            "Authorization": "Bearer ${user.accessToken}",
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ClassException.classNotFound);
      }

      return saveInfoFromResponse(response.body, user);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Class>> saveInfoFromResponse(String body, User user) async {
    final List<Class> classes = [];

    for (final c in jsonDecode(body)) {
      final subject = await subjectService.getSubjectById(c['subjectId'], user);
      final teacher = await teacherService.getTeacherById(c['teacherId']);
      classes.add(Class.fromJson(c, subject, teacher));
    }

    return classes;
  }
}
