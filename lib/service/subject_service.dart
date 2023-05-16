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
  TeacherService teacherService = TeacherService();

  Future<List<Subject>> getSubjects(User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}student/${user.id}"), headers: {
        "Authorization": "Bearer ${user.accessToken}",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, SubjectException.subjectNotFound);
      }

      return saveInfoFromResponse(response.body, user);
    } catch (e) {
      rethrow;
    }
  }

  Future<Subject?> getSubjectById(String id, User user) async {
    try {
      http.Response response = await client
          .get(Uri.parse("${WebClient.baseUrl}subject/$id"), headers: {
        "Authorization": "Bearer ${user.accessToken}",
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        print("Status code: ${response.statusCode}");
        print("Body: ${response.body}");
        ResponseHandler.handleStatusCode(
            response.statusCode, SubjectException.subjectNotFound);
      }

      final jsonResponse = jsonDecode(response.body);
      print("Json response: $jsonResponse");
      final List<dynamic> students = jsonResponse["students"];
      print("Students: $students");
      bool isEnrolled =
          students.where((element) => element["id"] == user.id).isNotEmpty;
      if (isEnrolled) {
        print("Subject found and student is enrolled");
        return Subject.fromJson(
            jsonResponse,
            await teacherService.getTeacherById(
                jsonResponse['professor']["id"], user));
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Subject>> saveInfoFromResponse(String body, User user) async {
    final List<dynamic> decodedJson = jsonDecode(body)['subjects'];
    final List<Subject> subjects = [];

    for (final subject in decodedJson) {
      final teacherId = subject['professor_id'];
      final teacher = await teacherService.getTeacherById(teacherId, user);
      final newSubject = Subject.fromJson(subject, teacher);
      subjects.add(newSubject);
    }

    return subjects;
  }
}
