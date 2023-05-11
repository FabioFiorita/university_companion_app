import 'dart:convert';

import 'package:c317_mobile/exceptions/subject_exception.dart';
import 'package:c317_mobile/models/subject.dart';
import 'package:c317_mobile/service/teacher_service.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class SubjectService {
  http.Client client = WebClient().client;
  final TeacherService teacherService = TeacherService();

  Future<List<Subject>> getSubjects(User user) async {
    try {
      http.Response response = await client.get(
          Uri.parse("${WebClient.baseUrl}users/${user.id}/subjects"),
          headers: {
            "Authorization": "Bearer ${user.accessToken}",
          }).timeout(const Duration(seconds: 5));
      // Uri.parse("${WebClient.baseUrl}subject"),
      // headers: {
      //   "content-type": "application/json",
      // }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, SubjectException.subjectNotFound);
      }

      return saveInfoFromResponse(response.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Subject> getSubjectById(int id, User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}subjects/$id"), headers: {
        "Authorization": "Bearer ${user.accessToken}",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, SubjectException.subjectNotFound);
      }

      final jsonResponse = jsonDecode(response.body);

      return Subject.fromJson(jsonResponse,
          await teacherService.getTeacherById(jsonResponse['teacherId']));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Subject>> saveInfoFromResponse(String body) async {
    final List<dynamic> decodedJson = jsonDecode(body);
    final List<Subject> subjects = [];

    for (final subject in decodedJson) {
      final teacherId = subject['teacherId'];
      final teacher = await teacherService.getTeacherById(teacherId);
      final newSubject = Subject.fromJson(subject, teacher);
      subjects.add(newSubject);
    }

    return subjects;
  }
}
