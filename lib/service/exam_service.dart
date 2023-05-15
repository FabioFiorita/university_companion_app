import 'dart:convert';

import 'package:c317_mobile/exceptions/exam_exception.dart';
import 'package:c317_mobile/models/exam.dart';
import 'package:c317_mobile/service/subject_service.dart';
import 'package:http/http.dart' as http;

import '../http/web_client.dart';
import '../models/subject.dart';
import '../models/user.dart';
import '../utils/response_handler.dart';

class ExamService {
  http.Client client = WebClient().client;
  final SubjectService subjectService = SubjectService();

  Future<List<Exam>> getExams(User user) async {
    try {
      http.Response response = await client.get(
          Uri.parse("${WebClient.baseUrl}users/${user.id}/grades"),
          headers: {
            "Authorization": "Bearer ${user.accessToken}",
          }).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) {
        ResponseHandler.handleStatusCode(
            response.statusCode, ExamException.gradeNotFound);
      }

      return saveInfoFromResponse(response.body, user);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Exam>> saveInfoFromResponse(String body, User user) async {
    final List<Exam> grades = [];

    for (final grade in jsonDecode(body)) {
      final Subject subject =
          await subjectService.getSubjectById(grade['subjectId'], user);
      final newGrade = Exam.fromJson(grade, subject);
      grades.add(newGrade);
    }

    return grades;
  }
}
